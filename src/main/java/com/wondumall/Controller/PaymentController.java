package com..Controller;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;
import com..Config.MyUserDetails;
import com..DTO.CouponDTO;
import com..DTO.CartDTO;
import com..DTO.OrderDTO;
import com..DTO.ProductDTO;
import com..DTO.UserDTO;
import com..Service.PaymentService;

@Controller
public class PaymentController {
	
	private IamportClient api;
	
	@Autowired
	private PaymentService paymentService;
	
	public PaymentController() {
    	// REST API 키와 REST API secret 를 아래처럼 순서대로 입력한다.
		this.api = new IamportClient("2957455845749684","703427efb6b461bd1728a1927256f45046eae03e4c50f6cf58bad7820b729c367da56a7742419f8d");
	}
	
	@ResponseBody
	@RequestMapping(value="/verifyIamport/{imp_uid}")
	public IamportResponse<Payment> paymentByImpUid(HttpServletRequest request,
			Model model
			, Locale locale
			, HttpSession session
			, @PathVariable(value= "imp_uid") String imp_uid
			, OrderDTO orderInfo,
			@AuthenticationPrincipal MyUserDetails myUserDetails) throws IamportResponseException, IOException
	{	
		orderInfo.setU_no(myUserDetails.getNo());
		paymentService.checkout(orderInfo);	
		
		
		return api.paymentByImpUid(imp_uid);
	}
	
	@GetMapping(value = "/checkout.do")
	public ModelAndView checkout1(HttpServletRequest request, @AuthenticationPrincipal MyUserDetails myUserDetails, 
			@RequestParam(name = "u_no", required = false, defaultValue = "-1") int u_no){
		ModelAndView mv = new ModelAndView("checkout");
		
		ProductDTO dto = new ProductDTO();
		dto.setU_no(myUserDetails.getNo());
		dto = paymentService.product(dto);
		UserDTO user = new UserDTO();
		paymentService.user(user);
		
		List<CouponDTO> couponList = paymentService.couponList();
		
		
		mv.addObject("couponList", couponList);
		if(u_no ==-1) {
			mv.addObject("cart", 0);
		} else {
			List<CartDTO> cart = paymentService.cartPay(u_no);
			mv.addObject("cart", cart);
		}
		
		mv.addObject("product", dto);
		mv.addObject("user", user);
		

		return mv;
	}
	
	@GetMapping(value = "/paysuccess.do")
	public String paysuccess() {
		
		return "paysuccess";
	}
	
	@GetMapping(value = "/payfailure.do")
	public String payfailure() {
		
		return "payfailure";
	}
}
