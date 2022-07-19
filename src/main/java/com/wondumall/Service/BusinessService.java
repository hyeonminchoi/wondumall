package com..Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com..DAO.BusinessDAO;
import com..DTO.CouponDTO;

@Service
public class BusinessService {

	@Autowired
	private BusinessDAO businessDAO;

	public void couponWrite(CouponDTO dto) {
		
		businessDAO.couponWrite(dto);
	}

	public int getCount(Map<String, Object> map) {
		
		return businessDAO.getCount(map);
	}

	public List<CouponDTO> couponList(Map<String, Object> map) {
		
		return businessDAO.couponList(map);
	}
}
