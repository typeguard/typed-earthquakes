package io.quicktype;

import java.util.Map;
import com.fasterxml.jackson.annotation.*;

public class Geometry {
    private String type;
    private double[] coordinates;

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }

    @JsonProperty("coordinates")
    public double[] getCoordinates() { return coordinates; }
    @JsonProperty("coordinates")
    public void setCoordinates(double[] value) { this.coordinates = value; }
}
