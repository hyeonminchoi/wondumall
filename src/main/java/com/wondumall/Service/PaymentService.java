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

	public void checkout(OrderDTO orderInfo) {
		
		paymentDAO.checkout(orderInfo);
	}

	public void user(UserDTO user) {
		
		paymentDAO.user(user);
	}

	public ProductDTO product(ProductDTO dto) {
		
		return paymentDAO.product(dto);
	}


}
