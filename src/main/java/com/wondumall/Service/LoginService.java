package com..Service;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com..DAO.LoginDAO;
import com..DTO.LoginDTO;

@Service
public class LoginService {
	@Autowired
	private LoginDAO loginDAO;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	public LoginDTO login(LoginDTO dto) {
		return loginDAO.login(dto);
	}

	public int join(LoginDTO dto) {
		dto.setU_pw(passwordEncoder.encode(dto.getU_pw()));
		return loginDAO.join(dto);
	}

	public int emailCheck(String email) {
		return loginDAO.emailCheck(email);
	}

	public int nicknameCheck(String nickname) {
		return loginDAO.nicknameCheck(nickname);
	}

		
		
	
	
	

}
