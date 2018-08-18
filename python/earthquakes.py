# To use this code, make sure you
#
#     import json
#
# and then, to convert JSON from a string, do
#
#     result = earthquakes_from_dict(json.loads(json_string))

from typing import List, Any, Optional, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> List[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def to_float(x: Any) -> float:
    assert isinstance(x, float)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class Geometry:
    type: str
    coordinates: List[float]

    def __init__(self, type: str, coordinates: List[float]) -> None:
        self.type = type
        self.coordinates = coordinates

    @staticmethod
    def from_dict(obj: Any) -> 'Geometry':
        assert isinstance(obj, dict)
        type = from_str(obj.get("type"))
        coordinates = from_list(from_float, obj.get("coordinates"))
        return Geometry(type, coordinates)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = from_str(self.type)
        result["coordinates"] = from_list(to_float, self.coordinates)
        return result


class Properties:
    mag: float
    place: str
    time: int
    updated: int
    tz: int
    url: str
    detail: str
    felt: Optional[int]
    cdi: Optional[int]
    mmi: Optional[float]
    alert: None
    status: str
    tsunami: int
    sig: int
    net: str
    code: str
    ids: str
    sources: str
    types: str
    nst: Optional[int]
    dmin: Optional[float]
    rms: float
    gap: Optional[int]
    mag_type: str
    type: str
    title: str

    def __init__(self, mag: float, place: str, time: int, updated: int, tz: int, url: str, detail: str, felt: Optional[int], cdi: Optional[int], mmi: Optional[float], alert: None, status: str, tsunami: int, sig: int, net: str, code: str, ids: str, sources: str, types: str, nst: Optional[int], dmin: Optional[float], rms: float, gap: Optional[int], mag_type: str, type: str, title: str) -> None:
        self.mag = mag
        self.place = place
        self.time = time
        self.updated = updated
        self.tz = tz
        self.url = url
        self.detail = detail
        self.felt = felt
        self.cdi = cdi
        self.mmi = mmi
        self.alert = alert
        self.status = status
        self.tsunami = tsunami
        self.sig = sig
        self.net = net
        self.code = code
        self.ids = ids
        self.sources = sources
        self.types = types
        self.nst = nst
        self.dmin = dmin
        self.rms = rms
        self.gap = gap
        self.mag_type = mag_type
        self.type = type
        self.title = title

    @staticmethod
    def from_dict(obj: Any) -> 'Properties':
        assert isinstance(obj, dict)
        mag = from_float(obj.get("mag"))
        place = from_str(obj.get("place"))
        time = from_int(obj.get("time"))
        updated = from_int(obj.get("updated"))
        tz = from_int(obj.get("tz"))
        url = from_str(obj.get("url"))
        detail = from_str(obj.get("detail"))
        felt = from_union([from_none, from_int], obj.get("felt"))
        cdi = from_union([from_none, from_int], obj.get("cdi"))
        mmi = from_union([from_none, from_float], obj.get("mmi"))
        alert = from_none(obj.get("alert"))
        status = from_str(obj.get("status"))
        tsunami = from_int(obj.get("tsunami"))
        sig = from_int(obj.get("sig"))
        net = from_str(obj.get("net"))
        code = from_str(obj.get("code"))
        ids = from_str(obj.get("ids"))
        sources = from_str(obj.get("sources"))
        types = from_str(obj.get("types"))
        nst = from_union([from_none, from_int], obj.get("nst"))
        dmin = from_union([from_none, from_float], obj.get("dmin"))
        rms = from_float(obj.get("rms"))
        gap = from_union([from_none, from_int], obj.get("gap"))
        mag_type = from_str(obj.get("magType"))
        type = from_str(obj.get("type"))
        title = from_str(obj.get("title"))
        return Properties(mag, place, time, updated, tz, url, detail, felt, cdi, mmi, alert, status, tsunami, sig, net, code, ids, sources, types, nst, dmin, rms, gap, mag_type, type, title)

    def to_dict(self) -> dict:
        result: dict = {}
        result["mag"] = to_float(self.mag)
        result["place"] = from_str(self.place)
        result["time"] = from_int(self.time)
        result["updated"] = from_int(self.updated)
        result["tz"] = from_int(self.tz)
        result["url"] = from_str(self.url)
        result["detail"] = from_str(self.detail)
        result["felt"] = from_union([from_none, from_int], self.felt)
        result["cdi"] = from_union([from_none, from_int], self.cdi)
        result["mmi"] = from_union([from_none, to_float], self.mmi)
        result["alert"] = from_none(self.alert)
        result["status"] = from_str(self.status)
        result["tsunami"] = from_int(self.tsunami)
        result["sig"] = from_int(self.sig)
        result["net"] = from_str(self.net)
        result["code"] = from_str(self.code)
        result["ids"] = from_str(self.ids)
        result["sources"] = from_str(self.sources)
        result["types"] = from_str(self.types)
        result["nst"] = from_union([from_none, from_int], self.nst)
        result["dmin"] = from_union([from_none, to_float], self.dmin)
        result["rms"] = to_float(self.rms)
        result["gap"] = from_union([from_none, from_int], self.gap)
        result["magType"] = from_str(self.mag_type)
        result["type"] = from_str(self.type)
        result["title"] = from_str(self.title)
        return result


class Feature:
    type: str
    properties: Properties
    geometry: Geometry
    id: str

    def __init__(self, type: str, properties: Properties, geometry: Geometry, id: str) -> None:
        self.type = type
        self.properties = properties
        self.geometry = geometry
        self.id = id

    @staticmethod
    def from_dict(obj: Any) -> 'Feature':
        assert isinstance(obj, dict)
        type = from_str(obj.get("type"))
        properties = Properties.from_dict(obj.get("properties"))
        geometry = Geometry.from_dict(obj.get("geometry"))
        id = from_str(obj.get("id"))
        return Feature(type, properties, geometry, id)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = from_str(self.type)
        result["properties"] = to_class(Properties, self.properties)
        result["geometry"] = to_class(Geometry, self.geometry)
        result["id"] = from_str(self.id)
        return result


class Metadata:
    generated: int
    url: str
    title: str
    status: int
    api: str
    count: int

    def __init__(self, generated: int, url: str, title: str, status: int, api: str, count: int) -> None:
        self.generated = generated
        self.url = url
        self.title = title
        self.status = status
        self.api = api
        self.count = count

    @staticmethod
    def from_dict(obj: Any) -> 'Metadata':
        assert isinstance(obj, dict)
        generated = from_int(obj.get("generated"))
        url = from_str(obj.get("url"))
        title = from_str(obj.get("title"))
        status = from_int(obj.get("status"))
        api = from_str(obj.get("api"))
        count = from_int(obj.get("count"))
        return Metadata(generated, url, title, status, api, count)

    def to_dict(self) -> dict:
        result: dict = {}
        result["generated"] = from_int(self.generated)
        result["url"] = from_str(self.url)
        result["title"] = from_str(self.title)
        result["status"] = from_int(self.status)
        result["api"] = from_str(self.api)
        result["count"] = from_int(self.count)
        return result


class Earthquakes:
    type: str
    metadata: Metadata
    features: List[Feature]
    bbox: List[float]

    def __init__(self, type: str, metadata: Metadata, features: List[Feature], bbox: List[float]) -> None:
        self.type = type
        self.metadata = metadata
        self.features = features
        self.bbox = bbox

    @staticmethod
    def from_dict(obj: Any) -> 'Earthquakes':
        assert isinstance(obj, dict)
        type = from_str(obj.get("type"))
        metadata = Metadata.from_dict(obj.get("metadata"))
        features = from_list(Feature.from_dict, obj.get("features"))
        bbox = from_list(from_float, obj.get("bbox"))
        return Earthquakes(type, metadata, features, bbox)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = from_str(self.type)
        result["metadata"] = to_class(Metadata, self.metadata)
        result["features"] = from_list(lambda x: to_class(Feature, x), self.features)
        result["bbox"] = from_list(to_float, self.bbox)
        return result


def earthquakes_from_dict(s: Any) -> Earthquakes:
    return Earthquakes.from_dict(s)


def earthquakes_to_dict(x: Earthquakes) -> Any:
    return to_class(Earthquakes, x)
