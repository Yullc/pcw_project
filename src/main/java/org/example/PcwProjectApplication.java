package org.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class PcwProjectApplication extends SpringBootServletInitializer {


    public static void main(String[] args) {
        SpringApplication.run(PcwProjectApplication.class, args);
    }

}
