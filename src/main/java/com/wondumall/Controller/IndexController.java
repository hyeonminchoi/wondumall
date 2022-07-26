package com..Controller;

import java.util.List;

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

		// 물품마다 카테고리로 분류하기 위한 cate_no;
		int cate_no = 1;

		CategoryDTO dto = new CategoryDTO();
		dto.setCate_no(cate_no);

		// 물품리스트를 List에 담아서 jsp에 반환
		List<ProductDTO> productList = productService.productList(dto);

		mv.addObject("productList", productList);
		mv.addObject("cate_no", cate_no);
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
	public List<ProductDTO> searchAjax(@RequestParam("categoryArr[]") List<Boolean> check,@RequestParam("price_min")int price_min, @RequestParam("price_max")int price_max,
			@RequestParam("order")int order, @RequestParam("search")String search){
		System.out.println(check);
		System.out.println(price_max);
		System.out.println(price_min);
		System.out.println(order);
		System.out.println(search);
		return null;
	}
}
