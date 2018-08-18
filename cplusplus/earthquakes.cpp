//  To parse this JSON data, first install
//
//      Boost     http://www.boost.org
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     Earthquakes data = nlohmann::json::parse(jsonString);

#pragma once

#include "json.hpp"

#include <boost/optional.hpp>
#include <stdexcept>
#include <regex>
namespace nlohmann {
    template <typename T>
    struct adl_serializer<std::shared_ptr<T>> {
        static void to_json(json& j, const std::shared_ptr<T>& opt) {
            if (!opt) j = nullptr; else j = *opt;
        }

        static std::shared_ptr<T> from_json(const json& j) {
            if (j.is_null()) return std::unique_ptr<T>(); else return std::unique_ptr<T>(new T(j.get<T>()));
        }
    };
}

namespace quicktype {
    using nlohmann::json;

    inline json get_untyped(const json &j, const char *property) {
        if (j.find(property) != j.end()) {
            return j.at(property).get<json>();
        }
        return json();
    }

    template <typename T>
    inline std::shared_ptr<T> get_optional(const json &j, const char *property) {
        if (j.find(property) != j.end()) {
            return j.at(property).get<std::shared_ptr<T>>();
        }
        return std::shared_ptr<T>();
    }

    class Geometry {
        public:
        Geometry() = default;
        virtual ~Geometry() = default;

        private:
        std::string type;
        std::vector<double> coordinates;

        public:
        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string& value) { this->type = value; }

