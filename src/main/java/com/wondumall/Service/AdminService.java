package com..Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com..DAO.AdminDAO;
import com..DTO.PageDTO;
import com..DTO.ProductDTO;

@Service
public class AdminService {

	@Autowired
	private AdminDAO adminDAO;

	public List<ProductDTO> productList(PageDTO page) {
		
		return adminDAO.productList(page);
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

	public int getCount() {
		
		return adminDAO.getCount();
	}
}
