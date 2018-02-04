package io.quicktype;

import java.util.Map;
import com.fasterxml.jackson.annotation.*;

public class Metadata {
    private long generated;
    private String url;
    private String title;
    private long status;
    private String api;
    private long count;

    @JsonProperty("generated")
    public long getGenerated() { return generated; }
    @JsonProperty("generated")
    public void setGenerated(long value) { this.generated = value; }

    @JsonProperty("url")
    public String getUrl() { return url; }
    @JsonProperty("url")
    public void setUrl(String value) { this.url = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }

    @JsonProperty("status")
    public long getStatus() { return status; }
    @JsonProperty("status")
    public void setStatus(long value) { this.status = value; }

    @JsonProperty("api")
    public String getApi() { return api; }
    @JsonProperty("api")
    public void setApi(String value) { this.api = value; }

    @JsonProperty("count")
    public long getCount() { return count; }
    @JsonProperty("count")
    public void setCount(long value) { this.count = value; }
}
