// To parse the JSON, install Klaxon and do:
//
//   val earthquakes = Earthquakes.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class Earthquakes (
    val type: String,
    val metadata: Metadata,
    val features: List<Feature>,
    val bbox: List<Double>
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<Earthquakes>(json)
    }
}

data class Feature (
    val type: String,
    val properties: Properties,
    val geometry: Geometry,
    val id: String
)

data class Geometry (
    val type: String,
    val coordinates: List<Double>
)

data class Properties (
    val mag: Double,
    val place: String,
    val time: Long,
    val updated: Long,
    val tz: Long,
    val url: String,
    val detail: String,
    val felt: Long? = null,
    val cdi: Long? = null,
    val mmi: Double? = null,
    val alert: Any? = null,
    val status: String,
    val tsunami: Long,
    val sig: Long,
    val net: String,
    val code: String,
    val ids: String,
    val sources: String,
    val types: String,
    val nst: Long? = null,
    val dmin: Double? = null,
    val rms: Double,
    val gap: Long? = null,
    val magType: String,
    val type: String,
    val title: String
)

data class Metadata (
    val generated: Long,
    val url: String,
    val title: String,
    val status: Long,
    val api: String,
    val count: Long
)
