package com..Config;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import com..DTO.LoginDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
public class MyUserDetails implements UserDetails, OAuth2User {
	//변경 불가(변수명도 변경 불가)
    private static final long serialVersionUID = 1L;

    final boolean accountNonExpired = true;
    final boolean accountNonLocked = true;
    final boolean credentialsNonExpired = true;
    final String password;
    final String username; //이게 이메일
    final boolean isEnabled;
    Collection<SimpleGrantedAuthority> authorities = new ArrayList<>();

    //변경 가능
    final String name, postcode, roadAddress, extraAddress, detailAddress, joindate, img, nickname, provider;
    final int grade, resign, no;

    //생성자
    public MyUserDetails(LoginDTO user) {
    	//변경 불가
        switch (user.getU_grade()) {
        case 0: authorities.add(new SimpleGrantedAuthority("ROLE_USER")); break;
        case 1: authorities.add(new SimpleGrantedAuthority("ROLE_BUSINESS")); break;
        case 2: authorities.add(new SimpleGrantedAuthority("ROLE_ADMIN")); break;
        }
        this.username = user.getU_email();
        this.password = user.getU_pw();
        this.isEnabled = (user.getU_confirm() == 1) && (user.getU_resign()==0); //승인을 받았고, 탈퇴를 안 했을 시 true
        //변경 가능
        this.no = user.getU_no();
        this.name = user.getU_name();
        this.postcode = user.getU_postcode();
        this.roadAddress = user.getU_roadAddress();
        this.extraAddress = user.getU_extraAddress();
        this.detailAddress = user.getU_detailAddress();
        this.joindate = user.getU_joindate();
        this.img = user.getU_img();
        this.nickname = user.getU_nickname();
        this.provider = user.getU_provider();
        this.grade = user.getU_grade();
        this.resign = user.getU_resign();
    }

	@Override
	public Map<String, Object> getAttributes() {
		// TODO Auto-generated method stub
		return null;
	}
}
