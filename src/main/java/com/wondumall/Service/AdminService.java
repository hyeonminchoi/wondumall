package com..Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com..DAO.AdminDAO;
import com..DTO.LoginDTO;
import com..DTO.ProductDTO;
import com..DTO.UserDTO;

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
}
