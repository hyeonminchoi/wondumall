package com..Config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.security.oauth2.core.ClientAuthenticationMethod;
import org.springframework.security.oauth2.core.oidc.IdTokenClaimNames;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com..Service.CustomOAuth2UserService;
import com..Service.MyUserDetailsService;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true, jsr250Enabled = true)
public class SecurityConfig {
	@Autowired MyUserDetailsService myUserDetailsService;
	
	@Autowired
	private CustomOAuth2UserService customOAuth2UserService;
	
	@Bean
	public BCryptPasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	public WebSecurityCustomizer webSecurityCustomizer() {
		return (web) -> web.ignoring().antMatchers("/resources/**");
	}
	
	@Bean public SessionRegistry sessionRegistry() {
		return new SessionRegistryImpl();
	}
	
	@Bean HttpSessionEventPublisher httpSessionEventPublisher() {
		return new HttpSessionEventPublisher();
	}
	
	@Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }
	
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		//여기 expiredUrl 중복 로그인 시 jsp 만들어서 변경 필요
		http.sessionManagement().maximumSessions(1).sessionRegistry(sessionRegistry()).expiredUrl("/");
		
		http.authorizeRequests()
			.antMatchers("/admin*/**").access("hasRole('ROLE_ADMIN')");
		
		http.csrf().disable().formLogin().loginPage("/login.do").loginProcessingUrl("/login.do")
				.usernameParameter("u_email").passwordParameter("u_pw").defaultSuccessUrl("/")
				.failureUrl("/login.do?error");
		http.logout()
			.logoutRequestMatcher(new AntPathRequestMatcher("/logout.do"))
			.logoutSuccessUrl("/")
			.invalidateHttpSession(true);
		http.oauth2Login().defaultSuccessUrl("/snsInfoCheck.do").userInfoEndpoint().userService(customOAuth2UserService);
		return http.build();
	}
	
	@Bean
	public ClientRegistrationRepository clientRegistrationRepository() {
		return new InMemoryClientRegistrationRepository(this.googleClientRegistration(), this.naverClientRegistration(), this.kakaoClientRegistration());
	}
	
	private ClientRegistration googleClientRegistration() {
 		return ClientRegistration.withRegistrationId("google")
 			.clientId("")
 			.clientSecret("")
 			.clientAuthenticationMethod(ClientAuthenticationMethod.CLIENT_SECRET_BASIC)
 			.authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
 			.redirectUri("http://localhost:8080//login/oauth2/code/google")
 			.scope("profile", "email")
 			.authorizationUri("https://accounts.google.com/o/oauth2/v2/auth")
 			.tokenUri("https://www.googleapis.com/oauth2/v4/token")
 			.userInfoUri("https://www.googleapis.com/oauth2/v3/userinfo")
 			.userNameAttributeName(IdTokenClaimNames.SUB)
 			.jwkSetUri("https://www.googleapis.com/oauth2/v3/certs")
 			.clientName("Google")
 			.build();
	}
	
	private ClientRegistration naverClientRegistration() {
 		return ClientRegistration.withRegistrationId("naver")
 			.clientId("")
 			.clientSecret("")
 			.clientAuthenticationMethod(ClientAuthenticationMethod.CLIENT_SECRET_BASIC)
 			.authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
 			.redirectUri("http://localhost:8080//login/oauth2/code/naver")
 			.scope("name", "email")
 			.authorizationUri("https://nid.naver.com/oauth2.0/authorize")
 			.tokenUri("https://nid.naver.com/oauth2.0/token")
 			.userInfoUri("https://openapi.naver.com/v1/nid/me")
 			.userNameAttributeName("response")
 			.clientName("Naver")
 			.build();
	}
	
	private ClientRegistration kakaoClientRegistration() {
 		return ClientRegistration.withRegistrationId("kakao")
 			.clientId("")
 			.clientSecret("")
 			.clientAuthenticationMethod(ClientAuthenticationMethod.CLIENT_SECRET_BASIC)
 			.authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
 			.redirectUri("http://localhost:8080//login/oauth2/code/kakao")
 			.scope("profile_nickname", "account_email")
 			.authorizationUri("https://kauth.kakao.com/oauth/authorize")
 			.tokenUri("https://kauth.kakao.com/oauth/token")
 			.userInfoUri("https://kapi.kakao.com/v2/user/me")
 			.userNameAttributeName("id")
 			.clientName("Kakao")
 			.clientAuthenticationMethod(ClientAuthenticationMethod.POST)
 			.build();
	}
}