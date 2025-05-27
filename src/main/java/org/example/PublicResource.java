package org.example;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class PublicResource {

    @JsonProperty("rsrcNo")
    private String rsrcNo;

    @JsonProperty("rsrcNm")
    private String rsrcNm;

    @JsonProperty("zip")
    private String zip;

    @JsonProperty("addr")
    private String addr;

    @JsonProperty("daddr")
    private String daddr;

    @JsonProperty("lot")
    private String lot;

    @JsonProperty("lat")
    private String lat;

    @JsonProperty("instUrlAddr")
    private String instUrlAddr;

    @JsonProperty("imgFileUrlAddr")
    private String imgFileUrlAddr;
}
