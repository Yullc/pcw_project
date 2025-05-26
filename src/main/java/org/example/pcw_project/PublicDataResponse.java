package org.example.pcw_project;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.example.pcw_project.PublicResource;

import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public class PublicDataResponse {
    private List<PublicResource> data;

    public List<PublicResource> getData() {
        return data;
    }

    public void setData(List<PublicResource> data) {
        this.data = data;
    }
}
