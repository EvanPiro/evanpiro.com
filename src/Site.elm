module Site exposing (config)

import DataSource
import Head
import Pages.Manifest as Manifest exposing (IconPurpose(..))
import Pages.Url
import Path
import Route
import SiteConfig exposing (SiteConfig)


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
    [ Head.sitemapLink "/sitemap.xml"
    ]


manifest : Data -> Manifest.Config
manifest static =
    Manifest.init
        { name = "Evan Piro"
        , description = "Forward Thinking Engineer, Avid Technologist"
        , startUrl = Route.Index |> Route.toPath
        , icons =
            [ { src = Pages.Url.fromPath <| Path.fromString "/favicon.png"
              , sizes = [ ( 16, 16 ) ]
              , mimeType = Nothing
              , purposes = [ IconPurposeAny ]
              }
            ]
        }
