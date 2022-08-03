package com.wondumall.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wondumall.DAO.AnswerDAO;
import com.wondumall.DTO.AnswerDTO;

@Service
public class AnswerService {
	@Autowired AnswerDAO answerDAO;

	public int writeAnswer(AnswerDTO answerDTO) {
		return answerDAO.writeAnswer(answerDTO);
	}

	public List<AnswerDTO> getAnswerList(int n_no) {
		return answerDAO.getAnswerList(n_no);
	}

	public int delete(AnswerDTO answerDTO) {
		return answerDAO.delete(answerDTO);
	}

	public int edit(AnswerDTO answerDTO) {
		return answerDAO.edit(answerDTO);
	}
	
	
}
