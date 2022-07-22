package com..DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com..DTO.CartDTO;
import com..DTO.OrderDTO;
import com..DTO.ProductDTO;
import com..DTO.UserDTO;

@Repository
public class PaymentDAO {
	
	@Autowired
	private SqlSession sqlSession;

	public void checkout(OrderDTO orderInfo) {
		
		sqlSession.insert("payment.checkout", orderInfo);
	}

	public void user(UserDTO user) {
		
		sqlSession.selectOne("payment.user", user);
	}

	public ProductDTO product(ProductDTO dto) {
		
		return sqlSession.selectOne("payment.product", dto);
	}

	public List<CartDTO> cartPay(int u_no) {
		return sqlSession.selectList("payment.cartPay", u_no);
	}


}
