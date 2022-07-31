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

	public void checkout(Map<String, Object> map) {
		
		sqlSession.insert("payment.checkout", map);
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

	public CouponDTO findByCouponNo(int coupon_no) {
		return sqlSession.selectOne("payment.findByCouponNo", coupon_no);
	}

	public void cartRemove(int u_no) {
		sqlSession.delete("payment.cartRemove", u_no);
	}
}
