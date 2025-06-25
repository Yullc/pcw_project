package org.example.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.*;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // WebSocket 연결 주소: /ws-stomp
        registry.addEndpoint("/ws-stomp")
                .setAllowedOriginPatterns("*")
                .withSockJS(); // SockJS 사용 가능하도록 설정
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        // 메시지 구독 경로 prefix (서버 -> 클라이언트)
        registry.enableSimpleBroker("/sub");

        // 메시지 발행 경로 prefix (클라이언트 -> 서버)
        registry.setApplicationDestinationPrefixes("/pub");
    }
}
