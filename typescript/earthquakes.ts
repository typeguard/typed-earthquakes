// To parse this data:
//
//   import { Convert, Earthquakes } from "./file";
//
//   const earthquakes = Convert.toEarthquakes(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export interface Earthquakes {
    type:     string;
    metadata: Metadata;
    features: Feature[];
    bbox:     number[];
}

export interface Feature {
    type:       string;
    properties: Properties;
    geometry:   Geometry;
    id:         string;
}

export interface Geometry {
    type:        string;
    coordinates: number[];
}

export interface Properties {
    mag:     number;
    place:   string;
    time:    number;
    updated: number;
    tz:      number;
    url:     string;
    detail:  string;
    felt:    null;
    cdi:     null;
    mmi:     null;
    alert:   null;
    status:  string;
    tsunami: number;
    sig:     number;
    net:     string;
    code:    string;
    ids:     string;
    sources: string;
    types:   string;
    nst:     number;
    dmin:    number;
    rms:     number;
    gap:     number;
    magType: string;
    type:    string;
    title:   string;
}

export interface Metadata {
    generated: number;
    url:       string;
    title:     string;
    status:    number;
    api:       string;
    count:     number;
}

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
export module Convert {
    export function toEarthquakes(json: string): Earthquakes {
        return cast(JSON.parse(json), O("Earthquakes"));
    }

    export function earthquakesToJson(value: Earthquakes): string {
        return JSON.stringify(value, null, 2);
    }
    
    function cast<T>(obj: any, typ: any): T {
        if (!isValid(typ, obj)) {
            throw `Invalid value`;
        }
        return obj;
    }

    function isValid(typ: any, val: any): boolean {
        if (typ === undefined) return true;
        if (typ === null) return val === null || val === undefined;
        return typ.isUnion  ? isValidUnion(typ.typs, val)
                : typ.isArray  ? isValidArray(typ.typ, val)
                : typ.isMap    ? isValidMap(typ.typ, val)
                : typ.isEnum   ? isValidEnum(typ.name, val)
                : typ.isObject ? isValidObject(typ.cls, val)
                :                isValidPrimitive(typ, val);
    }

    function isValidPrimitive(typ: string, val: any) {
        return typeof typ === typeof val;
    }

    function isValidUnion(typs: any[], val: any): boolean {
        // val must validate against one typ in typs
        return typs.find(typ => isValid(typ, val)) !== undefined;
    }

    function isValidEnum(enumName: string, val: any): boolean {
        const cases = typeMap[enumName];
        return cases.indexOf(val) !== -1;
    }

    function isValidArray(typ: any, val: any): boolean {
        // val must be an array with no invalid elements
        return Array.isArray(val) && val.every((element, i) => {
            return isValid(typ, element);
        });
    }

    function isValidMap(typ: any, val: any): boolean {
        if (val === null || typeof val !== "object" || Array.isArray(val)) return false;
        // all values in the map must be typ
        return Object.keys(val).every(prop => {
            if (!Object.prototype.hasOwnProperty.call(val, prop)) return true;
            return isValid(typ, val[prop]);
        });
    }

    function isValidObject(className: string, val: any): boolean {
        if (val === null || typeof val !== "object" || Array.isArray(val)) return false;
        let typeRep = typeMap[className];
        return Object.keys(typeRep).every(prop => {
            if (!Object.prototype.hasOwnProperty.call(typeRep, prop)) return true;
            return isValid(typeRep[prop], val[prop]);
        });
    }

    function A(typ: any) {
        return { typ, isArray: true };
    }

    function E(name: string) {
        return { name, isEnum: true };
    }

    function U(...typs: any[]) {
        return { typs, isUnion: true };
    }

    function M(typ: any) {
        return { typ, isMap: true };
    }

    function O(className: string) {
        return { cls: className, isObject: true };
    }

    const typeMap: any = {
        "Earthquakes": {
            type: "",
            metadata: O("Metadata"),
            features: A(O("Feature")),
            bbox: A(3.14),
        },
        "Feature": {
            type: "",
            properties: O("Properties"),
            geometry: O("Geometry"),
            id: "",
        },
        "Geometry": {
            type: "",
            coordinates: A(3.14),
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
}
