module Page.Index exposing (Data, Model, Msg, page)

import DataSource exposing (DataSource)
import DataSource.File as File exposing (rawFile)
import Head
import Head.Seo as Seo
import Html exposing (Html)
import Markdown.Parser
import Markdown.Renderer
import Page exposing (Page, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Path
import Shared
import StaticContent exposing (siteTag)
import View exposing (View)


type alias Model =
    ()


type alias Msg =
    Never


type alias RouteParams =
    {}


page : Page RouteParams Data
page =
    Page.single
        { head = head
        , data =
            data
        }
        |> Page.buildNoState { view = view }


data : DataSource Data
data =
    rawFile "content/index.md"
        |> DataSource.andThen markdownToHtml


markdownToHtml :
    String
    -> DataSource Data
markdownToHtml markdownString =
    markdownString
        |> Markdown.Parser.parse
        |> Result.mapError (\_ -> "Markdown error.")
        |> Result.andThen
            (\blocks ->
                Markdown.Renderer.render
                    Markdown.Renderer.defaultHtmlRenderer
                    blocks
            )
        |> DataSource.fromResult


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "evanpiro.com"
        , image =
            { url = Pages.Url.fromPath <| Path.fromString "/Evan-Logo-Large.png"
            , alt = "evanpiro.com logo"
            , dimensions = Just { width = 162, height = 162 }
            , mimeType = Just "image/png"
            }
        , description = siteTag
        , locale = Nothing
        , title = "Evan Piro" -- metadata.title -- TODO
        }
        |> Seo.website


type alias Data =
    List (Html Msg)


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    View.readme static.data
