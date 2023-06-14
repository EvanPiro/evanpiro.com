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
        , description = "Forward Thinking Engineer, Avid Technologist currently providing services for planning and building your next great project."
        , startUrl = Route.Index |> Route.toPath
        , icons =
            [ { src = Pages.Url.fromPath <| Path.fromString "/Evan-Logo-Large.png"
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
