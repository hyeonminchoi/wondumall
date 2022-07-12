package com..DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com..DTO.NoticeCommentDTO;

@Repository
public class NoticeCommentDAO {
	@Autowired SqlSession sqlSession;

	public int writeComment(NoticeCommentDTO noticecommentDTO) {
		return sqlSession.insert("noticeComment.writeComment", noticecommentDTO);
	}

	public List<NoticeCommentDTO> getCommentList(int n_no) {
		return sqlSession.selectList("noticeComment.getCommentList", n_no);
	}

	public int delete(NoticeCommentDTO noticecommentDTO) {
		return sqlSession.update("noticeComment.delete", noticecommentDTO);
	}
	
	public int edit(NoticeCommentDTO noticecommentDTO) {
		return sqlSession.update("noticeComment.edit", noticecommentDTO);
	}
}