        const std::vector<double> & get_coordinates() const { return coordinates; }
        std::vector<double> & get_mutable_coordinates() { return coordinates; }
        void set_coordinates(const std::vector<double>& value) { this->coordinates = value; }
    };

    class Properties {
        public:
        Properties() = default;
        virtual ~Properties() = default;

        private:
        double mag;
        std::string place;
        int64_t time;
        int64_t updated;
        int64_t tz;
        std::string url;
        std::string detail;
        std::shared_ptr<int64_t> felt;
        std::shared_ptr<int64_t> cdi;
        std::shared_ptr<double> mmi;
        nlohmann::json alert;
        std::string status;
        int64_t tsunami;
        int64_t sig;
        std::string net;
        std::string code;
        std::string ids;
        std::string sources;
        std::string types;
        std::shared_ptr<int64_t> nst;
        std::shared_ptr<double> dmin;
        double rms;
        std::shared_ptr<int64_t> gap;
        std::string mag_type;
        std::string type;
        std::string title;

        public:
        const double & get_mag() const { return mag; }
        double & get_mutable_mag() { return mag; }
        void set_mag(const double& value) { this->mag = value; }

        const std::string & get_place() const { return place; }
        std::string & get_mutable_place() { return place; }
        void set_place(const std::string& value) { this->place = value; }

        const int64_t & get_time() const { return time; }
        int64_t & get_mutable_time() { return time; }
        void set_time(const int64_t& value) { this->time = value; }

        const int64_t & get_updated() const { return updated; }
        int64_t & get_mutable_updated() { return updated; }
        void set_updated(const int64_t& value) { this->updated = value; }

        const int64_t & get_tz() const { return tz; }
        int64_t & get_mutable_tz() { return tz; }
        void set_tz(const int64_t& value) { this->tz = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string& value) { this->url = value; }

        const std::string & get_detail() const { return detail; }
        std::string & get_mutable_detail() { return detail; }
        void set_detail(const std::string& value) { this->detail = value; }

        std::shared_ptr<int64_t> get_felt() const { return felt; }
        void set_felt(std::shared_ptr<int64_t> value) { this->felt = value; }

        std::shared_ptr<int64_t> get_cdi() const { return cdi; }
        void set_cdi(std::shared_ptr<int64_t> value) { this->cdi = value; }

        std::shared_ptr<double> get_mmi() const { return mmi; }
        void set_mmi(std::shared_ptr<double> value) { this->mmi = value; }

        const nlohmann::json & get_alert() const { return alert; }
        nlohmann::json & get_mutable_alert() { return alert; }
        void set_alert(const nlohmann::json& value) { this->alert = value; }

        const std::string & get_status() const { return status; }
        std::string & get_mutable_status() { return status; }
        void set_status(const std::string& value) { this->status = value; }

        const int64_t & get_tsunami() const { return tsunami; }
        int64_t & get_mutable_tsunami() { return tsunami; }
        void set_tsunami(const int64_t& value) { this->tsunami = value; }

        const int64_t & get_sig() const { return sig; }
        int64_t & get_mutable_sig() { return sig; }
        void set_sig(const int64_t& value) { this->sig = value; }

        const std::string & get_net() const { return net; }
        std::string & get_mutable_net() { return net; }
        void set_net(const std::string& value) { this->net = value; }

        const std::string & get_code() const { return code; }
        std::string & get_mutable_code() { return code; }
        void set_code(const std::string& value) { this->code = value; }

        const std::string & get_ids() const { return ids; }
        std::string & get_mutable_ids() { return ids; }
        void set_ids(const std::string& value) { this->ids = value; }

        const std::string & get_sources() const { return sources; }
        std::string & get_mutable_sources() { return sources; }
        void set_sources(const std::string& value) { this->sources = value; }

        const std::string & get_types() const { return types; }
        std::string & get_mutable_types() { return types; }
        void set_types(const std::string& value) { this->types = value; }

        std::shared_ptr<int64_t> get_nst() const { return nst; }
        void set_nst(std::shared_ptr<int64_t> value) { this->nst = value; }

        std::shared_ptr<double> get_dmin() const { return dmin; }
        void set_dmin(std::shared_ptr<double> value) { this->dmin = value; }

        const double & get_rms() const { return rms; }
        double & get_mutable_rms() { return rms; }
        void set_rms(const double& value) { this->rms = value; }

        std::shared_ptr<int64_t> get_gap() const { return gap; }
        void set_gap(std::shared_ptr<int64_t> value) { this->gap = value; }

        const std::string & get_mag_type() const { return mag_type; }
        std::string & get_mutable_mag_type() { return mag_type; }
        void set_mag_type(const std::string& value) { this->mag_type = value; }

        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string& value) { this->type = value; }

        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string& value) { this->title = value; }
    };

    class Feature {
        public:
        Feature() = default;
        virtual ~Feature() = default;

        private:
        std::string type;
        Properties properties;
        Geometry geometry;
        std::string id;

        public:
        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string& value) { this->type = value; }

        const Properties & get_properties() const { return properties; }
        Properties & get_mutable_properties() { return properties; }
        void set_properties(const Properties& value) { this->properties = value; }

        const Geometry & get_geometry() const { return geometry; }
        Geometry & get_mutable_geometry() { return geometry; }
        void set_geometry(const Geometry& value) { this->geometry = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string& value) { this->id = value; }
    };

    class Metadata {
        public:
        Metadata() = default;
        virtual ~Metadata() = default;

        private:
        int64_t generated;
        std::string url;
        std::string title;
        int64_t status;
        std::string api;
        int64_t count;

        public:
        const int64_t & get_generated() const { return generated; }
        int64_t & get_mutable_generated() { return generated; }
        void set_generated(const int64_t& value) { this->generated = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string& value) { this->url = value; }

        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string& value) { this->title = value; }

        const int64_t & get_status() const { return status; }
        int64_t & get_mutable_status() { return status; }
        void set_status(const int64_t& value) { this->status = value; }

        const std::string & get_api() const { return api; }
        std::string & get_mutable_api() { return api; }
        void set_api(const std::string& value) { this->api = value; }

        const int64_t & get_count() const { return count; }
        int64_t & get_mutable_count() { return count; }
        void set_count(const int64_t& value) { this->count = value; }
    };

    class Earthquakes {
        public:
        Earthquakes() = default;
        virtual ~Earthquakes() = default;

        private:
        std::string type;
        Metadata metadata;
        std::vector<Feature> features;
        std::vector<double> bbox;

        public:
        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string& value) { this->type = value; }

        const Metadata & get_metadata() const { return metadata; }
        Metadata & get_mutable_metadata() { return metadata; }
        void set_metadata(const Metadata& value) { this->metadata = value; }

        const std::vector<Feature> & get_features() const { return features; }
        std::vector<Feature> & get_mutable_features() { return features; }
        void set_features(const std::vector<Feature>& value) { this->features = value; }

        const std::vector<double> & get_bbox() const { return bbox; }
        std::vector<double> & get_mutable_bbox() { return bbox; }
        void set_bbox(const std::vector<double>& value) { this->bbox = value; }
    };
}

namespace nlohmann {
    inline void from_json(const json& _j, quicktype::Geometry& _x) {
        _x.set_type( _j.at("type").get<std::string>() );
        _x.set_coordinates( _j.at("coordinates").get<std::vector<double>>() );
    }

    inline void to_json(json& _j, const quicktype::Geometry& _x) {
        _j = json::object();
        _j["type"] = _x.get_type();
        _j["coordinates"] = _x.get_coordinates();
    }

