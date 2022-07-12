package com..Controller;

import java.util.List;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com..DTO.PageDTO;
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
	public ModelAndView adminproduct(@RequestParam(name = "pageNo", required = false, defaultValue = "1") int pageNo, @RequestParam(name="searchColumn", required = false) String searchColumn,
			@RequestParam(name="searchValue", required=false) String searchValue) {
		
		ModelAndView mv = new ModelAndView("adminproduct");
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageNo); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(10); //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(10); //페이징 리스트의 사이즈
		
		if(searchColumn != null && searchValue != null) {
			
		}
		
		paginationInfo.setTotalRecordCount(adminService.getCount());
		
		int startPage = paginationInfo.getFirstRecordIndex();
		int lastPage = paginationInfo.getRecordCountPerPage();
		
		PageDTO page = new PageDTO();
		page.setStartPage(startPage);
		page.setLastPage(lastPage);
		
		List<ProductDTO> productList = adminService.productList(page);
		
		mv.addObject("productList", productList);
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("pageNo", pageNo);
		
		return mv;
	}
	
	@GetMapping(value = "/del/{p_no}")
	public String del(@PathVariable("p_no") int p_no) {
		
		ProductDTO dto = new ProductDTO();
		dto.setP_no(p_no);
		adminService.del(p_no);
		
		return "redirect:/adminproduct.do";
	}
	
	@GetMapping(value = "/repair/{p_no}")
	public String repair(@PathVariable("p_no") int p_no) {
		
		ProductDTO dto = new ProductDTO();
		dto.setP_no(p_no);
		adminService.repair(p_no);
		
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
	
	@RequestMapping(value = "/adcancel/{p_no}")
	public String adcancel(@PathVariable("p_no") int p_no) {
		
		ProductDTO dto = new ProductDTO();
		dto.setP_no(p_no);
		adminService.adcancel(p_no);
		
		return "redirect:/adminproduct.do";
	}
}
