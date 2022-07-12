package com..Controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@GetMapping(value = "/del/{p_no}")
	public String del(@PathVariable("p_no") int p_no) {
		
		ProductDTO dto = new ProductDTO();
		dto.setP_no(p_no);
		adminService.del(p_no);
		
		return "redirect:/adminproduct.do";
	}
	
	@GetMapping(value = "/pdelete/{p_no}")
	public String pdelete(@PathVariable("p_no") int p_no) {
		
		ProductDTO dto = new ProductDTO();
		dto.setP_no(p_no);
		adminService.pdelete(p_no);
		
		return "redirect:/adminproduct.do";
	}
	
	@RequestMapping(value = "/admission/{p_no}")
	public String admission(@PathVariable("p_no") int p_no) {
		
		ProductDTO dto = new ProductDTO();
		dto.setP_no(p_no);
		adminService.admission(p_no);
		
		return "redirect:/adminproduct.do";
	}
}
