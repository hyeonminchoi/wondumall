package com..Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com..DAO.FaqDAO;
import com..DTO.FaqCategoryDTO;
import com..DTO.FaqDTO;

@Service
public class FaqService {
	@Autowired private FaqDAO faqDAO;

	public int write(FaqDTO faqDTO) {
		return faqDAO.write(faqDTO);
	}

	public List<FaqCategoryDTO> getFaqCategory() {
		return faqDAO.getFaqCategory();
	}

	public List<FaqDTO> getFaqCategoryDetail(String fc_category) {
		return faqDAO.getFaqCategoryDetail(fc_category);
	}

	public int delete(FaqDTO faqDTO) {
		return faqDAO.delete(faqDTO);
	}

	public FaqDTO getFaqDetail(int faq_no) {
		return faqDAO.getFaqDetail(faq_no);
	}

	public int edit(FaqDTO faqDTO) {
		return faqDAO.edit(faqDTO);
	}
	
}
