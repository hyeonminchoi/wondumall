package com.wondumall.DTO;

import java.util.Date;

import lombok.Data;

@Data
public class OrderDTO {
	private int o_no, o_amount, u_no, p_no, o_price;
	private String o_status, o_name, o_tel, o_postcode, o_roadAddress, o_detailAddress, o_request, o_email, o_extraAddress, imp_uid, merchant_uid, o_pname;
	private Date o_date;
}
