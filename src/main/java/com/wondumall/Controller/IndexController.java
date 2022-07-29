package com..Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com..Config.MyUserDetails;
import com..DTO.CategoryDTO;
import com..DTO.ProductDTO;
import com..Service.CategoryService;
import com..Service.ProductService;

@Controller
public class IndexController {
	@Autowired
	private ProductService productService;
	
	@Autowired
	private CategoryService categoryService;
	
	@GetMapping(value = "/")
	public ModelAndView index() {
		ModelAndView mv = new ModelAndView("index");
		List<CategoryDTO> categoryList = categoryService.getCategoryList();
		
		// 물품리스트를 List에 담아서 jsp에 반환
		List<List<ProductDTO>> productList = new ArrayList<>();
		for(int i=0;i<categoryList.size();i++) {
			List<ProductDTO> temp = productService.productListByCateNo(categoryList.get(i).getCate_no());
			productList.add(temp);
		}
		mv.addObject("productList", productList);
		mv.addObject("categoryList", categoryList);
		return mv;
	}

	@GetMapping(value = "/blank.do")
	public String blank() {
		return "blank";
	}

	@GetMapping(value = "/product.do")
	public String product() {
		return "product";
	}

	@GetMapping("/header.do")
	public ModelAndView header(@AuthenticationPrincipal MyUserDetails myUserDetails) {
		ModelAndView mv = new ModelAndView("header");
		if(myUserDetails!=null)
			mv.addObject("qty", productService.cartCount(myUserDetails.getNo()));
		return mv;
	}

	@GetMapping("/search.do")
	public ModelAndView search(@RequestParam("search")String search) {
		ModelAndView mv = new ModelAndView("store");
		mv.addObject("productList", productService.search(search));
		mv.addObject("categoryList", categoryService.getCategoryList());
		return mv;
	}
	
	@ResponseBody
	@GetMapping("/searchAjax.do")
	public List<Map<String, Object>> searchAjax(Boolean[] categoryArr, @RequestParam("price_min")int price_min, @RequestParam("price_max")int price_max,
			@RequestParam("order")int order, @RequestParam("search")String search, HttpServletRequest request){
		List<CategoryDTO> categoryList = categoryService.getCategoryList();
		List<Integer> list = new ArrayList<>();
		for(int i=0;i<categoryArr.length;i++) {
			if(categoryArr[i]) {
				list.add(categoryList.get(i+1).getCate_no());
			}
		}
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("price_min", price_min);
		map.put("price_max", price_max);
		map.put("search", search);
		switch(order) {
		case 0:
			map.put("order", "p_price ASC");
			break;
		case 1:
			map.put("order", "p_price DESC");
			break;
		case 2:
			map.put("order", "rating ASC");
			break;
		case 3:
			map.put("order", "rating DESC");
			break;
		}
		List<Map<String, Object>> productList = productService.searchDetail(map);
		return productList;
	}
	
	@GetMapping("/error")
	public String error() {
		return "error";
	}
}
