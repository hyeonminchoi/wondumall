package com..Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com..DAO.AdminDAO;
import com..DTO.BoardDTO;
import com..DTO.LoginDTO;
import com..DTO.ProductDTO;

@Service
public class AdminService {

	@Autowired
	private AdminDAO adminDAO;

	public List<ProductDTO> productList(Map<String, Object> map) {
		
		return adminDAO.productList(map);
	}

	public void del(int p_no) {
		
		adminDAO.del(p_no);
	}

	public void pdelete(int p_no) {
		
		adminDAO.pdelete(p_no);
	}

	public void admission(int p_no) {
		
		adminDAO.admission(p_no);
	}

	public void repair(int p_no) {
		
		adminDAO.repair(p_no);
	}

	public void adcancel(int p_no) {
		
		adminDAO.adcancel(p_no);
	}

	public int getCount(Map<String, Object> map) {
		
		return adminDAO.getCount(map);
	}

	public List<LoginDTO> userList(Map<String, Object> map) {
		
		return adminDAO.userList(map);
	}

	public int getUserCount(Map<String, Object> map) {
		
		return adminDAO.getUserCount(map);
	}

	public void sec(int u_no) {
		
		adminDAO.sec(u_no);
	}

	public void rep(int u_no) {
		
		adminDAO.rep(u_no);
	}

	public void comsec(int u_no) {
		
		adminDAO.comsec(u_no);
	}

	public void admiss(int u_no) {
		
		adminDAO.admiss(u_no);
	}

	public void adcan(int u_no) {
		
		adminDAO.adcan(u_no);
	}

	public int getBoardCount(Map<String, Object> map) {
		
		return adminDAO.getBoardCount(map);
	}

	public List<BoardDTO> boardList(Map<String, Object> map) {
		
		return adminDAO.boardList(map);
	}

	public void bdel(int b_no) {
		
		adminDAO.bdel(b_no);
	}

	public void rpr(int b_no) {
		
		adminDAO.rpr(b_no);
	}

	public void compledel(int b_no) {
		
		adminDAO.compledel(b_no);
	}
}
