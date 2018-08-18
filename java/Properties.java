package io.quicktype;

import java.util.Map;
import com.fasterxml.jackson.annotation.*;

public class Properties {
    private double mag;
    private String place;
    private long time;
    private long updated;
    private long tz;
    private String url;
    private String detail;
    private Long felt;
    private Long cdi;
    private Double mmi;
    private Object alert;
    private String status;
    private long tsunami;
    private long sig;
    private String net;
    private String code;
    private String ids;
    private String sources;
    private String types;
    private Long nst;
    private Double dmin;
    private double rms;
    private Long gap;
    private String magType;
    private String type;
    private String title;

    @JsonProperty("mag")
    public double getMag() { return mag; }
    @JsonProperty("mag")
    public void setMag(double value) { this.mag = value; }

    @JsonProperty("place")
    public String getPlace() { return place; }
    @JsonProperty("place")
    public void setPlace(String value) { this.place = value; }

    @JsonProperty("time")
    public long getTime() { return time; }
    @JsonProperty("time")
    public void setTime(long value) { this.time = value; }

    @JsonProperty("updated")
    public long getUpdated() { return updated; }
    @JsonProperty("updated")
    public void setUpdated(long value) { this.updated = value; }

    @JsonProperty("tz")
    public long getTz() { return tz; }
    @JsonProperty("tz")
    public void setTz(long value) { this.tz = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }

    @JsonProperty("detail")
    public String getDetail() { return detail; }
    @JsonProperty("detail")
    public void setDetail(String value) { this.detail = value; }

    @JsonProperty("felt")
    public Long getFelt() { return felt; }
    @JsonProperty("felt")
    public void setFelt(Long value) { this.felt = value; }

    @JsonProperty("cdi")
    public Long getCdi() { return cdi; }
    @JsonProperty("cdi")
    public void setCdi(Long value) { this.cdi = value; }

    @JsonProperty("mmi")
    public Double getMMI() { return mmi; }
    @JsonProperty("mmi")
    public void setMMI(Double value) { this.mmi = value; }

    @JsonProperty("alert")
    public Object getAlert() { return alert; }
    @JsonProperty("alert")
    public void setAlert(Object value) { this.alert = value; }

    @JsonProperty("status")
    public String getStatus() { return status; }
    @JsonProperty("status")
    public void setStatus(String value) { this.status = value; }

    @JsonProperty("tsunami")
    public long getTsunami() { return tsunami; }
    @JsonProperty("tsunami")
    public void setTsunami(long value) { this.tsunami = value; }

    @JsonProperty("sig")
    public long getSig() { return sig; }
    @JsonProperty("sig")
    public void setSig(long value) { this.sig = value; }

    @JsonProperty("net")
    public String getNet() { return net; }
    @JsonProperty("net")
    public void setNet(String value) { this.net = value; }

    @JsonProperty("code")
    public String getCode() { return code; }
    @JsonProperty("code")
    public void setCode(String value) { this.code = value; }

    @JsonProperty("ids")
    public String getIDS() { return ids; }
    @JsonProperty("ids")
    public void setIDS(String value) { this.ids = value; }

    @JsonProperty("sources")
    public String getSources() { return sources; }
    @JsonProperty("sources")
    public void setSources(String value) { this.sources = value; }

    @JsonProperty("types")
    public String getTypes() { return types; }
    @JsonProperty("types")
    public void setTypes(String value) { this.types = value; }

    @JsonProperty("nst")
    public Long getNst() { return nst; }
    @JsonProperty("nst")
    public void setNst(Long value) { this.nst = value; }

    @JsonProperty("dmin")
    public Double getDmin() { return dmin; }
    @JsonProperty("dmin")
    public void setDmin(Double value) { this.dmin = value; }

    @JsonProperty("rms")
    public double getRMS() { return rms; }
    @JsonProperty("rms")
    public void setRMS(double value) { this.rms = value; }

    @JsonProperty("gap")
    public Long getGap() { return gap; }
    @JsonProperty("gap")
    public void setGap(Long value) { this.gap = value; }

    @JsonProperty("magType")
    public String getMagType() { return magType; }
    @JsonProperty("magType")
    public void setMagType(String value) { this.magType = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }
}
