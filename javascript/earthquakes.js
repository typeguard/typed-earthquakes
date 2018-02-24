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
    return cast(JSON.parse(json), o("Earthquakes"));
}

function earthquakesToJson(value) {
    return JSON.stringify(value, null, 2);
}

function cast(obj, typ) {
    if (!isValid(typ, obj)) {
        throw `Invalid value`;
    }
    return obj;
}

function isValid(typ, val) {
    if (typ === undefined) return true;
    if (typ === null) return val === null || val === undefined;
    return typ.isUnion  ? isValidUnion(typ.typs, val)
            : typ.isArray  ? isValidArray(typ.typ, val)
            : typ.isMap    ? isValidMap(typ.typ, val)
            : typ.isEnum   ? isValidEnum(typ.name, val)
            : typ.isObject ? isValidObject(typ.cls, val)
            :                isValidPrimitive(typ, val);
}

function isValidPrimitive(typ, val) {
    return typeof typ === typeof val;
}

function isValidUnion(typs, val) {
    // val must validate against one typ in typs
    return typs.find(typ => isValid(typ, val)) !== undefined;
}

function isValidEnum(enumName, val) {
    const cases = typeMap[enumName];
    return cases.indexOf(val) !== -1;
}

function isValidArray(typ, val) {
    // val must be an array with no invalid elements
    return Array.isArray(val) && val.every(element => {
        return isValid(typ, element);
    });
}

function isValidMap(typ, val) {
    if (val === null || typeof val !== "object" || Array.isArray(val)) return false;
    // all values in the map must be typ
    return Object.keys(val).every(prop => {
        if (!Object.prototype.hasOwnProperty.call(val, prop)) return true;
        return isValid(typ, val[prop]);
    });
}

function isValidObject(className, val) {
    if (val === null || typeof val !== "object" || Array.isArray(val)) return false;
    let typeRep = typeMap[className];
    return Object.keys(typeRep).every(prop => {
        if (!Object.prototype.hasOwnProperty.call(typeRep, prop)) return true;
        return isValid(typeRep[prop], val[prop]);
    });
}

function a(typ) {
    return { typ, isArray: true };
}

function e(name) {
    return { name, isEnum: true };
}

function u(...typs) {
    return { typs, isUnion: true };
}

function m(typ) {
    return { typ, isMap: true };
}

function o(className) {
    return { cls: className, isObject: true };
}

const typeMap = {
    "Earthquakes": {
        type: "",
        metadata: o("Metadata"),
        features: a(o("Feature")),
        bbox: a(3.14),
    },
    "Feature": {
        type: "",
        properties: o("Properties"),
        geometry: o("Geometry"),
        id: "",
    },
    "Geometry": {
        type: "",
        coordinates: a(3.14),
    },
    "Properties": {
        mag: 3.14,
        place: "",
        time: 0,
        updated: 0,
        tz: 0,
        url: "",
        detail: "",
        felt: null,
        cdi: null,
        mmi: null,
        alert: null,
        status: "",
        tsunami: 0,
        sig: 0,
        net: "",
        code: "",
        ids: "",
        sources: "",
        types: "",
        nst: 0,
        dmin: 3.14,
        rms: 3.14,
        gap: 0,
        magType: "",
        type: "",
        title: "",
    },
    "Metadata": {
        generated: 0,
        url: "",
        title: "",
        status: 0,
        api: "",
        count: 0,
    },
};

module.exports = {
    "earthquakesToJson": earthquakesToJson,
    "toEarthquakes": toEarthquakes,
};
