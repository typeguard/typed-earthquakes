// To parse this JSON data, do
//
//     final earthquakes = earthquakesFromJson(jsonString);

import 'dart:convert';

Earthquakes earthquakesFromJson(String str) {
    final jsonData = json.decode(str);
    return Earthquakes.fromJson(jsonData);
}

String earthquakesToJson(Earthquakes data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class Earthquakes {
    String type;
    Metadata metadata;
    List<Feature> features;
    List<double> bbox;

    Earthquakes({
        this.type,
        this.metadata,
        this.features,
        this.bbox,
    });

    factory Earthquakes.fromJson(Map<String, dynamic> json) => new Earthquakes(
        type: json["type"],
        metadata: Metadata.fromJson(json["metadata"]),
        features: new List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        bbox: new List<double>.from(json["bbox"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "metadata": metadata.toJson(),
        "features": new List<dynamic>.from(features.map((x) => x.toJson())),
        "bbox": new List<dynamic>.from(bbox.map((x) => x)),
    };
}

class Feature {
    String type;
    Properties properties;
    Geometry geometry;
    String id;

    Feature({
        this.type,
        this.properties,
        this.geometry,
        this.id,
    });

    factory Feature.fromJson(Map<String, dynamic> json) => new Feature(
        type: json["type"],
        properties: Properties.fromJson(json["properties"]),
        geometry: Geometry.fromJson(json["geometry"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "properties": properties.toJson(),
        "geometry": geometry.toJson(),
        "id": id,
    };
}

class Geometry {
    String type;
    List<double> coordinates;

    Geometry({
        this.type,
        this.coordinates,
    });

    factory Geometry.fromJson(Map<String, dynamic> json) => new Geometry(
        type: json["type"],
        coordinates: new List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": new List<dynamic>.from(coordinates.map((x) => x)),
    };
}

class Properties {
    double mag;
    String place;
    int time;
    int updated;
    int tz;
    String url;
    String detail;
    int felt;
    int cdi;
    double mmi;
    dynamic alert;
    String status;
    int tsunami;
    int sig;
    String net;
    String code;
    String ids;
    String sources;
    String types;
    int nst;
    double dmin;
    double rms;
    int gap;
    String magType;
    String type;
    String title;

    Properties({
        this.mag,
        this.place,
        this.time,
        this.updated,
        this.tz,
        this.url,
        this.detail,
        this.felt,
        this.cdi,
        this.mmi,
        this.alert,
        this.status,
        this.tsunami,
        this.sig,
        this.net,
        this.code,
        this.ids,
        this.sources,
        this.types,
        this.nst,
        this.dmin,
        this.rms,
        this.gap,
        this.magType,
        this.type,
        this.title,
    });

    factory Properties.fromJson(Map<String, dynamic> json) => new Properties(
        mag: json["mag"].toDouble(),
        place: json["place"],
        time: json["time"],
        updated: json["updated"],
        tz: json["tz"],
        url: json["url"],
        detail: json["detail"],
        felt: json["felt"] == null ? null : json["felt"],
        cdi: json["cdi"] == null ? null : json["cdi"],
        mmi: json["mmi"] == null ? null : json["mmi"].toDouble(),
        alert: json["alert"],
        status: json["status"],
        tsunami: json["tsunami"],
        sig: json["sig"],
        net: json["net"],
        code: json["code"],
        ids: json["ids"],
        sources: json["sources"],
        types: json["types"],
        nst: json["nst"] == null ? null : json["nst"],
        dmin: json["dmin"] == null ? null : json["dmin"].toDouble(),
        rms: json["rms"].toDouble(),
        gap: json["gap"] == null ? null : json["gap"],
        magType: json["magType"],
        type: json["type"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "mag": mag,
        "place": place,
        "time": time,
        "updated": updated,
        "tz": tz,
        "url": url,
        "detail": detail,
        "felt": felt == null ? null : felt,
        "cdi": cdi == null ? null : cdi,
        "mmi": mmi == null ? null : mmi,
        "alert": alert,
        "status": status,
        "tsunami": tsunami,
        "sig": sig,
        "net": net,
        "code": code,
        "ids": ids,
        "sources": sources,
        "types": types,
        "nst": nst == null ? null : nst,
        "dmin": dmin == null ? null : dmin,
        "rms": rms,
        "gap": gap == null ? null : gap,
        "magType": magType,
        "type": type,
        "title": title,
    };
}

class Metadata {
    int generated;
    String url;
    String title;
    int status;
    String api;
    int count;

    Metadata({
        this.generated,
        this.url,
        this.title,
        this.status,
        this.api,
        this.count,
    });

    factory Metadata.fromJson(Map<String, dynamic> json) => new Metadata(
        generated: json["generated"],
        url: json["url"],
        title: json["title"],
        status: json["status"],
        api: json["api"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "generated": generated,
        "url": url,
        "title": title,
        "status": status,
        "api": api,
        "count": count,
    };
}
