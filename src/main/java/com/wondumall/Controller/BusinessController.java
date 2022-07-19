package com..Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com..DTO.CouponDTO;
import com..DTO.PageDTO;
import com..DTO.ProductDTO;
import com..Service.BusinessService;

@Controller
public class BusinessController {
	
	@Autowired
	private BusinessService businessService;
	
	@GetMapping(value = "/business/index.do")
	public String businessIndex() {
		
		return "businessIndex";
	}
	
	@PostMapping(value = "/business/couponWrite.do")
	public String businessCoupon(CouponDTO dto) {
		businessService.couponWrite(dto);
		
		return "businessCoupon";
	}
	
	@GetMapping(value = "/business/coupon.do")
	public ModelAndView businessCoupon(@RequestParam(name = "pageNo", required = false, defaultValue = "1") int pageNo, @RequestParam(name="searchColumn", required = false) String searchColumn,
			@RequestParam(name="searchValue", required=false) String searchValue) {
		
		ModelAndView mv = new ModelAndView("businessCoupon");
		
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
		
		paginationInfo.setTotalRecordCount(businessService.getCount(map));
		
		int startPage = paginationInfo.getFirstRecordIndex();
		int lastPage = paginationInfo.getRecordCountPerPage();
		PageDTO page = new PageDTO();
		page.setStartPage(startPage);
		page.setLastPage(lastPage);
		map.put("page", page);
		List<CouponDTO> couponList = businessService.couponList(map);
		
		mv.addObject("couponList", couponList);
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("pageNo", pageNo);
		
		return mv;
	}
}
