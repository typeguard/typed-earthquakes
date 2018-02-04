-- To decode the JSON data, add this file to your project, run
--
--     elm-package install NoRedInk/elm-decode-pipeline
--
-- add these imports
--
--     import Json.Decode exposing (decodeString)`);
--     import QuickType exposing (earthquakes)
--
-- and you're off to the races with
--
--     decodeString earthquakes myJsonString

module QuickType exposing
    ( Earthquakes
    , earthquakesToString
    , earthquakes
    , Feature
    , Geometry
    , Properties
    , Metadata
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict, map, toList)
import Array exposing (Array, map)

type alias Earthquakes =
    { purpleType : String
    , metadata : Metadata
    , features : Array Feature
    , bbox : Array Float
    }

type alias Feature =
    { purpleType : String
    , properties : Properties
    , geometry : Geometry
    , id : String
    }

type alias Geometry =
    { purpleType : String
    , coordinates : Array Float
    }

type alias Properties =
    { mag : Float
    , place : String
    , time : Int
    , updated : Int
    , tz : Int
    , url : String
    , detail : String
    , felt : ()
    , cdi : ()
    , mmi : ()
    , alert : ()
    , status : String
    , tsunami : Int
    , sig : Int
    , net : String
    , code : String
    , ids : String
    , sources : String
    , types : String
    , nst : Int
    , dmin : Float
    , rms : Float
    , gap : Int
    , magType : String
    , purpleType : String
    , title : String
    }

type alias Metadata =
    { generated : Int
    , url : String
    , title : String
    , status : Int
    , api : String
    , count : Int
    }

-- decoders and encoders

earthquakesToString : Earthquakes -> String
earthquakesToString r = Jenc.encode 0 (encodeEarthquakes r)

earthquakes : Jdec.Decoder Earthquakes
earthquakes =
    Jpipe.decode Earthquakes
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "metadata" metadata
        |> Jpipe.required "features" (Jdec.array feature)
        |> Jpipe.required "bbox" (Jdec.array Jdec.float)

encodeEarthquakes : Earthquakes -> Jenc.Value
encodeEarthquakes x =
    Jenc.object
        [ ("type", Jenc.string x.purpleType)
        , ("metadata", encodeMetadata x.metadata)
        , ("features", makeArrayEncoder encodeFeature x.features)
        , ("bbox", makeArrayEncoder Jenc.float x.bbox)
        ]

feature : Jdec.Decoder Feature
feature =
    Jpipe.decode Feature
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "properties" properties
        |> Jpipe.required "geometry" geometry
        |> Jpipe.required "id" Jdec.string

encodeFeature : Feature -> Jenc.Value
encodeFeature x =
    Jenc.object
        [ ("type", Jenc.string x.purpleType)
        , ("properties", encodeProperties x.properties)
        , ("geometry", encodeGeometry x.geometry)
        , ("id", Jenc.string x.id)
        ]

geometry : Jdec.Decoder Geometry
geometry =
    Jpipe.decode Geometry
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "coordinates" (Jdec.array Jdec.float)

encodeGeometry : Geometry -> Jenc.Value
encodeGeometry x =
    Jenc.object
        [ ("type", Jenc.string x.purpleType)
        , ("coordinates", makeArrayEncoder Jenc.float x.coordinates)
        ]

properties : Jdec.Decoder Properties
properties =
    Jpipe.decode Properties
        |> Jpipe.required "mag" Jdec.float
        |> Jpipe.required "place" Jdec.string
        |> Jpipe.required "time" Jdec.int
        |> Jpipe.required "updated" Jdec.int
        |> Jpipe.required "tz" Jdec.int
        |> Jpipe.required "url" Jdec.string
        |> Jpipe.required "detail" Jdec.string
        |> Jpipe.optional "felt" (Jdec.null ()) ()
        |> Jpipe.optional "cdi" (Jdec.null ()) ()
        |> Jpipe.optional "mmi" (Jdec.null ()) ()
        |> Jpipe.optional "alert" (Jdec.null ()) ()
        |> Jpipe.required "status" Jdec.string
        |> Jpipe.required "tsunami" Jdec.int
        |> Jpipe.required "sig" Jdec.int
        |> Jpipe.required "net" Jdec.string
        |> Jpipe.required "code" Jdec.string
        |> Jpipe.required "ids" Jdec.string
        |> Jpipe.required "sources" Jdec.string
        |> Jpipe.required "types" Jdec.string
        |> Jpipe.required "nst" Jdec.int
        |> Jpipe.required "dmin" Jdec.float
        |> Jpipe.required "rms" Jdec.float
        |> Jpipe.required "gap" Jdec.int
        |> Jpipe.required "magType" Jdec.string
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "title" Jdec.string

encodeProperties : Properties -> Jenc.Value
encodeProperties x =
    Jenc.object
        [ ("mag", Jenc.float x.mag)
        , ("place", Jenc.string x.place)
        , ("time", Jenc.int x.time)
        , ("updated", Jenc.int x.updated)
        , ("tz", Jenc.int x.tz)
        , ("url", Jenc.string x.url)
        , ("detail", Jenc.string x.detail)
        , ("felt", always Jenc.null x.felt)
        , ("cdi", always Jenc.null x.cdi)
        , ("mmi", always Jenc.null x.mmi)
        , ("alert", always Jenc.null x.alert)
        , ("status", Jenc.string x.status)
        , ("tsunami", Jenc.int x.tsunami)
        , ("sig", Jenc.int x.sig)
        , ("net", Jenc.string x.net)
        , ("code", Jenc.string x.code)
        , ("ids", Jenc.string x.ids)
        , ("sources", Jenc.string x.sources)
        , ("types", Jenc.string x.types)
        , ("nst", Jenc.int x.nst)
        , ("dmin", Jenc.float x.dmin)
        , ("rms", Jenc.float x.rms)
        , ("gap", Jenc.int x.gap)
        , ("magType", Jenc.string x.magType)
        , ("type", Jenc.string x.purpleType)
        , ("title", Jenc.string x.title)
        ]

metadata : Jdec.Decoder Metadata
metadata =
    Jpipe.decode Metadata
        |> Jpipe.required "generated" Jdec.int
        |> Jpipe.required "url" Jdec.string
        |> Jpipe.required "title" Jdec.string
        |> Jpipe.required "status" Jdec.int
        |> Jpipe.required "api" Jdec.string
        |> Jpipe.required "count" Jdec.int

encodeMetadata : Metadata -> Jenc.Value
encodeMetadata x =
    Jenc.object
        [ ("generated", Jenc.int x.generated)
        , ("url", Jenc.string x.url)
        , ("title", Jenc.string x.title)
        , ("status", Jenc.int x.status)
        , ("api", Jenc.string x.api)
        , ("count", Jenc.int x.count)
        ]

--- encoder helpers

makeArrayEncoder : (a -> Jenc.Value) -> Array a -> Jenc.Value
makeArrayEncoder f arr =
    Jenc.array (Array.map f arr)

makeDictEncoder : (a -> Jenc.Value) -> Dict String a -> Jenc.Value
makeDictEncoder f dict =
    Jenc.object (toList (Dict.map (\k -> f) dict))

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
