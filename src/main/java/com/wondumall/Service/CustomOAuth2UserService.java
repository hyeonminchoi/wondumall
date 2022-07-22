package com..Service;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com..Config.MyUserDetails;
import com..DAO.LoginDAO;
import com..DTO.LoginDTO;
import com..DTO.OAuthAttributes;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {
	@Autowired private LoginDAO loginDAO;
	
    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
    	OAuth2UserService<OAuth2UserRequest, OAuth2User> delegate = new DefaultOAuth2UserService();
    	 OAuth2User oAuth2User = delegate.loadUser(userRequest);
         //네이버 로그인인지 구글로그인인지 서비스를 구분해주는 코드
         String registrationId = userRequest.getClientRegistration().getRegistrationId();
         //OAuth2 로그인 진행시 키가 되는 필드값 프라이머리키와 같은 값 네이버 카카오 지원 x
         String userNameAttributeName = userRequest.getClientRegistration().getProviderDetails()
                                         .getUserInfoEndpoint().getUserNameAttributeName();
         //OAuth2UserService를 통해 가져온 데이터를 담을 클래스
         OAuthAttributes attributes = OAuthAttributes.of(registrationId, userNameAttributeName, oAuth2User.getAttributes());
         
         LoginDTO user = findByUserEmail(attributes, registrationId);
         return new MyUserDetails(user);
    }
    
    private LoginDTO findByUserEmail(OAuthAttributes attributes, String registrationId){
    	LoginDTO user = new LoginDTO();
    	user.setU_email(attributes.getEmail());
    	user.setU_provider(registrationId);
    	
    	user = loginDAO.findByUserid(user);
    	//여기서 개인정보 없다면 회원가입 필요
    	return user;
    }
}