//servlet-context.xml
package com..Config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class ServletConfig implements WebMvcConfigurer {
	@Bean
	public MultipartResolver multipartResolver() {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
		return multipartResolver;
	}
	
//	@Override
//	public void addViewControllers(ViewControllerRegistry registry) {
//		registry.addViewController("/").setViewName("./index");
//	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/css/**").addResourceLocations("/resources/css/");
		registry.addResourceHandler("/js/**").addResourceLocations("/resources/js/");
		registry.addResourceHandler("/upload/**").addResourceLocations("/resources/upload/");
		registry.addResourceHandler("/img/**").addResourceLocations("/resources/img/");
		registry.addResourceHandler("/font/**").addResourceLocations("/resources/font/");
		registry.addResourceHandler("/images/**").addResourceLocations("/resources/images/");
		registry.addResourceHandler("/productUpload/**").addResourceLocations("/resources/productUpload/");
		registry.addResourceHandler("/noticeImage/**").addResourceLocations("/resources/noticeImage/");
		registry.addResourceHandler("/boardImage/**").addResourceLocations("/resources/boardImage/");
	}

	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		registry.jsp("/WEB-INF/views/", ".jsp");
	}

}