package com..DAO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com..DTO.OrderDTO;
import com..DTO.ProductDTO;
import com..DTO.UserDTO;

@Component
public class PaymentDAO {
	
	@Autowired
	private SqlSession sqlSession;

	public int checkout(OrderDTO orderInfo) {
		
		return sqlSession.insert("payment.checkout", orderInfo);
	}

	public void user(UserDTO user) {
		
		sqlSession.selectOne("payment.user", user);
	}

	public void product(ProductDTO dto) {
		
		sqlSession.selectOne("payment.product", dto);
	}


}
