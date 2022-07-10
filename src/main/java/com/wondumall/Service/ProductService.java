package com..Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com..DAO.ProductDAO;
import com..DTO.CategoryDTO;
import com..DTO.ProductDTO;

@Service
public class ProductService {
	
	@Autowired
	private ProductDAO productDAO;

	public List<ProductDTO> productList(CategoryDTO dto) {
		return productDAO.productList(dto);
	}

	public int productAdd(ProductDTO add) {
		return productDAO.productAdd(add);
	}

}
