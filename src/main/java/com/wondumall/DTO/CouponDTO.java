package com..DTO;

import lombok.Data;

@Data
public class CouponDTO {
	private int coupon_no, coupon_minorder, coupon_del;
	private double coupon_per;
	private String coupon_description;
}
