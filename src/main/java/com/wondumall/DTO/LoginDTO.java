package com.wondumall.DTO;

import lombok.Data;

@Data
public class LoginDTO {
	private int u_no, u_confirm, u_grade, u_resign;
	private String u_email, u_pw, u_name, u_postcode, u_detailAddress, u_extraAddress,
					u_joindate, u_img, u_roadAddress, u_nickname, u_provider, u_tel;

}
