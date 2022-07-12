package com..Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com..DAO.NoticeCommentDAO;
import com..DTO.NoticeCommentDTO;

@Service
public class NoticeCommentService {
	@Autowired NoticeCommentDAO noticeCommentDAO;

	public int writeComment(NoticeCommentDTO noticecommentDTO) {
		return noticeCommentDAO.writeComment(noticecommentDTO);
	}

	public List<NoticeCommentDTO> getCommentList(int n_no) {
		return noticeCommentDAO.getCommentList(n_no);
	}

	public int delete(NoticeCommentDTO noticecommentDTO) {
		return noticeCommentDAO.delete(noticecommentDTO);
	}

	public int edit(NoticeCommentDTO noticecommentDTO) {
		return noticeCommentDAO.edit(noticecommentDTO);
	}
	
	
}
