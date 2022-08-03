package com.wondumall.DTO;

import lombok.Data;

@Data
public class UserDTO {
	private int u_no, u_confirm;
	private String u_email, u_pw, u_name, u_postcode, u_roadAddress, u_detailAddress, 
	u_joindate, u_grade, u_img;
}
