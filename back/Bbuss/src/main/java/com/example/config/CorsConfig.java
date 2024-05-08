package com.example.config; // แนะนำให้ใช้ชื่อแพคเกจที่เหมาะสม

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

@Configuration
public class CorsConfig {
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.addAllowedOrigin("*"); // อนุญาตให้มาจากทุกแหล่ง
        configuration.addAllowedMethod("*"); // อนุญาตการร้องขอทุกประเภท (GET, POST, PUT, DELETE, ฯลฯ)
        configuration.addAllowedHeader("*"); // อนุญาต Header ทุกอย่าง

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}
