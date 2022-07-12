package com..DTO;

import lombok.Data;

@Data
public class ProductDTO {
	private int p_no, cate_no, p_price, p_stock, p_confirm;
	private String p_name, p_description, p_img, p_date;
}
