package com.wondumall.DAO;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.wondumall.DTO.CouponDTO;

@Component
public class BusinessDAO {
	
	@Autowired
	private SqlSession sqlSession;

	public int couponWrite(CouponDTO dto) {
		
		return sqlSession.insert("business.couponWrite", dto);
	}

	public int getCount(Map<String, Object> map) {
		
		return sqlSession.selectOne("business.getCount", map);
	}

	public List<CouponDTO> couponList(Map<String, Object> map) {
		
		return sqlSession.selectList("business.couponList", map);
	}

	public void coupondel(int coupon_no) {
		
		sqlSession.update("business.coupondel", coupon_no);
	}

	public void couponrepair(int coupon_no) {
		
		sqlSession.update("business.couponrepair", coupon_no);
	}

	public void couponcdel(int coupon_no) {
		
		sqlSession.delete("business.couponcdel", coupon_no);
	}
}
