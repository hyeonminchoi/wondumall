package com..DAO;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com..DTO.BoardDTO;
import com..DTO.LoginDTO;
import com..DTO.NoticeDTO;
import com..DTO.ProductDTO;
import com..DTO.QuestionDTO;
import com..DTO.UserDTO;

@Component
public class AdminDAO {
	
	@Autowired
	private SqlSession sqlSession;

	public List<ProductDTO> productList(Map<String, Object> map) {

		return sqlSession.selectList("admin.productList", map);
	}

	public void del(int p_no) {
		
		sqlSession.update("admin.del", p_no);
	}

	public void pdelete(int p_no) {
		
		sqlSession.delete("admin.pdelete", p_no);
	}

	public void admission(int p_no) {
		
		sqlSession.update("admin.admission", p_no);
	}

	public void repair(int p_no) {
		
		sqlSession.update("admin.repair", p_no);
	}

	public void adcancel(int p_no) {
		
		sqlSession.update("admin.adcancel", p_no);
	}

	public int getCount(Map<String, Object> map) {
		
		return sqlSession.selectOne("admin.getCount", map);
	}

	public List<LoginDTO> userList(Map<String, Object> map) {
		
		return sqlSession.selectList("admin.userList", map);
	}

	public int getUserCount(Map<String, Object> map) {
		
		return sqlSession.selectOne("admin.getUserCount", map);
	}

	public void sec(int u_no) {
		
		sqlSession.update("admin.sec", u_no);
	}

	public void rep(int u_no) {
		
		sqlSession.update("admin.rep", u_no);
	}

	public void comsec(int u_no) {
		
		sqlSession.delete("admin.comsec", u_no);
	}

	public void admiss(int u_no) {
		
		sqlSession.update("admin.admiss", u_no);
	}

	public void adcan(int u_no) {
		
		sqlSession.update("admin.adcan", u_no);
	}

	public int getBoardCount(Map<String, Object> map) {
		
		return sqlSession.selectOne("admin.getBoardCount", map);
	}

	public List<BoardDTO> boardList(Map<String, Object> map) {
		
		return sqlSession.selectList("admin.boardList", map);
	}

	public void bdel(int b_no) {
		
		sqlSession.update("admin.bdel", b_no);
	}

	public void rpr(int b_no) {
		
		sqlSession.update("admin.rpr", b_no);
	}

	public void compledel(int b_no) {
		
		sqlSession.delete("admin.compledel", b_no);
	}

	public int getNoticeCount(Map<String, Object> map) {
		
		return sqlSession.selectOne("admin.getNoticeCount", map);
	}

	public List<NoticeDTO> noticeList(Map<String, Object> map) {
		
		return sqlSession.selectList("admin.noticeList", map);
	}

	public void noticecomdel(int n_no) {
	
		sqlSession.delete("admin.noticecomdel", n_no);
	}

	public int getQuestionCount(Map<String, Object> map) {
		
		return sqlSession.selectOne("admin.getQuestionCount", map);
	}

	public List<QuestionDTO> questionList(Map<String, Object> map) {
		
		return sqlSession.selectList("admin.questionList", map);
	}

	public void qdel(int q_no) {
		
		sqlSession.update("admin.qdel", q_no);
	}

	public void qrpr(int q_no) {
		
		sqlSession.update("admin.qrpr", q_no);
	}

	public void qcompledel(int q_no) {
		
		sqlSession.delete("admin.qcompledel", q_no);
	}

}
