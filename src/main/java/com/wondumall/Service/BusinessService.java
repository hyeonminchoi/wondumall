package com.wondumall.Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wondumall.DAO.BusinessDAO;
import com.wondumall.DTO.CouponDTO;

@Service
public class BusinessService {

	@Autowired
	private BusinessDAO businessDAO;

	public int couponWrite(CouponDTO dto) {
		
		return businessDAO.couponWrite(dto);
	}

	public int getCount(Map<String, Object> map) {
		
		return businessDAO.getCount(map);
	}

	public List<CouponDTO> couponList(Map<String, Object> map) {
		
		return businessDAO.couponList(map);
	}

	public void coupondel(int coupon_no) {
		
		businessDAO.coupondel(coupon_no);
	}

	public void couponrepair(int coupon_no) {
		
		businessDAO.couponrepair(coupon_no);
	}

	public void couponcdel(int coupon_no) {
		
		businessDAO.couponcdel(coupon_no);
	}
}
