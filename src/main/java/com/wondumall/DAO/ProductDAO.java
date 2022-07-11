package com..DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com..DTO.CategoryDTO;
import com..DTO.ProductDTO;

@Repository
public class ProductDAO {
	
	@Autowired
	private SqlSession sqlSession;

	public List<ProductDTO> productList(CategoryDTO dto) {
		return sqlSession.selectList("product.productList", dto);
	}

	public int productAdd(ProductDTO add) {
		return sqlSession.insert("product.productAdd", add);
	}
}
