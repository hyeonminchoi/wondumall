package com.wondumall.DTO;

import lombok.Data;

@Data
public class ProductDTO {
	private int p_no, cate_no, p_price, p_stock, p_confirm, p_del, u_no, r_count;
	private double rating;
	private String p_name, p_description, p_img, p_date, u_name, category;
}
