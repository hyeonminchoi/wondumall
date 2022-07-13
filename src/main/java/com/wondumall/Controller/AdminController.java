package com..Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com..DTO.LoginDTO;
import com..DTO.PageDTO;
import com..DTO.ProductDTO;
import com..DTO.UserDTO;
import com..Service.AdminService;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping(value = "/admin/index.do")
	public String adminindex() {
		
		return "adminindex";
	}
	
	@GetMapping(value = "/admin/product.do")
	public ModelAndView adminproduct(@RequestParam(name = "pageNo", required = false, defaultValue = "1") int pageNo, @RequestParam(name="searchColumn", required = false) String searchColumn,
			@RequestParam(name="searchValue", required=false) String searchValue) {
		
		ModelAndView mv = new ModelAndView("adminproduct");
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageNo); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(10); //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(10); //페이징 리스트의 사이즈
		
		Map<String, Object> map = new HashMap<>();
		if(searchColumn != null && searchValue != null) {
			map.put("searchColumn", searchColumn);
			map.put("searchValue", searchValue);
			mv.addObject("searchColumn", searchColumn);
			mv.addObject("searchValue", searchValue);
		}
		
		paginationInfo.setTotalRecordCount(adminService.getCount(map));
		
		int startPage = paginationInfo.getFirstRecordIndex();
		int lastPage = paginationInfo.getRecordCountPerPage();
		PageDTO page = new PageDTO();
		page.setStartPage(startPage);
		page.setLastPage(lastPage);
		map.put("page", page);
		List<ProductDTO> productList = adminService.productList(map);
		
		mv.addObject("productList", productList);
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("pageNo", pageNo);
		
		return mv;
	}
	
	@GetMapping(value = "/admin/del/{p_no}")
	public String del(@PathVariable("p_no") int p_no) {
		
		ProductDTO dto = new ProductDTO();
		dto.setP_no(p_no);
		adminService.del(p_no);
		
		return "redirect:/admin/product.do";
	}
	
	@GetMapping(value = "/admin/repair/{p_no}")
	public String repair(@PathVariable("p_no") int p_no) {
		
		ProductDTO dto = new ProductDTO();
		dto.setP_no(p_no);
		adminService.repair(p_no);
		
		return "redirect:/admin/product.do";
	}
	
	@GetMapping(value = "/admin/pdelete/{p_no}")
	public String pdelete(@PathVariable("p_no") int p_no) {
		
		ProductDTO dto = new ProductDTO();
		dto.setP_no(p_no);
		adminService.pdelete(p_no);
		
		return "redirect:/admin/product.do";
	}
	
	@GetMapping(value = "/admin/admission/{p_no}")
	public String admission(@PathVariable("p_no") int p_no) {
		
		ProductDTO dto = new ProductDTO();
		dto.setP_no(p_no);
		adminService.admission(p_no);
		
		return "redirect:/admin/product.do";
	}
	
	@GetMapping(value = "/admin/adcancel/{p_no}")
	public String adcancel(@PathVariable("p_no") int p_no) {
		
		ProductDTO dto = new ProductDTO();
		dto.setP_no(p_no);
		adminService.adcancel(p_no);
		
		return "redirect:/admin/product.do";
	}
	
	@GetMapping(value = "/admin/user.do")
	public ModelAndView user(@RequestParam(name = "pageNo", required = false, defaultValue = "1") int pageNo, @RequestParam(name="searchColumn", required = false) String searchColumn,
			@RequestParam(name="searchValue", required=false) String searchValue) {
		ModelAndView mv = new ModelAndView("adminuser");
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageNo); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(10); //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(10); //페이징 리스트의 사이즈
		
		Map<String, Object> map = new HashMap<>();
		if(searchColumn != null && searchValue != null) {
			map.put("searchColumn", searchColumn);
			map.put("searchValue", searchValue);
			mv.addObject("searchColumn", searchColumn);
			mv.addObject("searchValue", searchValue);
		}
		
		paginationInfo.setTotalRecordCount(adminService.getUserCount(map));
		
		int startPage = paginationInfo.getFirstRecordIndex();
		int lastPage = paginationInfo.getRecordCountPerPage();
		PageDTO page = new PageDTO();
		page.setStartPage(startPage);
		page.setLastPage(lastPage);
		map.put("page", page);
		List<LoginDTO> userList = adminService.userList(map);
		System.out.println(userList);
		mv.addObject("userList", userList);
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("pageNo", pageNo);
		return mv;
	}
}
