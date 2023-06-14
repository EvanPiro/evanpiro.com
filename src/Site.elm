module Site exposing (config)

import DataSource
import Head
import Head.Seo as Seo
import Pages.Manifest as Manifest exposing (IconPurpose(..))
import Pages.Url
import Path
import Route
import SiteConfig exposing (SiteConfig)
import StaticContent exposing (siteTag)


type alias Data =
    ()


config : SiteConfig Data
config =
    { data = data
    , canonicalUrl = "https://evanpiro.com"
    , manifest = manifest
    , head = head
    }


data : DataSource.DataSource Data
data =
    DataSource.succeed ()


head : Data -> List Head.Tag
head static =
    Seo.summaryLarge
        { canonicalUrlOverride = Nothing
        , siteName = "Evan Piro"
        , image =
            { url = Pages.Url.fromPath <| Path.fromString "/Evan-Logo-Large.png"
            , alt = "Evan Piro Logo"
            , mimeType = Just "image/png"
            , dimensions = Just { width = 162, height = 162 }
            }
        , description = siteTag
        , locale = Nothing
        , title = "Evan Piro"
        }
        |> Seo.article
            { tags = []
            , section = Nothing
            , publishedTime = Nothing
            , modifiedTime = Nothing
            , expirationTime = Nothing
            }


manifest : Data -> Manifest.Config
manifest static =
    Manifest.init
        { name = "Evan Piro"
        , description = siteTag
        , startUrl = Route.Index |> Route.toPath
        , icons =
            [ { src = Pages.Url.fromPath <| Path.fromString "/Evan-Logo-Larger.png"
              , sizes = [ ( 478, 478 ) ]
              , mimeType = Nothing
              , purposes = [ IconPurposeAny ]
              }
            , { src = Pages.Url.fromPath <| Path.fromString "/Evan-Logo-Large.png"
              , sizes = [ ( 162, 162 ) ]
              , mimeType = Nothing
              , purposes = [ IconPurposeAny ]
              }
            , { src = Pages.Url.fromPath <| Path.fromString "/favicon.png"
              , sizes = [ ( 16, 16 ) ]
              , mimeType = Nothing
              , purposes = [ IconPurposeAny ]
              }
            ]
        }
