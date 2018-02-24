// To parse this JSON data, add NuGet 'Newtonsoft.Json' then do:
//
//    using QuickType;
//
//    var earthquakes = Earthquakes.FromJson(jsonString);

namespace QuickType
{
    using System;
    using System.Collections.Generic;
    using System.Net;

    using System.Globalization;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Converters;

    public partial class Earthquakes
    {
        [JsonProperty("type")]
        public string Type { get; set; }

        [JsonProperty("metadata")]
        public Metadata Metadata { get; set; }

        [JsonProperty("features")]
        public Feature[] Features { get; set; }

        [JsonProperty("bbox")]
        public double[] Bbox { get; set; }
    }

    public partial class Feature
    {
        [JsonProperty("type")]
        public string Type { get; set; }

        [JsonProperty("properties")]
        public Properties Properties { get; set; }

        [JsonProperty("geometry")]
        public Geometry Geometry { get; set; }

        [JsonProperty("id")]
        public string Id { get; set; }
    }

    public partial class Geometry
    {
        [JsonProperty("type")]
        public string Type { get; set; }

        [JsonProperty("coordinates")]
        public double[] Coordinates { get; set; }
    }

    public partial class Properties
    {
        [JsonProperty("mag")]
        public double Mag { get; set; }

        [JsonProperty("place")]
        public string Place { get; set; }

        [JsonProperty("time")]
        public long Time { get; set; }

        [JsonProperty("updated")]
        public long Updated { get; set; }

        [JsonProperty("tz")]
        public long Tz { get; set; }

        [JsonProperty("url")]
        public string Url { get; set; }

        [JsonProperty("detail")]
        public string Detail { get; set; }

        [JsonProperty("felt")]
        public object Felt { get; set; }

        [JsonProperty("cdi")]
        public object Cdi { get; set; }

        [JsonProperty("mmi")]
        public object Mmi { get; set; }

        [JsonProperty("alert")]
        public object Alert { get; set; }

        [JsonProperty("status")]
        public string Status { get; set; }

        [JsonProperty("tsunami")]
        public long Tsunami { get; set; }

        [JsonProperty("sig")]
        public long Sig { get; set; }

        [JsonProperty("net")]
        public string Net { get; set; }

        [JsonProperty("code")]
        public string Code { get; set; }

        [JsonProperty("ids")]
        public string Ids { get; set; }

        [JsonProperty("sources")]
        public string Sources { get; set; }

        [JsonProperty("types")]
        public string Types { get; set; }

        [JsonProperty("nst")]
        public long Nst { get; set; }

        [JsonProperty("dmin")]
        public double Dmin { get; set; }

        [JsonProperty("rms")]
        public double Rms { get; set; }

        [JsonProperty("gap")]
        public long Gap { get; set; }

        [JsonProperty("magType")]
        public string MagType { get; set; }

        [JsonProperty("type")]
        public string Type { get; set; }

        [JsonProperty("title")]
        public string Title { get; set; }
    }

    public partial class Metadata
    {
        [JsonProperty("generated")]
        public long Generated { get; set; }

        [JsonProperty("url")]
        public string Url { get; set; }

        [JsonProperty("title")]
        public string Title { get; set; }

        [JsonProperty("status")]
        public long Status { get; set; }

        [JsonProperty("api")]
        public string Api { get; set; }

        [JsonProperty("count")]
        public long Count { get; set; }
    }

    public partial class Earthquakes
    {
        public static Earthquakes FromJson(string json) => JsonConvert.DeserializeObject<Earthquakes>(json, QuickType.Converter.Settings);
    }

    public static class Serialize
    {
        public static string ToJson(this Earthquakes self) => JsonConvert.SerializeObject(self, QuickType.Converter.Settings);
    }

    internal class Converter
    {
        public static readonly JsonSerializerSettings Settings = new JsonSerializerSettings
        {
            MetadataPropertyHandling = MetadataPropertyHandling.Ignore,
            DateParseHandling = DateParseHandling.None,
            Converters = { 
                new IsoDateTimeConverter()
                {
                    DateTimeStyles = DateTimeStyles.AssumeUniversal,
                },
            },
        };
    }
}
