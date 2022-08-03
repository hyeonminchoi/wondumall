package com.wondumall.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wondumall.DAO.CategoryDAO;
import com.wondumall.DTO.CategoryDTO;

@Service
public class CategoryService {
	@Autowired private CategoryDAO categoryDAO;

	public List<CategoryDTO> getCategoryList() {
		return categoryDAO.getCategoryList();
	}
}
