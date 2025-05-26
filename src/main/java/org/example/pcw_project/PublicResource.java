package org.example.pcw_project;

import com.fasterxml.jackson.annotation.JsonProperty;

public class PublicResource {

    @JsonProperty("rsrcNo")
    private String rsrcNo;

    @JsonProperty("rsrcName")
    private String rsrcName;

    @JsonProperty("insttNm")
    private String insttNm;

    @JsonProperty("rsrcClNm")
    private String rsrcClNm;

    @JsonProperty("ctpvNm")
    private String ctpvNm;

    @JsonProperty("signguNm")
    private String signguNm;

    @JsonProperty("mangeInsttNm")
    private String mangeInsttNm;

    @JsonProperty("rsrcUseChargeYn")
    private String rsrcUseChargeYn;

    @JsonProperty("rsrcUseCharge")
    private String rsrcUseCharge;

    @JsonProperty("rsrcUsePsbltyBeginHm")
    private String rsrcUsePsbltyBeginHm;

    @JsonProperty("rsrcUsePsbltyEndHm")
    private String rsrcUsePsbltyEndHm;

    // getter/setter
    public String getRsrcNo() { return rsrcNo; }
    public void setRsrcNo(String rsrcNo) { this.rsrcNo = rsrcNo; }

    public String getRsrcName() { return rsrcName; }
    public void setRsrcName(String rsrcName) { this.rsrcName = rsrcName; }

    public String getInsttNm() { return insttNm; }
    public void setInsttNm(String insttNm) { this.insttNm = insttNm; }

    public String getRsrcClNm() { return rsrcClNm; }
    public void setRsrcClNm(String rsrcClNm) { this.rsrcClNm = rsrcClNm; }

    public String getCtpvNm() { return ctpvNm; }
    public void setCtpvNm(String ctpvNm) { this.ctpvNm = ctpvNm; }

    public String getSignguNm() { return signguNm; }
    public void setSignguNm(String signguNm) { this.signguNm = signguNm; }

    public String getMangeInsttNm() { return mangeInsttNm; }
    public void setMangeInsttNm(String mangeInsttNm) { this.mangeInsttNm = mangeInsttNm; }

    public String getRsrcUseChargeYn() { return rsrcUseChargeYn; }
    public void setRsrcUseChargeYn(String rsrcUseChargeYn) { this.rsrcUseChargeYn = rsrcUseChargeYn; }

    public String getRsrcUseCharge() { return rsrcUseCharge; }
    public void setRsrcUseCharge(String rsrcUseCharge) { this.rsrcUseCharge = rsrcUseCharge; }

    public String getRsrcUsePsbltyBeginHm() { return rsrcUsePsbltyBeginHm; }
    public void setRsrcUsePsbltyBeginHm(String rsrcUsePsbltyBeginHm) { this.rsrcUsePsbltyBeginHm = rsrcUsePsbltyBeginHm; }

    public String getRsrcUsePsbltyEndHm() { return rsrcUsePsbltyEndHm; }
    public void setRsrcUsePsbltyEndHm(String rsrcUsePsbltyEndHm) { this.rsrcUsePsbltyEndHm = rsrcUsePsbltyEndHm; }
}
