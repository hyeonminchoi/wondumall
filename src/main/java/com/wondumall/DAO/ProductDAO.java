package com..DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com..DTO.CartDTO;
import com..DTO.CategoryDTO;
import com..DTO.ProductDTO;
import com..DTO.ReviewDTO;

@Repository
public class ProductDAO {
	
	@Autowired
	private SqlSession sqlSession;

	public List<ProductDTO> productList(CategoryDTO dto) {
		return sqlSession.selectList("product.productList", dto);
	}

	public int productAdd(ProductDTO add) {
		return sqlSession.insert("product.productAdd", add);
	}

	public ProductDTO productDetail(int p_no) {
		return sqlSession.selectOne("product.productDetail", p_no);
	}

	public void productReview(ReviewDTO dto) {
		sqlSession.insert("product.productReview", dto);
	}

	public int cartAdd(CartDTO dto) {
		return sqlSession.insert("product.cartAdd", dto);
	}

	public List<CartDTO> cartAdd(int u_no) {
		return sqlSession.selectList("product.cart", u_no);
	}

	public int cartCount(int u_no) {
		return sqlSession.selectOne("product.cartCount", u_no);
	}

	public int containProduct(CartDTO dto) {
		return sqlSession.selectOne("product.containProduct", dto);
	}

	public int cartUpdate(CartDTO dto) {
		return sqlSession.update("product.cartUpdate", dto);
	}

	public void cartDelete(CartDTO cartDTO) {
		sqlSession.delete("product.cartDelete", cartDTO);
	}
}
