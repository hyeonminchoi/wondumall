package com.wondumall.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wondumall.DTO.AnswerDTO;

@Repository
public class AnswerDAO {
	@Autowired SqlSession sqlSession;

	public int writeAnswer(AnswerDTO answerDTO) {
		return sqlSession.insert("answer.writeAnswer", answerDTO);
	}

	public List<AnswerDTO> getAnswerList(int n_no) {
		return sqlSession.selectList("answer.getAnswerList", n_no);
	}

	public int delete(AnswerDTO answerDTO) {
		return sqlSession.update("answer.delete", answerDTO);
	}
	
	public int edit(AnswerDTO answerDTO) {
		return sqlSession.update("answer.edit", answerDTO);
	}
}
