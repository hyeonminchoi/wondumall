package com..DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com..DTO.ProductDTO;

@Component
public class AdminDAO {
	
	@Autowired
	private SqlSession sqlSession;

	public List<ProductDTO> productList() {

		return sqlSession.selectList("admin.productList");
	}
}
