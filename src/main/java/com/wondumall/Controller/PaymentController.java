package com..Controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;
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
			, @PathVariable("u_no") int u_no) throws IamportResponseException, IOException
	{	
		String name = request.getParameter("o_name");
		String email = request.getParameter("o_email");
		String postcode = request.getParameter("o_postcode");
		String roadAddress = request.getParameter("o_roadAddress");
		String extraAddress = request.getParameter("o_extraAddress");
		String detailAddress = request.getParameter("o_detailAddress");
		String tel = request.getParameter("o_tel");
		String o_request = request.getParameter("o_request");
		String merchant_uid = request.getParameter("merchant_uid");
		
		OrderDTO orderInfo = new OrderDTO();
		
		orderInfo.setO_name(name);
		orderInfo.setO_email(email);
		orderInfo.setO_postcode(postcode);
		orderInfo.setO_roadAddress(roadAddress);
		orderInfo.setO_extraAddress(extraAddress);
		orderInfo.setO_detailAddress(detailAddress);
		orderInfo.setO_tel(tel);
		orderInfo.setO_request(o_request);
		orderInfo.setImp_uid(imp_uid);
		orderInfo.setMerchant_uid(merchant_uid);
		orderInfo.setU_no(u_no);
		
		paymentService.checkout(orderInfo);	
		
		
		return api.paymentByImpUid(imp_uid);
	}
	
	@GetMapping(value = "/checkout.do")
	public ModelAndView checkout1(HttpServletRequest request, @RequestParam("p_no") int p_no){
		ModelAndView mv = new ModelAndView("checkout");
		
		ProductDTO dto = new ProductDTO();
		dto.setP_no(p_no);
		dto = paymentService.product(dto);
		
		UserDTO user = new UserDTO();
		paymentService.user(user);
		
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
