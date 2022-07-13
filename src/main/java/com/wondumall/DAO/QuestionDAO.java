package com..DAO;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com..DTO.QuestionDTO;

@Repository
public class QuestionDAO {
	@Autowired private SqlSession sqlSession;

	public int getCount(Map<String, Object> map) {
		return sqlSession.selectOne("question.getCount", map);
	}

	public List<QuestionDTO> getQuestionList(Map<String, Object> map) {
		return sqlSession.selectList("question.getQuestionList", map);
	}

	public QuestionDTO getDetail(int q_no) {
		return sqlSession.selectOne("question.getDetail", q_no);
	}

	public int write(QuestionDTO questionDTO) {
		return sqlSession.insert("question.write", questionDTO);
	}

	public int delete(QuestionDTO questionDTO) {
		return sqlSession.update("question.delete", questionDTO);
	}

	public int edit(QuestionDTO questionDTO) {
		return sqlSession.update("question.edit", questionDTO);
	}
}
