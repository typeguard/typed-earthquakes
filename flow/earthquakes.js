// To parse this data:
//
//   const Convert = require("./file");
//
//   const earthquakes = Convert.toEarthquakes(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
function toEarthquakes(json) {
    return cast(JSON.parse(json), r("Earthquakes"));
}

function earthquakesToJson(value) {
    return JSON.stringify(uncast(value, r("Earthquakes")), null, 2);
}

function invalidValue(typ, val) {
    throw Error(`Invalid value ${JSON.stringify(val)} for type ${JSON.stringify(typ)}`);
}

function jsonToJSProps(typ) {
    if (typ.jsonToJS === undefined) {
        var map = {};
        typ.props.forEach((p) => map[p.json] = { key: p.js, typ: p.typ });
        typ.jsonToJS = map;
    }
    return typ.jsonToJS;
}

function jsToJSONProps(typ) {
    if (typ.jsToJSON === undefined) {
        var map = {};
        typ.props.forEach((p) => map[p.js] = { key: p.json, typ: p.typ });
        typ.jsToJSON = map;
    }
    return typ.jsToJSON;
}

function transform(val, typ, getProps) {
    function transformPrimitive(typ, val) {
        if (typeof typ === typeof val) return val;
        return invalidValue(typ, val);
    }

    function transformUnion(typs, val) {
        // val must validate against one typ in typs
        var l = typs.length;
        for (var i = 0; i < l; i++) {
            var typ = typs[i];
            try {
                return transform(val, typ, getProps);
            } catch (_) {}
        }
        return invalidValue(typs, val);
    }

    function transformEnum(cases, val) {
        if (cases.indexOf(val) !== -1) return val;
        return invalidValue(cases, val);
    }

    function transformArray(typ, val) {
        // val must be an array with no invalid elements
        if (!Array.isArray(val)) return invalidValue("array", val);
        return val.map(el => transform(el, typ, getProps));
    }

    function transformObject(props, additional, val) {
        if (val === null || typeof val !== "object" || Array.isArray(val)) {
            return invalidValue("object", val);
        }
        var result = {};
        Object.getOwnPropertyNames(props).forEach(key => {
            const prop = props[key];
            const v = Object.prototype.hasOwnProperty.call(val, key) ? val[key] : undefined;
            result[prop.key] = transform(v, prop.typ, getProps);
        });
        Object.getOwnPropertyNames(val).forEach(key => {
            if (!Object.prototype.hasOwnProperty.call(props, key)) {
                result[key] = transform(val[key], additional, getProps);
            }
        });
        return result;
    }

    if (typ === "any") return val;
    if (typ === null) {
        if (val === null) return val;
        return invalidValue(typ, val);
    }
    if (typ === false) return invalidValue(typ, val);
    while (typeof typ === "object" && typ.ref !== undefined) {
        typ = typeMap[typ.ref];
    }
    if (Array.isArray(typ)) return transformEnum(typ, val);
    if (typeof typ === "object") {
        return typ.hasOwnProperty("unionMembers") ? transformUnion(typ.unionMembers, val)
            : typ.hasOwnProperty("arrayItems")    ? transformArray(typ.arrayItems, val)
            : typ.hasOwnProperty("props")         ? transformObject(getProps(typ), typ.additional, val)
            : invalidValue(typ, val);
    }
    return transformPrimitive(typ, val);
}

function cast(val, typ) {
    return transform(val, typ, jsonToJSProps);
}

function uncast(val, typ) {
    return transform(val, typ, jsToJSONProps);
}

function a(typ) {
    return { arrayItems: typ };
}

function u(...typs) {
    return { unionMembers: typs };
}

function o(props, additional) {
    return { props, additional };
}

function m(additional) {
    return { props: [], additional };
}

function r(name) {
    return { ref: name };
}

const typeMap = {
    "Earthquakes": o([
        { json: "type", js: "type", typ: "" },
        { json: "metadata", js: "metadata", typ: r("Metadata") },
        { json: "features", js: "features", typ: a(r("Feature")) },
        { json: "bbox", js: "bbox", typ: a(3.14) },
    ], false),
    "Feature": o([
        { json: "type", js: "type", typ: "" },
        { json: "properties", js: "properties", typ: r("Properties") },
        { json: "geometry", js: "geometry", typ: r("Geometry") },
        { json: "id", js: "id", typ: "" },
    ], false),
    "Geometry": o([
        { json: "type", js: "type", typ: "" },
        { json: "coordinates", js: "coordinates", typ: a(3.14) },
    ], false),
    "Properties": o([
        { json: "mag", js: "mag", typ: 3.14 },
        { json: "place", js: "place", typ: "" },
        { json: "time", js: "time", typ: 0 },
        { json: "updated", js: "updated", typ: 0 },
        { json: "tz", js: "tz", typ: 0 },
        { json: "url", js: "url", typ: "" },
        { json: "detail", js: "detail", typ: "" },
        { json: "felt", js: "felt", typ: u(0, null) },
        { json: "cdi", js: "cdi", typ: u(0, null) },
        { json: "mmi", js: "mmi", typ: u(3.14, null) },
        { json: "alert", js: "alert", typ: null },
        { json: "status", js: "status", typ: "" },
        { json: "tsunami", js: "tsunami", typ: 0 },
        { json: "sig", js: "sig", typ: 0 },
        { json: "net", js: "net", typ: "" },
        { json: "code", js: "code", typ: "" },
        { json: "ids", js: "ids", typ: "" },
        { json: "sources", js: "sources", typ: "" },
        { json: "types", js: "types", typ: "" },
        { json: "nst", js: "nst", typ: u(0, null) },
        { json: "dmin", js: "dmin", typ: u(3.14, null) },
        { json: "rms", js: "rms", typ: 3.14 },
        { json: "gap", js: "gap", typ: u(0, null) },
        { json: "magType", js: "magType", typ: "" },
        { json: "type", js: "type", typ: "" },
        { json: "title", js: "title", typ: "" },
    ], false),
    "Metadata": o([
        { json: "generated", js: "generated", typ: 0 },
        { json: "url", js: "url", typ: "" },
        { json: "title", js: "title", typ: "" },
        { json: "status", js: "status", typ: 0 },
        { json: "api", js: "api", typ: "" },
        { json: "count", js: "count", typ: 0 },
    ], false),
};

module.exports = {
    "earthquakesToJson": earthquakesToJson,
    "toEarthquakes": toEarthquakes,
};
