package com..DTO;

import lombok.Data;

@Data
public class CartDTO {
	private int cart_no, p_no, u_no, p_count, p_price;
	private String p_img, p_description, p_date;
}
