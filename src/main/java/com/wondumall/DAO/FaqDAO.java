package com..DAO;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com..DTO.FaqCategoryDTO;
import com..DTO.FaqDTO;

@Repository
public class FaqDAO {
	@Autowired SqlSession sqlSession;

	public int write(FaqDTO faqDTO) {
		return sqlSession.insert("faq.write", faqDTO);
	}

	public List<FaqCategoryDTO> getFaqCategory() {
		return sqlSession.selectList("faq.getFaqCategory");
	}

	public List<FaqDTO> getFaqCategoryDetail(String fc_category) {
		return sqlSession.selectList("faq.getFaqCategoryDetail", fc_category);
	}
	
}
