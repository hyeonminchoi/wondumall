package com..Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com..DAO.BoardCommentDAO;
import com..DTO.BoardCommentDTO;

@Service
public class BoardCommentService {
	@Autowired BoardCommentDAO boardCommentDAO;

	public int writeComment(BoardCommentDTO boardcommentDTO) {
		return boardCommentDAO.writeComment(boardcommentDTO);
	}

	public List<BoardCommentDTO> getCommentList(int n_no) {
		return boardCommentDAO.getCommentList(n_no);
	}

	public int delete(BoardCommentDTO boardcommentDTO) {
		return boardCommentDAO.delete(boardcommentDTO);
	}

	public int edit(BoardCommentDTO boardcommentDTO) {
		return boardCommentDAO.edit(boardcommentDTO);
	}
	
	
}
