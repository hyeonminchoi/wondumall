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

	public void del(int p_no) {
		
		sqlSession.update("admin.del", p_no);
	}

	public void pdelete(int p_no) {
		
		sqlSession.delete("admin.pdelete", p_no);
	}

	public void admission(int p_no) {
		
		sqlSession.update("admin.admission", p_no);
	}
}
