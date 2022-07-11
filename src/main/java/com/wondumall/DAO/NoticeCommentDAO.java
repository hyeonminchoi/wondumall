package com..DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com..DTO.NoticecommentDTO;

@Repository
public class NoticeCommentDAO {
	@Autowired SqlSession sqlSession;

	public int writeComment(NoticecommentDTO noticecommentDTO) {
		return sqlSession.insert("noticeComment.writeComment", noticecommentDTO);
	}

	public List<NoticecommentDTO> getCommentList(int n_no) {
		return sqlSession.selectList("noticeComment.getCommentList", n_no);
	}

	public int delete(NoticecommentDTO noticecommentDTO) {
		return sqlSession.update("noticeComment.delete", noticecommentDTO);
	}
	
	
}
