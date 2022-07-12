package com..DTO;

import lombok.Data;

@Data
public class ReviewDTO {
	private int r_no, p_no, u_no;
	private double r_rating;
	private String r_title, r_content;
}
