package com..DAO;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com..DTO.CouponDTO;
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

	public List<CouponDTO> couponList() {
		
		return sqlSession.selectList("payment.couponList");
	}
	public List<CartDTO> cartPay(int u_no) {
		return sqlSession.selectList("payment.cartPay", u_no);
	}

	public List<OrderDTO> orderList(OrderDTO dto) {
		
		return sqlSession.selectList("payment.orderList", dto);
	}

	public void setStatus(Map<String, Object> map) {
		sqlSession.update("payment.setStatus", map);
	}
}
