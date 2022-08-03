package com.wondumall.Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wondumall.DAO.QuestionDAO;
import com.wondumall.DTO.QuestionDTO;

@Service
public class QuestionService {
	@Autowired private QuestionDAO questionDAO;

	public int getCount(Map<String, Object> map) {
		return questionDAO.getCount(map);
	}

	public List<QuestionDTO> getQuestionList(Map<String, Object> map) {
		return questionDAO.getQuestionList(map);
	}

	public QuestionDTO getDetail(int n_no) {
		return questionDAO.getDetail(n_no);
	}

	public int write(QuestionDTO questionDTO) {
		return questionDAO.write(questionDTO);
	}

	public int delete(QuestionDTO questionDTO) {
		return questionDAO.delete(questionDTO);
	}

	public int edit(QuestionDTO questionDTO) {
		return questionDAO.edit(questionDTO);
	}
	
}
