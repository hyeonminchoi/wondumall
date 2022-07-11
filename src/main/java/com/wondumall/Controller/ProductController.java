package com..Controller;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com..DTO.CategoryDTO;
import com..DTO.ProductDTO;
import com..Service.ProductService;
import com..Util.FileSave;
import com..Util.Util;

@Controller
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private Util util;
	
	@Autowired
	private FileSave fileSave;
	
	@Autowired
	private ServletContext servletContext;
	
	//제품 종류별 카테고리 분류하기
	@RequestMapping(value = "/category.do")
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
	
	//상품등록 화면 나오게 하기
	@GetMapping(value = "/productAdd.do")
	public String productAdd(HttpSession session) {
		if(session.getAttribute("u_email") != null) {
			return "productAdd";
		} else {
			return "productAdd";
		}
	}
	
	@PostMapping(value = "/productAdd.do")
	public String productAdd(HttpServletRequest request, MultipartFile[] files) throws Exception {
		// 한글 입력 UTF-8로 set.
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		if(session.getAttribute("u_email") != null
				&& request.getParameter("p_name") != null
				&& request.getParameter("p_description") != null) {
			ProductDTO add = new ProductDTO();
			
			//숫자 타입 들어오는게 왜 str2Int로 전환해줘야 하는지?!
			add.setP_name(request.getParameter("p_name"));
			add.setCate_no(util.str2Int(request.getParameter("cate_no")));
			add.setP_description(request.getParameter("p_description"));
			add.setP_price(util.str2Int(request.getParameter("p_price")));
			add.setP_stock(util.str2Int(request.getParameter("p_stock")));
			
			// 상품 이미지 추가하기
			for(MultipartFile file: files) {
				if(!(file.getOriginalFilename().isEmpty())) {
					//파일을 저장할 실제 경로
					String realPath = servletContext.getRealPath("resources/productUpload/");
					String p_img = fileSave.save(realPath, file);
					
					//파일이름을 데이터베이스에 저장하는 작업
					add.setP_img(p_img);
				}
			}
			int result = productService.productAdd(add);
			
			//redirect는 언제 쓰는지?
			if(result == 1) {
				return "redirect:/";
			} else {
				return "redirect:/join";
			}
		} else {
			return "redirect:/join";
		}
		
		
		
	}
}
