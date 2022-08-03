//root-context.xml
package com.wondumall.Config;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.DefaultPaginationManager;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.DefaultPaginationRenderer;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationRenderer;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.wondumall.Util.ImagePaginationRenderer;

@Configuration
@EnableWebMvc
@ComponentScan("com.wondumall.*")
public class RootConfig {
	@Autowired private ApplicationContext applicationContext;
	
	@Bean
	public ImagePaginationRenderer imageRenderer() {
		ImagePaginationRenderer imagePaginationRenderer = new ImagePaginationRenderer();
		return imagePaginationRenderer;
	}

	@Bean
	public DefaultPaginationRenderer textRenderer() {
		DefaultPaginationRenderer defaultPaginationRenderer = new DefaultPaginationRenderer();
		return defaultPaginationRenderer;
	}

	@Bean
	public DefaultPaginationManager paginationManager() {
		DefaultPaginationManager defaultPaginationManager = new DefaultPaginationManager();
		Map<String, PaginationRenderer> map = new HashMap<>();
		map.put("image", imageRenderer());
		map.put("text", textRenderer());
		defaultPaginationManager.setRendererType(map);
		return defaultPaginationManager;
	}

	@Bean
	public DriverManagerDataSource dataSource() {
		DriverManagerDataSource source = new DriverManagerDataSource();
		source.setDriverClassName("org.mariadb.jdbc.Driver");
		source.setUrl("jdbc:mariadb:///wondumall?allowMultiQueries=true");
		source.setUsername("wondumall");
		source.setPassword("");
		return source;
	}

	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setDataSource(dataSource());
		sqlSessionFactoryBean
				.setConfigLocation(applicationContext.getResource("classpath:/mybatisConfig/mybatisConfig.xml"));
		sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath:/mapper/**/*_SQL.xml"));
		return sqlSessionFactoryBean.getObject();
	}

	@Bean
	public SqlSession sqlSession() throws Exception {
		SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory());
		return sqlSessionTemplate;
	}
}