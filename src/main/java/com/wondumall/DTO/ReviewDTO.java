package com.wondumall.DTO;

import lombok.Data;

@Data
public class ReviewDTO {
	private int r_no, p_no, u_no, r_del;
	private double r_rating;
	private String r_title, r_content, r_date, u_nickname;
}
