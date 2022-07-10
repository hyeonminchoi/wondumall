package com..Controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com..DTO.CategoryDTO;
import com..DTO.LoginDTO;
import com..DTO.ProductDTO;
import com..Service.ProductService;
import com..Util.Util;

@Controller
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private Util util;
	
	//제품 종류별 카테고리 분류하기
	@RequestMapping(value = "/category")
	public ModelAndView category(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("category");
		
		//물품마다 카테고리로 분류하기 위한 cate_no;
		int cate_no = 1;
		if((request.getParameter("cate_no")) != null) {
			cate_no = util.str2Int(request.getParameter("cate_no"));
		}
		
		//CategoryDTO에서 cate_no 값 가져오기
		CategoryDTO dto = new CategoryDTO();
		dto.setCate_no(cate_no);
		
		//물품리스트를 List에 담아서 jsp에 반환
		List<ProductDTO> productList = productService.productList(dto);
		
		mv.addObject("productList", productList);
		mv.addObject("cate_no",cate_no);
		return mv;
	}
	
	
	
	@PostMapping(value = "/")
	public ModelAndView productAdd(HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		LoginDTO dto = new LoginDTO();
		int u_confirm = 1;
		if((request.getParameter("u_confirm")) != null) {
			u_confirm = util.str2Int(request.getParameter("u_confirm"));
		}
		dto.setU_confirm(u_confirm);
		
		
		//로그인을 했을 때 LoginDTO.u_confirm이 0 = '사업자' 이고
		//제품명 / 설명 / 가격 / 사진을 insert 하기
		
		String u_email = request.getParameter("u_email");
		
		if(session.getAttribute(u_email) != null
				) {
			
		} else {
			
		}
		
		
		//로그인 했을 때 LoginDTO.u_confirm이 1 = '고객' 이고
		//제품명을 찾아서 / 리뷰 / 가격 / 별점을 insert 하기
		
		
		
		
		ModelAndView mv = new ModelAndView("nav");
		
		
		return mv;
	}
}
