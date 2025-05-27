package org.example;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Getter;

import java.util.List;

@Getter
@JsonIgnoreProperties(ignoreUnknown = true)
public class PublicDataResponse {
    private List<PublicResource> data;

    public void setData(List<PublicResource> data) {
        this.data = data;
    }
}
