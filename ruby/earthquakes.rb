# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   earthquakes = Earthquakes.from_json! "{…}"
#   puts earthquakes.bbox.first
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry::Types.module

  Int    = Strict::Int
  Nil    = Strict::Nil
  Hash   = Strict::Hash
  String = Strict::String
  Double = Strict::Float | Strict::Int
end

class Geometry < Dry::Struct
  attribute :geometry_type, Types::String
  attribute :coordinates,   Types.Array(Types::Double)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      geometry_type: d.fetch("type"),
      coordinates:   d.fetch("coordinates"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "type"        => @geometry_type,
      "coordinates" => @coordinates,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Properties < Dry::Struct
  attribute :mag,             Types::Double
  attribute :place,           Types::String
  attribute :time,            Types::Int
  attribute :updated,         Types::Int
  attribute :tz,              Types::Int
  attribute :url,             Types::String
  attribute :detail,          Types::String
  attribute :felt,            Types::Int.optional
  attribute :cdi,             Types::Int.optional
  attribute :mmi,             Types::Double.optional
  attribute :alert,           Types::Nil
  attribute :status,          Types::String
  attribute :tsunami,         Types::Int
  attribute :sig,             Types::Int
  attribute :net,             Types::String
  attribute :code,            Types::String
  attribute :ids,             Types::String
  attribute :sources,         Types::String
  attribute :types,           Types::String
  attribute :nst,             Types::Int.optional
  attribute :dmin,            Types::Double.optional
  attribute :rms,             Types::Double
  attribute :gap,             Types::Int.optional
  attribute :mag_type,        Types::String
  attribute :properties_type, Types::String
  attribute :title,           Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      mag:             d.fetch("mag"),
      place:           d.fetch("place"),
      time:            d.fetch("time"),
      updated:         d.fetch("updated"),
      tz:              d.fetch("tz"),
      url:             d.fetch("url"),
      detail:          d.fetch("detail"),
      felt:            d.fetch("felt"),
      cdi:             d.fetch("cdi"),
      mmi:             d.fetch("mmi"),
      alert:           d.fetch("alert"),
      status:          d.fetch("status"),
      tsunami:         d.fetch("tsunami"),
      sig:             d.fetch("sig"),
      net:             d.fetch("net"),
      code:            d.fetch("code"),
      ids:             d.fetch("ids"),
      sources:         d.fetch("sources"),
      types:           d.fetch("types"),
      nst:             d.fetch("nst"),
      dmin:            d.fetch("dmin"),
      rms:             d.fetch("rms"),
      gap:             d.fetch("gap"),
      mag_type:        d.fetch("magType"),
      properties_type: d.fetch("type"),
      title:           d.fetch("title"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "mag"     => @mag,
      "place"   => @place,
      "time"    => @time,
      "updated" => @updated,
      "tz"      => @tz,
      "url"     => @url,
      "detail"  => @detail,
      "felt"    => @felt,
      "cdi"     => @cdi,
      "mmi"     => @mmi,
      "alert"   => @alert,
      "status"  => @status,
      "tsunami" => @tsunami,
      "sig"     => @sig,
      "net"     => @net,
      "code"    => @code,
      "ids"     => @ids,
      "sources" => @sources,
      "types"   => @types,
      "nst"     => @nst,
      "dmin"    => @dmin,
      "rms"     => @rms,
      "gap"     => @gap,
      "magType" => @mag_type,
      "type"    => @properties_type,
      "title"   => @title,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Feature < Dry::Struct
  attribute :feature_type, Types::String
  attribute :properties,   Properties
  attribute :geometry,     Geometry
  attribute :id,           Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      feature_type: d.fetch("type"),
      properties:   Properties.from_dynamic!(d.fetch("properties")),
      geometry:     Geometry.from_dynamic!(d.fetch("geometry")),
      id:           d.fetch("id"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "type"       => @feature_type,
      "properties" => @properties.to_dynamic,
      "geometry"   => @geometry.to_dynamic,
      "id"         => @id,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Metadata < Dry::Struct
  attribute :generated, Types::Int
  attribute :url,       Types::String
  attribute :title,     Types::String
  attribute :status,    Types::Int
  attribute :api,       Types::String
  attribute :count,     Types::Int

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      generated: d.fetch("generated"),
      url:       d.fetch("url"),
      title:     d.fetch("title"),
      status:    d.fetch("status"),
      api:       d.fetch("api"),
      count:     d.fetch("count"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "generated" => @generated,
      "url"       => @url,
      "title"     => @title,
      "status"    => @status,
      "api"       => @api,
      "count"     => @count,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Earthquakes < Dry::Struct
  attribute :earthquakes_type, Types::String
  attribute :metadata,         Metadata
  attribute :features,         Types.Array(Feature)
  attribute :bbox,             Types.Array(Types::Double)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      earthquakes_type: d.fetch("type"),
      metadata:         Metadata.from_dynamic!(d.fetch("metadata")),
      features:         d.fetch("features").map { |x| Feature.from_dynamic!(x) },
      bbox:             d.fetch("bbox"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "type"     => @earthquakes_type,
      "metadata" => @metadata.to_dynamic,
      "features" => @features.map { |x| x.to_dynamic },
      "bbox"     => @bbox,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
