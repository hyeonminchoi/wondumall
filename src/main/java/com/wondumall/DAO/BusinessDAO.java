package com..DAO;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com..DTO.CouponDTO;

@Component
public class BusinessDAO {
	
	@Autowired
	private SqlSession sqlSession;

	public void couponWrite(CouponDTO dto) {
		
		sqlSession.insert("business.couponWrite", dto);
	}

	public int getCount(Map<String, Object> map) {
		
		return sqlSession.selectOne("business.getCount", map);
	}

	public List<CouponDTO> couponList(Map<String, Object> map) {
		
		return sqlSession.selectList("business.couponList", map);
	}
}
