package com..Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com..DAO.AdminDAO;
import com..DTO.ProductDTO;

@Service
public class AdminService {

	@Autowired
	private AdminDAO adminDAO;

	public List<ProductDTO> productList() {
		
		return adminDAO.productList();
	}
}
