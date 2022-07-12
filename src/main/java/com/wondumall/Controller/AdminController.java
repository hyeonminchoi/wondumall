package com..Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com..DTO.ProductDTO;
import com..Service.AdminService;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping(value = "/adminindex.do")
	public String adminindex() {
		
		return "adminindex";
	}
	
	@GetMapping(value = "/adminproduct.do")
	public ModelAndView adminproduct() {
		
		ModelAndView mv = new ModelAndView("adminproduct");
		
		List<ProductDTO> productList = adminService.productList();
		
		mv.addObject("productList", productList);
		
		return mv;
	}
}
