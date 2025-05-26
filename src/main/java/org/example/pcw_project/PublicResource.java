package org.example.pcw_project;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@JsonIgnoreProperties(ignoreUnknown = true)
public class PublicResource {

    @JsonProperty("rsrcNo")
    private String rsrcNo;

    @JsonProperty("rsrcNm") // 🔥 JSON에서는 이게 key지만
    private String rsrcName; // 👉 자바에서는 의미 있는 이름 사용 가능

    @JsonProperty("insttNm")
    private String insttNm;

    @JsonProperty("ctpvNm")
    private String ctpvNm;

    @JsonProperty("signguNm")
    private String signguNm;

    @JsonProperty("rsrcClNm")
    private String rsrcClNm;

    @JsonProperty("rsrcUseChargeYn")
    private String rsrcUseChargeYn;

    @JsonProperty("rsrcUseCharge")
    private String rsrcUseCharge;

    @JsonProperty("rsrcUsePsbltyBeginHm")
    private String rsrcUsePsbltyBeginHm;

    @JsonProperty("rsrcUsePsbltyEndHm")
    private String rsrcUsePsbltyEndHm;

    @JsonProperty("mangeInsttNm")
    private String mangeInsttNm;

    // Getters and Setters 생략 가능 (필요하면 만들어줄게)
}
