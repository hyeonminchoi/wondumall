package com..Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com..DAO.BoardDAO;
import com..DTO.BoardDTO;

@Service
public class BoardService {
	@Autowired private BoardDAO boardDAO;

	public int getCount(Map<String, Object> map) {
		return boardDAO.getCount(map);
	}

	public List<BoardDTO> getBoardList(Map<String, Object> map) {
		return boardDAO.getBoardList(map);
	}

	public BoardDTO getDetail(int n_no) {
		return boardDAO.getDetail(n_no);
	}

	public int write(BoardDTO boardDTO) {
		return boardDAO.write(boardDTO);
	}

	public int delete(BoardDTO boardDTO) {
		return boardDAO.delete(boardDTO);
	}

	public int edit(BoardDTO boardDTO) {
		return boardDAO.edit(boardDTO);
	}

	public void countUp(int n_no) {
		boardDAO.countUp(n_no);
	}

	public int containLike(BoardDTO boardDTO) {
		return boardDAO.containLike(boardDTO);
	}

	public void deleteLike(BoardDTO boardDTO) {
		boardDAO.deleteLike(boardDTO);
	}

	public void insertLike(BoardDTO boardDTO) {
		boardDAO.insertLike(boardDTO);
	}

	public int like(int n_no) {
		return boardDAO.like(n_no);
	}

	public void updateLike(int n_no) {
		boardDAO.updateLike(n_no);
	}
	
	
}
