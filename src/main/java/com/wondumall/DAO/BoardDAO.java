package com..DAO;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com..DTO.BoardDTO;

@Repository
public class BoardDAO {
	@Autowired private SqlSession sqlSession;

	public int getCount(Map<String, Object> map) {
		return sqlSession.selectOne("board.getCount", map);
	}

	public List<BoardDTO> getBoardList(Map<String, Object> map) {
		return sqlSession.selectList("board.getBoardList", map);
	}

	public BoardDTO getDetail(int n_no) {
		return sqlSession.selectOne("board.getDetail", n_no);
	}

	public int write(BoardDTO boardDTO) {
		return sqlSession.insert("board.write", boardDTO);
	}

	public int delete(BoardDTO boardDTO) {
		return sqlSession.update("board.delete", boardDTO);
	}

	public int edit(BoardDTO boardDTO) {
		return sqlSession.update("board.edit", boardDTO);
	}

	public void countUp(int n_no) {
		sqlSession.update("board.countUp", n_no);
	}

	public int containLike(BoardDTO boardDTO) {
		return sqlSession.selectOne("board.containLike", boardDTO);
	}

	public void deleteLike(BoardDTO boardDTO) {
		sqlSession.delete("board.deleteLike", boardDTO);
	}

	public void insertLike(BoardDTO boardDTO) {
		sqlSession.insert("board.insertLike", boardDTO);
	}

	public int like(int n_no) {
		return sqlSession.selectOne("board.like", n_no);
	}

	public void updateLike(int n_no) {
		sqlSession.update("board.updateLike", n_no);
	}
}
