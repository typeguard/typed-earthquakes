// Example code that deserializes and serializes the model.
// extern crate serde;
// #[macro_use]
// extern crate serde_derive;
// extern crate serde_json;
// 
// use generated_module::Earthquakes;
// 
// fn main() {
//     let json = r#"{"answer": 42}"#;
//     let model: Earthquakes = serde_json::from_str(&json).unwrap();
// }

extern crate serde_json;

#[derive(Serialize, Deserialize)]
pub struct Earthquakes {
    #[serde(rename = "type")]
    earthquakes_type: String,

    #[serde(rename = "metadata")]
    metadata: Metadata,

    #[serde(rename = "features")]
    features: Vec<Feature>,

    #[serde(rename = "bbox")]
    bbox: Vec<f64>,
}

#[derive(Serialize, Deserialize)]
pub struct Feature {
    #[serde(rename = "type")]
    feature_type: String,

    #[serde(rename = "properties")]
    properties: Properties,

    #[serde(rename = "geometry")]
    geometry: Geometry,

    #[serde(rename = "id")]
    id: String,
}

#[derive(Serialize, Deserialize)]
pub struct Geometry {
    #[serde(rename = "type")]
    geometry_type: String,

    #[serde(rename = "coordinates")]
    coordinates: Vec<f64>,
}

#[derive(Serialize, Deserialize)]
pub struct Properties {
    #[serde(rename = "mag")]
    mag: f64,

    #[serde(rename = "place")]
    place: String,

    #[serde(rename = "time")]
    time: i64,

    #[serde(rename = "updated")]
    updated: i64,

    #[serde(rename = "tz")]
    tz: i64,

    #[serde(rename = "url")]
    url: String,

    #[serde(rename = "detail")]
    detail: String,

    #[serde(rename = "felt")]
    felt: Option<serde_json::Value>,

    #[serde(rename = "cdi")]
    cdi: Option<serde_json::Value>,

    #[serde(rename = "mmi")]
    mmi: Option<serde_json::Value>,

    #[serde(rename = "alert")]
    alert: Option<serde_json::Value>,

    #[serde(rename = "status")]
    status: String,

    #[serde(rename = "tsunami")]
    tsunami: i64,

    #[serde(rename = "sig")]
    sig: i64,

    #[serde(rename = "net")]
    net: String,

    #[serde(rename = "code")]
    code: String,

    #[serde(rename = "ids")]
    ids: String,

    #[serde(rename = "sources")]
    sources: String,

    #[serde(rename = "types")]
    types: String,

    #[serde(rename = "nst")]
    nst: i64,

    #[serde(rename = "dmin")]
    dmin: f64,

    #[serde(rename = "rms")]
    rms: f64,

    #[serde(rename = "gap")]
    gap: i64,

    #[serde(rename = "magType")]
    mag_type: String,

    #[serde(rename = "type")]
    properties_type: String,

    #[serde(rename = "title")]
    title: String,
}

#[derive(Serialize, Deserialize)]
pub struct Metadata {
    #[serde(rename = "generated")]
    generated: i64,

    #[serde(rename = "url")]
    url: String,

    #[serde(rename = "title")]
    title: String,

    #[serde(rename = "status")]
    status: i64,

    #[serde(rename = "api")]
    api: String,

    #[serde(rename = "count")]
    count: i64,
}
