// To parse the JSON, add this file to your project and do:
//
//   let earthquakes = try Earthquakes(json)

import Foundation

struct Earthquakes: Codable {
    let type: String
    let metadata: Metadata
    let features: [Feature]
    let bbox: [Double]
}

struct Feature: Codable {
    let type: String
    let properties: Properties
    let geometry: Geometry
    let id: String
}

struct Geometry: Codable {
    let type: String
    let coordinates: [Double]
}

struct Properties: Codable {
    let mag: Double
    let place: String
    let time, updated, tz: Int
    let url, detail: String
    let felt, cdi: Int?
    let mmi: Double?
    let alert: JSONNull?
    let status: String
    let tsunami, sig: Int
    let net, code, ids, sources: String
    let types: String
    let nst: Int?
    let dmin: Double?
    let rms: Double
    let gap: Int?
    let magType, type, title: String
}

struct Metadata: Codable {
    let generated: Int
    let url, title: String
    let status: Int
    let api: String
    let count: Int
}

// MARK: Convenience initializers and mutators

extension Earthquakes {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Earthquakes.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        type: String? = nil,
        metadata: Metadata? = nil,
        features: [Feature]? = nil,
        bbox: [Double]? = nil
    ) -> Earthquakes {
        return Earthquakes(
            type: type ?? self.type,
            metadata: metadata ?? self.metadata,
            features: features ?? self.features,
            bbox: bbox ?? self.bbox
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Feature {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Feature.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        type: String? = nil,
        properties: Properties? = nil,
        geometry: Geometry? = nil,
        id: String? = nil
    ) -> Feature {
        return Feature(
            type: type ?? self.type,
            properties: properties ?? self.properties,
            geometry: geometry ?? self.geometry,
            id: id ?? self.id
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Geometry {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Geometry.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        type: String? = nil,
        coordinates: [Double]? = nil
    ) -> Geometry {
        return Geometry(
            type: type ?? self.type,
            coordinates: coordinates ?? self.coordinates
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Properties {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Properties.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        mag: Double? = nil,
        place: String? = nil,
        time: Int? = nil,
        updated: Int? = nil,
        tz: Int? = nil,
        url: String? = nil,
        detail: String? = nil,
        felt: Int?? = nil,
        cdi: Int?? = nil,
        mmi: Double?? = nil,
        alert: JSONNull?? = nil,
        status: String? = nil,
        tsunami: Int? = nil,
        sig: Int? = nil,
        net: String? = nil,
        code: String? = nil,
        ids: String? = nil,
        sources: String? = nil,
        types: String? = nil,
        nst: Int?? = nil,
        dmin: Double?? = nil,
        rms: Double? = nil,
        gap: Int?? = nil,
        magType: String? = nil,
        type: String? = nil,
        title: String? = nil
    ) -> Properties {
        return Properties(
            mag: mag ?? self.mag,
            place: place ?? self.place,
            time: time ?? self.time,
            updated: updated ?? self.updated,
            tz: tz ?? self.tz,
            url: url ?? self.url,
            detail: detail ?? self.detail,
            felt: felt ?? self.felt,
            cdi: cdi ?? self.cdi,
            mmi: mmi ?? self.mmi,
            alert: alert ?? self.alert,
            status: status ?? self.status,
            tsunami: tsunami ?? self.tsunami,
            sig: sig ?? self.sig,
            net: net ?? self.net,
            code: code ?? self.code,
            ids: ids ?? self.ids,
            sources: sources ?? self.sources,
            types: types ?? self.types,
            nst: nst ?? self.nst,
            dmin: dmin ?? self.dmin,
            rms: rms ?? self.rms,
            gap: gap ?? self.gap,
            magType: magType ?? self.magType,
            type: type ?? self.type,
            title: title ?? self.title
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Metadata {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Metadata.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        generated: Int? = nil,
        url: String? = nil,
        title: String? = nil,
        status: Int? = nil,
        api: String? = nil,
        count: Int? = nil
    ) -> Metadata {
        return Metadata(
            generated: generated ?? self.generated,
            url: url ?? self.url,
            title: title ?? self.title,
            status: status ?? self.status,
            api: api ?? self.api,
            count: count ?? self.count
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable {
    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
