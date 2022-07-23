package com..Service;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
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
	@Autowired private BCryptPasswordEncoder passwordEncoder;
	
    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
    	OAuth2UserService<OAuth2UserRequest, OAuth2User> delegate = new DefaultOAuth2UserService();
    	 OAuth2User oAuth2User = delegate.loadUser(userRequest);
    	 
         //네이버, 구글, 카카오 로그인을 구분해주는 id
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
    	if(user==null) { //sns 로그인을 처음하는 거라면 회원가입
    		user = new LoginDTO();
    		user.setU_email(attributes.getEmail());
        	user.setU_provider(registrationId);
        	user.setU_name(attributes.getName());
        	user.setU_pw(passwordEncoder.encode(RandomStringUtils.randomAlphanumeric(10))); //비밀번호는 랜덤생성
        	loginDAO.SNSjoin(user);
    	}
    	return user;
    }
}