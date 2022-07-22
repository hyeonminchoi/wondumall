//servlet-context.xml
package com..Config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com..Util.WebSocketHandler;

@Configuration
@EnableWebSocket
public class ServletConfig implements WebMvcConfigurer, WebSocketConfigurer {
	@Bean
	public MultipartResolver multipartResolver() {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
		return multipartResolver;
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/css/**").addResourceLocations("/resources/css/");
		registry.addResourceHandler("/js/**").addResourceLocations("/resources/js/");
		registry.addResourceHandler("/upload/**").addResourceLocations("/resources/upload/");
		registry.addResourceHandler("/img/**").addResourceLocations("/resources/img/");
		registry.addResourceHandler("/font/**").addResourceLocations("/resources/font/");
		registry.addResourceHandler("/fonts/**").addResourceLocations("/resources/fonts/");
		registry.addResourceHandler("/images/**").addResourceLocations("/resources/images/");
		registry.addResourceHandler("/vendor/**").addResourceLocations("/resources/vendor/");
		registry.addResourceHandler("/productUpload/**").addResourceLocations("/resources/productUpload/");
		registry.addResourceHandler("/noticeImage/**").addResourceLocations("/resources/noticeImage/");
		registry.addResourceHandler("/boardImage/**").addResourceLocations("/resources/boardImage/");
		registry.addResourceHandler("/questionImage/**").addResourceLocations("/resources/questionImage/");
		registry.addResourceHandler("/faqImage/**").addResourceLocations("/resources/faqImage/");
	}

	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		registry.jsp("/WEB-INF/views/", ".jsp");
	}

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(websocketHandler(), "/chat").addInterceptors(new HttpSessionHandshakeInterceptor());
	}
	
	@Bean
	public WebSocketHandler websocketHandler() {
		return new WebSocketHandler();
	}

}