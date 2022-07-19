package com..Controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Deque;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com..Config.MyUserDetails;
import com..DTO.CartDTO;
import com..DTO.CategoryDTO;
import com..DTO.PageDTO;
import com..DTO.ProductDTO;
import com..DTO.ReviewDTO;
import com..Service.CategoryService;
import com..Service.ProductService;
import com..Util.FileSave;
import com..Util.Util;

@Controller
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired private CategoryService categoryService;
	
	@Autowired
	private Util util;
	
	@Autowired
	private FileSave fileSave;
	
	@Autowired
	private ServletContext servletContext;
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@RequestMapping(value = "/cartAllDel.do")
	public String cartAllDel(HttpServletRequest request, @RequestParam int cart_no, @AuthenticationPrincipal MyUserDetails myUserDetails) {
		CartDTO cartDTO = new CartDTO();
		cartDTO.setCart_no(cart_no);
		cartDTO.setU_no(myUserDetails.getNo());
		
		productService.cartAllDel(cartDTO);
		return "redirect:/cart.do?u_no=" + myUserDetails.getNo();
	}
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@RequestMapping(value = "/cartDelete.do")
	public String cartDelete(HttpServletRequest request, @RequestParam int cart_no, @AuthenticationPrincipal MyUserDetails myUserDetails) {
		CartDTO cartDTO = new CartDTO();
		cartDTO.setCart_no(cart_no);
		cartDTO.setU_no(myUserDetails.getNo());
		
		productService.cartDelete(cartDTO);
		return "redirect:/cart.do?u_no=" + myUserDetails.getNo();
	}
	
	@RequestMapping(value = "/cart.do")
	public ModelAndView cart(@RequestParam(name = "u_no", required = false, defaultValue = "-1") int u_no, @AuthenticationPrincipal MyUserDetails myUserDetails) {
		ModelAndView mv = new ModelAndView("cart");
		if(u_no ==-1) {
			mv.addObject("cart", 0);
		} else {
			List<CartDTO> cart = productService.cart(u_no);
			mv.addObject("cart", cart);
		}
		if(myUserDetails!=null)
			mv.addObject("qty", productService.cartCount(myUserDetails.getNo()));
		return mv;
	}
	
	//header.jsp에 장바구니에 있는 숫자 표현
	@ResponseBody
	@PostMapping(value = "/cartCount.do")
	public int cartHeader(@RequestParam("u_no") int u_no) {
		int count = productService.cartCount(u_no);
		
		return count;
	}
	
	//장바구니에 추가하기
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@PostMapping(value = "/cartAdd.do")
	public String cartAdd(HttpServletRequest request, CartDTO dto, @AuthenticationPrincipal MyUserDetails myUserDetails) {
		myUserDetails.getNickname();
		int result = 0;
		if(productService.containProduct(dto)>0) { //카트에 존재할 경우
			result = productService.cartUpdate(dto);
		} else { //카트에 존재하지 않을 경우
			result = productService.cartAdd(dto);
		}
		return "redirect:/productDetail.do?p_no=" + request.getParameter("p_no")+"&result=" + result;
	}
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@PostMapping(value = "/productReview.do")
	public String productReview(HttpServletRequest request, @AuthenticationPrincipal MyUserDetails myUserDetails) throws UnsupportedEncodingException {
		request.setCharacterEncoding("UTF-8");
			myUserDetails.getNickname();
		if(request.getParameter("p_no") != null
				&& request.getParameter("r_title") != null) {
			ReviewDTO dto = new ReviewDTO();
			
			dto.setP_no(util.str2Int(request.getParameter("p_no")));
			dto.setU_no(util.str2Int(request.getParameter("u_no")));
			dto.setR_title(request.getParameter("r_title"));
			dto.setR_content(request.getParameter("r_content"));
			dto.setR_rating(util.str2Int(request.getParameter("r_rating")));
			
			productService.productReview(dto);
		}
		
		return "redirect:/productDetail.do?p_no=" + request.getParameter("p_no");
	}
	
	@GetMapping(value = "/productDetail.do")
	public ModelAndView productDetail(HttpServletRequest request, HttpServletResponse response, @RequestParam(name = "p_no", required = false, defaultValue = "-1") int p_no, @AuthenticationPrincipal MyUserDetails myUserDetails) {
		ModelAndView mv = new ModelAndView("productDetail");
		ReviewDTO dto = new ReviewDTO();
		dto.setP_no(p_no);
		
		// 전자정부페이징 사용하기
		int reviewPageNo = 1;
		if (request.getParameter("reviewPageNo") != null) {
			reviewPageNo = Integer.parseInt(request.getParameter("reviewPageNo"));
		}

		// recordCountPageNo 한 페이지당 게시되는 게시물 수 yes
		int listScale = 3;
		// pageSize = 페이지 리스트에 게시되는 페이지 수 yes
		int pageScale = 5;
		// totalRecordCount 전체 게시물 건수 yes
		int totalCount = productService.reviewCount(p_no);

		// 전자정부페이징 호출
		PaginationInfo paginationInfo = new PaginationInfo();
		// 값대입
		paginationInfo.setCurrentPageNo(reviewPageNo);
		paginationInfo.setRecordCountPerPage(listScale);
		paginationInfo.setPageSize(pageScale);
		paginationInfo.setTotalRecordCount(totalCount);
		// 전자정부 계산하기
		int startPage = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		// 서버로 보내기
		PageDTO page = new PageDTO();
		page.setStartPage(startPage);
		page.setRecordCountPerPage(recordCountPerPage);
		
		//pageDTO도 넘겨줘야 하고 page도 넘겨줘야 해서 map 사용
		Map<String, Object> map = new HashMap<>();
		map.put("page", page);
		map.put("dto",dto);
		List<ReviewDTO> reviewList = productService.reviewList(map);
		
		//로그인 되있을 경우 리뷰 썼는지 안썼는지 확인
		if(myUserDetails !=null) {
			dto.setU_no(myUserDetails.getNo());
			mv.addObject("reviewStatus", productService.reviewStatus(dto));
		} 
		
		//최근 본 상품
		Cookie cookie = null;
		Cookie[] cookies = request.getCookies();
		if(cookies!=null) {
			for(Cookie c:cookies)
				if(c.getName().equals("recentlySee")) {
					cookie = c;
					break;
				}
		}
		//queue와 deque의 차이 생각하기
		//StringTokenizer 찾아보기 <-> split과 차이 있음
		//속도의 차이가 있다.
		//얼마 안되는 값은 Tokenizer 가 좋음 / 값이 많아 질수록 split의 속도가 좋음 /
		
		//hasMoreTokenizer
		//StringBuilder 찾아보기
		if(cookie!=null) {
			StringTokenizer st = new StringTokenizer(cookie.getValue(),"_");
			StringBuilder sb = new StringBuilder();
			Deque<String> queue = new LinkedList<>();
			while(st.hasMoreTokens()) {
				String temp = st.nextToken();
				if(temp.contains("[" + p_no + "]")) {
					continue;
				} else {
					queue.offer(temp);
				}
			}
			if(queue.size()==5) {
				queue.pollLast();
			}
			while(!queue.isEmpty()) {
				sb.append(queue.poll());
				if(!queue.isEmpty())
					sb.append("_");
			}
			
			String result = sb.toString();
			
			cookie.setValue("[" + p_no + "]" + (result.length()>0? "_" + result:""));
			cookie.setMaxAge(60*60*24);
			response.addCookie(cookie);
		} else {
			Cookie newCookie = new Cookie("recentlySee", "[" + p_no + "]");
			newCookie.setMaxAge(60*60);
			response.addCookie(newCookie);
		}
		try {
		mv.addObject("reviewRating", productService.reviewRating(p_no));
		} catch (Exception e) {
		}
		
		CategoryDTO cdto = new CategoryDTO();
		cdto.setCategory("category");
		
		mv.addObject("cateName", productService.cateName(p_no));
		mv.addObject("reviewCount", productService.reviewCount(p_no));
		mv.addObject("productDetail", productService.productDetail(p_no));
		mv.addObject("reviewList",reviewList);
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("reviewPageNo", reviewPageNo);
		return mv;
	}
	
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
	@Secured({"ROLE_BUSINESS", "ROLE_ADMIN"})
	@GetMapping(value = "/productAdd.do")
	public ModelAndView productAdd(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("productAdd");
		
		mv.addObject("categoryList", categoryService.getCategoryList());
		return mv;
	}
	
	@PostMapping(value = "/productAdd.do")
	public String productAdd(HttpServletRequest request, MultipartFile[] files ,@AuthenticationPrincipal MyUserDetails myUserDetails) throws Exception {
		// 한글 입력 UTF-8로 set.
		request.setCharacterEncoding("UTF-8");
		
		if(request.getParameter("p_name") != null
				&& request.getParameter("p_description") != null) {
			ProductDTO add = new ProductDTO();
			
			//숫자 타입 들어오는게 왜 str2Int로 전환해줘야 하는지?!
			add.setP_name(request.getParameter("p_name"));
			add.setCate_no(util.str2Int(request.getParameter("cate_no")));
			add.setP_description(request.getParameter("p_description"));
			add.setP_price(util.str2Int(request.getParameter("p_price")));
			add.setP_stock(util.str2Int(request.getParameter("p_stock")));
			add.setU_no(myUserDetails.getNo());
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
	
	@ResponseBody
	@PostMapping("/recentlySee.do")
	public List<ProductDTO> recentlySee(@RequestParam("arr[]") List<Integer> arr){
		List<ProductDTO> list = new ArrayList<>();
		for(int i=0;i<arr.size();i++) {
			list.add(productService.productDetail(arr.get(i)));
		}
		return list;
	}
}
