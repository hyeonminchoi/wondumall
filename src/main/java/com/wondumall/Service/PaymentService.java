package com..Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com..DAO.PaymentDAO;
import com..DTO.OrderDTO;
import com..DTO.ProductDTO;
import com..DTO.UserDTO;

@Service
public class PaymentService {
	
	@Autowired PaymentDAO paymentDAO;

	public int checkout(OrderDTO orderInfo) {
		
		return paymentDAO.checkout(orderInfo);
	}

	public void user(UserDTO user) {
		
		paymentDAO.user(user);
	}

	public void product(ProductDTO dto) {
		
		paymentDAO.product(dto);
	}


}