    inline void from_json(const json& _j, quicktype::Properties& _x) {
        _x.set_mag( _j.at("mag").get<double>() );
        _x.set_place( _j.at("place").get<std::string>() );
        _x.set_time( _j.at("time").get<int64_t>() );
        _x.set_updated( _j.at("updated").get<int64_t>() );
        _x.set_tz( _j.at("tz").get<int64_t>() );
        _x.set_url( _j.at("url").get<std::string>() );
        _x.set_detail( _j.at("detail").get<std::string>() );
        _x.set_felt( quicktype::get_optional<int64_t>(_j, "felt") );
        _x.set_cdi( quicktype::get_optional<int64_t>(_j, "cdi") );
        _x.set_mmi( quicktype::get_optional<double>(_j, "mmi") );
        _x.set_alert( quicktype::get_untyped(_j, "alert") );
        _x.set_status( _j.at("status").get<std::string>() );
        _x.set_tsunami( _j.at("tsunami").get<int64_t>() );
        _x.set_sig( _j.at("sig").get<int64_t>() );
        _x.set_net( _j.at("net").get<std::string>() );
        _x.set_code( _j.at("code").get<std::string>() );
        _x.set_ids( _j.at("ids").get<std::string>() );
        _x.set_sources( _j.at("sources").get<std::string>() );
        _x.set_types( _j.at("types").get<std::string>() );
        _x.set_nst( quicktype::get_optional<int64_t>(_j, "nst") );
        _x.set_dmin( quicktype::get_optional<double>(_j, "dmin") );
        _x.set_rms( _j.at("rms").get<double>() );
        _x.set_gap( quicktype::get_optional<int64_t>(_j, "gap") );
        _x.set_mag_type( _j.at("magType").get<std::string>() );
        _x.set_type( _j.at("type").get<std::string>() );
        _x.set_title( _j.at("title").get<std::string>() );
    }

    inline void to_json(json& _j, const quicktype::Properties& _x) {
        _j = json::object();
        _j["mag"] = _x.get_mag();
        _j["place"] = _x.get_place();
        _j["time"] = _x.get_time();
        _j["updated"] = _x.get_updated();
        _j["tz"] = _x.get_tz();
        _j["url"] = _x.get_url();
        _j["detail"] = _x.get_detail();
        _j["felt"] = _x.get_felt();
        _j["cdi"] = _x.get_cdi();
        _j["mmi"] = _x.get_mmi();
        _j["alert"] = _x.get_alert();
        _j["status"] = _x.get_status();
        _j["tsunami"] = _x.get_tsunami();
        _j["sig"] = _x.get_sig();
        _j["net"] = _x.get_net();
        _j["code"] = _x.get_code();
        _j["ids"] = _x.get_ids();
        _j["sources"] = _x.get_sources();
        _j["types"] = _x.get_types();
        _j["nst"] = _x.get_nst();
        _j["dmin"] = _x.get_dmin();
        _j["rms"] = _x.get_rms();
        _j["gap"] = _x.get_gap();
        _j["magType"] = _x.get_mag_type();
        _j["type"] = _x.get_type();
        _j["title"] = _x.get_title();
    }

    inline void from_json(const json& _j, quicktype::Feature& _x) {
        _x.set_type( _j.at("type").get<std::string>() );
        _x.set_properties( _j.at("properties").get<quicktype::Properties>() );
        _x.set_geometry( _j.at("geometry").get<quicktype::Geometry>() );
        _x.set_id( _j.at("id").get<std::string>() );
    }

    inline void to_json(json& _j, const quicktype::Feature& _x) {
        _j = json::object();
        _j["type"] = _x.get_type();
        _j["properties"] = _x.get_properties();
        _j["geometry"] = _x.get_geometry();
        _j["id"] = _x.get_id();
    }

    inline void from_json(const json& _j, quicktype::Metadata& _x) {
        _x.set_generated( _j.at("generated").get<int64_t>() );
        _x.set_url( _j.at("url").get<std::string>() );
        _x.set_title( _j.at("title").get<std::string>() );
        _x.set_status( _j.at("status").get<int64_t>() );
        _x.set_api( _j.at("api").get<std::string>() );
        _x.set_count( _j.at("count").get<int64_t>() );
    }

    inline void to_json(json& _j, const quicktype::Metadata& _x) {
        _j = json::object();
        _j["generated"] = _x.get_generated();
        _j["url"] = _x.get_url();
        _j["title"] = _x.get_title();
        _j["status"] = _x.get_status();
        _j["api"] = _x.get_api();
        _j["count"] = _x.get_count();
    }

    inline void from_json(const json& _j, quicktype::Earthquakes& _x) {
        _x.set_type( _j.at("type").get<std::string>() );
        _x.set_metadata( _j.at("metadata").get<quicktype::Metadata>() );
        _x.set_features( _j.at("features").get<std::vector<quicktype::Feature>>() );
        _x.set_bbox( _j.at("bbox").get<std::vector<double>>() );
    }

    inline void to_json(json& _j, const quicktype::Earthquakes& _x) {
        _j = json::object();
        _j["type"] = _x.get_type();
        _j["metadata"] = _x.get_metadata();
        _j["features"] = _x.get_features();
        _j["bbox"] = _x.get_bbox();
    }
}
