package com.wondumall.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wondumall.DTO.FaqCategoryDTO;
import com.wondumall.DTO.FaqDTO;

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

	public int delete(FaqDTO faqDTO) {
		return sqlSession.delete("faq.delete", faqDTO);
	}

	public FaqDTO getFaqDetail(int faq_no) {
		return sqlSession.selectOne("faq.getFaqDetail", faq_no);
	}

	public int edit(FaqDTO faqDTO) {
		return sqlSession.update("faq.edit", faqDTO);
	}
	
}
