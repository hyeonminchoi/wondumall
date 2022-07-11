package com..Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com..DAO.NoticeCommentDAO;
import com..DTO.NoticecommentDTO;

@Service
public class NoticeCommentService {
	@Autowired NoticeCommentDAO noticeCommentDAO;

	public int writeComment(NoticecommentDTO noticecommentDTO) {
		return noticeCommentDAO.writeComment(noticecommentDTO);
	}

	public List<NoticecommentDTO> getCommentList(int n_no) {
		return noticeCommentDAO.getCommentList(n_no);
	}

	public int delete(NoticecommentDTO noticecommentDTO) {
		return noticeCommentDAO.delete(noticecommentDTO);
	}
	
	
}
