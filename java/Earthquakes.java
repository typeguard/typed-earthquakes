package io.quicktype;

import java.util.Map;
import com.fasterxml.jackson.annotation.*;

public class Earthquakes {
    private String type;
    private Metadata metadata;
    private Feature[] features;
    private double[] bbox;

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }

    @JsonProperty("metadata")
    public Metadata getMetadata() { return metadata; }
    @JsonProperty("metadata")
    public void setMetadata(Metadata value) { this.metadata = value; }

    @JsonProperty("features")
    public Feature[] getFeatures() { return features; }
    @JsonProperty("features")
    public void setFeatures(Feature[] value) { this.features = value; }

    @JsonProperty("bbox")
    public double[] getBbox() { return bbox; }
    @JsonProperty("bbox")
    public void setBbox(double[] value) { this.bbox = value; }
}
