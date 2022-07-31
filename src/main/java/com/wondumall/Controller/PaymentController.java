package com..Controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;
import com..Config.MyUserDetails;
import com..DTO.CartDTO;
import com..DTO.CouponDTO;
import com..DTO.OrderDTO;
import com..DTO.UserDTO;
import com..Service.PaymentService;

import net.sf.log4jdbc.CallableStatementSpy;

@Controller
public class PaymentController {

	private IamportClient api;

	@Autowired
	private PaymentService paymentService;

	public PaymentController() {
		// REST API 키와 REST API secret 를 아래처럼 순서대로 입력한다.
		this.api = new IamportClient("",
				"");
	}

	@ResponseBody
	@RequestMapping(value = "/verifyIamport/{imp_uid}")
	public IamportResponse<Payment> paymentByImpUid(@PathVariable(value = "imp_uid") String imp_uid, OrderDTO orderInfo,
			@AuthenticationPrincipal MyUserDetails myUserDetails, @RequestParam(name="coupon", required = false) Integer coupon_no) throws IamportResponseException, IOException {
		List<CartDTO> cart = paymentService.cartPay(myUserDetails.getNo());
		int totalPrice = cart.stream().mapToInt(e->e.getP_price() * e.getP_count()).sum();
		if(coupon_no!=null) {
			totalPrice = (int) Math.ceil((double)totalPrice * (1-paymentService.findByCouponNo(coupon_no.intValue()).getCoupon_per()));
		}
		orderInfo.setU_no(myUserDetails.getNo());
		IamportResponse<Payment> payment = api.paymentByImpUid(imp_uid);
		Map<String, Object> map = new HashMap<>();
		map.put("orderInfo", orderInfo);
		map.put("cart", cart);
		if (payment.getResponse().getStatus().equals("paid")) {
			if(payment.getResponse().getAmount().intValue() == totalPrice) {
				orderInfo.setO_status("결제완료");
				paymentService.checkout(map);
				paymentService.cartRemove(myUserDetails.getNo());
			} else {
				orderInfo.setO_status("위조된 결제시도");
				CancelData calcelData = new CancelData(imp_uid, true);
				calcelData.setReason("위조된 결제시도");
				paymentService.checkout(map);
				return api.cancelPaymentByImpUid(calcelData);
			}
		} else {
			orderInfo.setO_status("결제실패");
			paymentService.checkout(map);
		}
		return payment;
	}

	@Secured({ "ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN" })
	@ResponseBody
	@PostMapping(value = "/refund")
	public IamportResponse<Payment> paymentRefund(@RequestParam("merchant_uid") String merchant_uid,
			@RequestParam("amount") int amount, @RequestParam("reason") String reason,
			@AuthenticationPrincipal MyUserDetails myUserDetails) throws IamportResponseException, IOException {
		CancelData cancelData = new CancelData(merchant_uid, false, new BigDecimal(amount));
		cancelData.setReason(reason);
		Map<String, Object> map = new HashMap<>();
		map.put("merchant_uid", merchant_uid);
		map.put("u_no", myUserDetails.getNo());
		paymentService.setStatus(map);
		return api.cancelPaymentByImpUid(cancelData);
	}

	@Secured({ "ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN" })
	@GetMapping(value = "/checkout.do")
	public ModelAndView checkout1(HttpServletRequest request, @AuthenticationPrincipal MyUserDetails myUserDetails) {
		ModelAndView mv = new ModelAndView("checkout");

		UserDTO user = new UserDTO();
		user.setU_no(myUserDetails.getNo());

		paymentService.user(user);

		List<CouponDTO> couponList = paymentService.couponList();

		mv.addObject("couponList", couponList);
		if (myUserDetails.getNo() > 0) {
			List<CartDTO> cart = paymentService.cartPay(myUserDetails.getNo());
			mv.addObject("cart", cart);
		} else {
			mv.addObject("cart", 0);
		}

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

	@GetMapping(value = "/orderHistory.do")
	public ModelAndView orderHistory(OrderDTO dto, @AuthenticationPrincipal MyUserDetails myUserDetails,
			HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("orderHistory");
		dto.setU_no(myUserDetails.getNo());
		List<OrderDTO> orderList = paymentService.orderList(dto);
		mv.addObject("orderList", orderList);
		return mv;
	}
}
