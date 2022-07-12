package com..DAO;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com..DTO.NoticeDTO;

@Repository
public class NoticeDAO {
	@Autowired private SqlSession sqlSession;

	public int getCount(Map<String, Object> map) {
		return sqlSession.selectOne("notice.getCount", map);
	}

	public List<NoticeDTO> getNoticeList(Map<String, Object> map) {
		return sqlSession.selectList("notice.getNoticeList", map);
	}

	public NoticeDTO getDetail(int n_no) {
		return sqlSession.selectOne("notice.getDetail", n_no);
	}

	public int write(NoticeDTO noticeDTO) {
		return sqlSession.insert("notice.write", noticeDTO);
	}

	public int delete(NoticeDTO noticeDTO) {
		return sqlSession.update("notice.delete", noticeDTO);
	}

	public int edit(NoticeDTO noticeDTO) {
		return sqlSession.update("notice.edit", noticeDTO);
	}

	public void countUp(int n_no) {
		sqlSession.update("notice.countUp", n_no);
	}
}
