package com.wondumall.DAO;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wondumall.DTO.CouponDTO;
import com.wondumall.DTO.CartDTO;
import com.wondumall.DTO.OrderDTO;
import com.wondumall.DTO.ProductDTO;
import com.wondumall.DTO.UserDTO;

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

	public List<OrderDTO> orderList(int u_no) {
		
		return sqlSession.selectList("payment.orderList", u_no);
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

	public List<OrderDTO> orderDetail(String merchant_uid) {
		
		return sqlSession.selectList("payment.orderDetail",merchant_uid);
	}
}
