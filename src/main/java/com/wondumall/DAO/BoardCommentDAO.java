package com..DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com..DTO.BoardCommentDTO;

@Repository
public class BoardCommentDAO {
	@Autowired SqlSession sqlSession;

	public int writeComment(BoardCommentDTO boardcommentDTO) {
		return sqlSession.insert("boardComment.writeComment", boardcommentDTO);
	}

	public List<BoardCommentDTO> getCommentList(int n_no) {
		return sqlSession.selectList("boardComment.getCommentList", n_no);
	}

	public int delete(BoardCommentDTO boardcommentDTO) {
		return sqlSession.update("boardComment.delete", boardcommentDTO);
	}
	
	public int edit(BoardCommentDTO boardcommentDTO) {
		return sqlSession.update("boardComment.edit", boardcommentDTO);
	}
}
