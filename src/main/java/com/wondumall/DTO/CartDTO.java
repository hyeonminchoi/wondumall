package com.wondumall.DTO;

import lombok.Data;

@Data
public class CartDTO {
	private int cart_no, p_no, u_no, p_count, p_price, sumPrice, p_check;
	private String p_img, p_description, p_date, p_name;
}
