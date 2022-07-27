package com..DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com..DTO.CategoryDTO;

@Repository
public class CategoryDAO {
	@Autowired SqlSession sqlSession;
	
	public List<CategoryDTO> getCategoryList(){
		return sqlSession.selectList("category.getCategoryList");
	}
}
