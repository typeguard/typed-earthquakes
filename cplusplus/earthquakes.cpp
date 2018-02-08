//  To parse this JSON data, first install
//
//      Boost     http://www.boost.org
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     Earthquakes data = nlohmann::json::parse(jsonString);

#include "json.hpp"

namespace quicktype {
    using nlohmann::json;

    struct Geometry {
        std::string type;
        std::vector<double> coordinates;
    };

    struct Properties {
        double mag;
        std::string place;
        int64_t time;
        int64_t updated;
        int64_t tz;
        std::string url;
        std::string detail;
        nlohmann::json felt;
        nlohmann::json cdi;
        nlohmann::json mmi;
        nlohmann::json alert;
        std::string status;
        int64_t tsunami;
        int64_t sig;
        std::string net;
        std::string code;
        std::string ids;
        std::string sources;
        std::string types;
        std::unique_ptr<int64_t> nst;
        std::unique_ptr<double> dmin;
        double rms;
        std::unique_ptr<int64_t> gap;
        std::string mag_type;
        std::string type;
        std::string title;
    };

    struct Feature {
        std::string type;
        struct Properties properties;
        struct Geometry geometry;
        std::string id;
    };

    struct Metadata {
        int64_t generated;
        std::string url;
        std::string title;
        int64_t status;
        std::string api;
        int64_t count;
    };

    struct Earthquakes {
        std::string type;
        struct Metadata metadata;
        std::vector<struct Feature> features;
        std::vector<double> bbox;
    };
    
    inline json get_untyped(const json &j, const char *property) {
        if (j.find(property) != j.end()) {
            return j.at(property).get<json>();
        }
        return json();
    }
    
    template <typename T>
    inline std::unique_ptr<T> get_optional(const json &j, const char *property) {
        if (j.find(property) != j.end())
            return j.at(property).get<std::unique_ptr<T>>();
        return std::unique_ptr<T>();
    }
}

namespace nlohmann {
    template <typename T>
    struct adl_serializer<std::unique_ptr<T>> {
        static void to_json(json& j, const std::unique_ptr<T>& opt) {
            if (!opt)
                j = nullptr;
            else
                j = *opt;
        }

        static std::unique_ptr<T> from_json(const json& j) {
            if (j.is_null())
                return std::unique_ptr<T>();
            else
                return std::unique_ptr<T>(new T(j.get<T>()));
        }
    };

    inline void from_json(const json& _j, struct quicktype::Geometry& _x) {
        _x.type = _j.at("type").get<std::string>();
        _x.coordinates = _j.at("coordinates").get<std::vector<double>>();
    }

    inline void to_json(json& _j, const struct quicktype::Geometry& _x) {
        _j = json::object();
        _j["type"] = _x.type;
        _j["coordinates"] = _x.coordinates;
    }

    inline void from_json(const json& _j, struct quicktype::Properties& _x) {
        _x.mag = _j.at("mag").get<double>();
        _x.place = _j.at("place").get<std::string>();
        _x.time = _j.at("time").get<int64_t>();
        _x.updated = _j.at("updated").get<int64_t>();
        _x.tz = _j.at("tz").get<int64_t>();
        _x.url = _j.at("url").get<std::string>();
        _x.detail = _j.at("detail").get<std::string>();
        _x.felt = quicktype::get_untyped(_j, "felt");
        _x.cdi = quicktype::get_untyped(_j, "cdi");
        _x.mmi = quicktype::get_untyped(_j, "mmi");
        _x.alert = quicktype::get_untyped(_j, "alert");
        _x.status = _j.at("status").get<std::string>();
        _x.tsunami = _j.at("tsunami").get<int64_t>();
        _x.sig = _j.at("sig").get<int64_t>();
        _x.net = _j.at("net").get<std::string>();
        _x.code = _j.at("code").get<std::string>();
        _x.ids = _j.at("ids").get<std::string>();
        _x.sources = _j.at("sources").get<std::string>();
        _x.types = _j.at("types").get<std::string>();
        _x.nst = quicktype::get_optional<int64_t>(_j, "nst");
        _x.dmin = quicktype::get_optional<double>(_j, "dmin");
        _x.rms = _j.at("rms").get<double>();
        _x.gap = quicktype::get_optional<int64_t>(_j, "gap");
        _x.mag_type = _j.at("magType").get<std::string>();
        _x.type = _j.at("type").get<std::string>();
        _x.title = _j.at("title").get<std::string>();
    }

    inline void to_json(json& _j, const struct quicktype::Properties& _x) {
        _j = json::object();
        _j["mag"] = _x.mag;
        _j["place"] = _x.place;
        _j["time"] = _x.time;
        _j["updated"] = _x.updated;
        _j["tz"] = _x.tz;
        _j["url"] = _x.url;
        _j["detail"] = _x.detail;
        _j["felt"] = _x.felt;
        _j["cdi"] = _x.cdi;
        _j["mmi"] = _x.mmi;
        _j["alert"] = _x.alert;
        _j["status"] = _x.status;
        _j["tsunami"] = _x.tsunami;
        _j["sig"] = _x.sig;
        _j["net"] = _x.net;
        _j["code"] = _x.code;
        _j["ids"] = _x.ids;
        _j["sources"] = _x.sources;
        _j["types"] = _x.types;
        _j["nst"] = _x.nst;
        _j["dmin"] = _x.dmin;
        _j["rms"] = _x.rms;
        _j["gap"] = _x.gap;
        _j["magType"] = _x.mag_type;
        _j["type"] = _x.type;
        _j["title"] = _x.title;
    }

    inline void from_json(const json& _j, struct quicktype::Feature& _x) {
        _x.type = _j.at("type").get<std::string>();
        _x.properties = _j.at("properties").get<struct quicktype::Properties>();
        _x.geometry = _j.at("geometry").get<struct quicktype::Geometry>();
        _x.id = _j.at("id").get<std::string>();
    }

    inline void to_json(json& _j, const struct quicktype::Feature& _x) {
        _j = json::object();
        _j["type"] = _x.type;
        _j["properties"] = _x.properties;
        _j["geometry"] = _x.geometry;
        _j["id"] = _x.id;
    }

    inline void from_json(const json& _j, struct quicktype::Metadata& _x) {
        _x.generated = _j.at("generated").get<int64_t>();
        _x.url = _j.at("url").get<std::string>();
        _x.title = _j.at("title").get<std::string>();
        _x.status = _j.at("status").get<int64_t>();
        _x.api = _j.at("api").get<std::string>();
        _x.count = _j.at("count").get<int64_t>();
    }

    inline void to_json(json& _j, const struct quicktype::Metadata& _x) {
        _j = json::object();
        _j["generated"] = _x.generated;
        _j["url"] = _x.url;
        _j["title"] = _x.title;
        _j["status"] = _x.status;
        _j["api"] = _x.api;
        _j["count"] = _x.count;
    }

    inline void from_json(const json& _j, struct quicktype::Earthquakes& _x) {
        _x.type = _j.at("type").get<std::string>();
        _x.metadata = _j.at("metadata").get<struct quicktype::Metadata>();
        _x.features = _j.at("features").get<std::vector<struct quicktype::Feature>>();
        _x.bbox = _j.at("bbox").get<std::vector<double>>();
    }

    inline void to_json(json& _j, const struct quicktype::Earthquakes& _x) {
        _j = json::object();
        _j["type"] = _x.type;
        _j["metadata"] = _x.metadata;
        _j["features"] = _x.features;
        _j["bbox"] = _x.bbox;
    }

}
