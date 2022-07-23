package com..DTO;

import java.util.Map;

import org.springframework.security.core.userdetails.User;

import com..Config.MyUserDetails;

import lombok.Builder;
import lombok.Data;

@Data
public class OAuthAttributes {
	private Map<String, Object> attributes;
	private String nameAttributeKey;
	private String name;
	private String email;
	private int no;

	@Builder
	public OAuthAttributes(Map<String, Object> attributes, String nameAttributeKey, String name, String email, int no) {
		this.attributes = attributes;
		this.nameAttributeKey = nameAttributeKey;
		this.name = name;
		this.email = email;
		this.no = no;
	}

	public static OAuthAttributes of(String registrationId, String userNameAttributeName,
			Map<String, Object> attributes) {
		// 네이버 로그인 인지 판단.
		if ("naver".equals(registrationId)) {
			return ofNaver("id", attributes);
		} else if ("kakao".equals(registrationId)) {
			return ofKakao("id", attributes);
		}
		return ofGoogle(userNameAttributeName, attributes);
	}

	private static OAuthAttributes ofKakao(String userNameAttributeName, Map<String, Object> attributes) {
		// 응답 받은 사용자의 정보를 Map형태로 변경.
		Map<String, Object> response = (Map<String, Object>) attributes.get("kakao_account");
		Map<String, Object> profile = (Map<String, Object>) response.get("profile");
		// 미리 정의한 속성으로 빌드.
		return OAuthAttributes.builder().name((String) profile.get("nickname")).email((String) response.get("email"))
				.attributes(response).nameAttributeKey(userNameAttributeName).build();
	}
	
	private static OAuthAttributes ofNaver(String userNameAttributeName, Map<String, Object> attributes) {
		// 응답 받은 사용자의 정보를 Map형태로 변경.
		Map<String, Object> response = (Map<String, Object>) attributes.get("response");
		// 미리 정의한 속성으로 빌드.
		return OAuthAttributes.builder().name((String) response.get("name")).email((String) response.get("email"))
				.attributes(response).nameAttributeKey(userNameAttributeName).build();
	}

	public static OAuthAttributes ofGoogle(String userNameAttributeName, Map<String, Object> attributes) {
		// 미리 정의한 속성으로 빌드.
		return OAuthAttributes.builder().name((String) attributes.get("name")).email((String) attributes.get("email"))
				.attributes(attributes).nameAttributeKey(userNameAttributeName).build();
	}
}