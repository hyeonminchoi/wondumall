package com..Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com..DAO.ProductDAO;
import com..DTO.CartDTO;
import com..DTO.CategoryDTO;
import com..DTO.ProductDTO;
import com..DTO.ReviewDTO;

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

	public ProductDTO productDetail(int p_no) {
		return productDAO.productDetail(p_no);
	}

	public void productReview(ReviewDTO dto) {
		productDAO.productReview(dto);
	}

	public int cartAdd(CartDTO dto) {
		return productDAO.cartAdd(dto);
	}

	public List<CartDTO> cart(int u_no) {
		return productDAO.cartAdd(u_no);
	}

	public int cartCount(int u_no) {
		return productDAO.cartCount(u_no);
	}

	public int containProduct(CartDTO dto) {
		return productDAO.containProduct(dto);
	}

	public int cartUpdate(CartDTO dto) {
		return productDAO.cartUpdate(dto);
	}

	public void cartDelete(CartDTO cartDTO) {
		productDAO.cartDelete(cartDTO);
	}

	public int reviewStatus(ReviewDTO dto) {
		return productDAO.reviewStatus(dto);
	}

	public List<ReviewDTO> reviewList(Map<String, Object> map) {
		return productDAO.reviewList(map);
	}

	public int reviewCount(int p_no) {
		return productDAO.reviewCount(p_no);
	}

	public double reviewRating(int p_no) throws Exception{
		return productDAO.reviewRating(p_no);
	}
}
