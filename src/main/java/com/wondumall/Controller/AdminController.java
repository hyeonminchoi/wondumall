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

import com..DTO.BoardDTO;
import com..DTO.LoginDTO;
import com..DTO.NoticeDTO;
import com..DTO.PageDTO;
import com..DTO.ProductDTO;
import com..DTO.QuestionDTO;
import com..DTO.ReviewDTO;
import com..Service.AdminService;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	
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
		mv.addObject("userList", userList);
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("pageNo", pageNo);
		return mv;
	}
	
	@GetMapping(value = "/admin/sec/{u_no}")
	public String sec(@PathVariable("u_no") int u_no) {
		
		LoginDTO dto = new LoginDTO();
		dto.setU_no(u_no);
		adminService.sec(u_no);
		
		return "redirect:/admin/user.do";
	}
	
	@GetMapping(value = "/admin/rep/{u_no}")
	public String rep(@PathVariable("u_no") int u_no) {
		
		LoginDTO dto = new LoginDTO();
		dto.setU_no(u_no);
		adminService.rep(u_no);
		
		return "redirect:/admin/user.do";
	}
	
	@GetMapping(value = "/admin/comsec/{u_no}")
	public String comsec(@PathVariable("u_no") int u_no) {
		
		LoginDTO dto = new LoginDTO();
		dto.setU_no(u_no);
		adminService.comsec(u_no);
		
		return "redirect:/admin/user.do";
	}
	
	@GetMapping(value = "/admin/admiss/{u_no}")
	public String admiss(@PathVariable("u_no") int u_no) {
		
		LoginDTO dto = new LoginDTO();
		dto.setU_no(u_no);
		adminService.admiss(u_no);
		
		return "redirect:/admin/user.do";
	}
	
	@GetMapping(value = "/admin/adcan/{u_no}")
	public String adcan(@PathVariable("u_no") int u_no) {
		
		LoginDTO dto = new LoginDTO();
		dto.setU_no(u_no);
		adminService.adcan(u_no);
		
		return "redirect:/admin/user.do";
	}
	
	@GetMapping(value = "/admin/board.do")
	public ModelAndView adminboard(@RequestParam(name = "pageNo", required = false, defaultValue = "1") int pageNo, @RequestParam(name="searchColumn", required = false) String searchColumn,
			@RequestParam(name="searchValue", required=false) String searchValue) {
		ModelAndView mv = new ModelAndView("adminboard");
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
		
		paginationInfo.setTotalRecordCount(adminService.getBoardCount(map));
		
		int startPage = paginationInfo.getFirstRecordIndex();
		int lastPage = paginationInfo.getRecordCountPerPage();
		PageDTO page = new PageDTO();
		page.setStartPage(startPage);
		page.setLastPage(lastPage);
		map.put("page", page);
		List<BoardDTO> boardList = adminService.boardList(map);
		mv.addObject("boardList", boardList);
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("pageNo", pageNo);
		return mv;
	}
	
	@GetMapping(value = "/admin/bdel/{b_no}")
	public String bdel(@PathVariable("b_no") int b_no) {
		
		BoardDTO dto = new BoardDTO();
		dto.setB_no(b_no);
		adminService.bdel(b_no);
		
		return "redirect:/admin/board.do";
	}
	
	@GetMapping(value = "/admin/rpr/{b_no}")
	public String rpr(@PathVariable("b_no") int b_no) {
		
		BoardDTO dto = new BoardDTO();
		dto.setB_no(b_no);
		adminService.rpr(b_no);
		
		return "redirect:/admin/board.do";
	}
	
	@GetMapping(value = "/admin/compledel/{b_no}")
	public String compledel(@PathVariable("b_no") int b_no) {
		
		BoardDTO dto = new BoardDTO();
		dto.setB_no(b_no);
		adminService.compledel(b_no);
		
		return "redirect:/admin/board.do";
	}
	
	@GetMapping(value = "/admin/notice.do")
	public ModelAndView adminnotice(@RequestParam(name = "pageNo", required = false, defaultValue = "1") int pageNo, @RequestParam(name="searchColumn", required = false) String searchColumn,
			@RequestParam(name="searchValue", required=false) String searchValue) {
		ModelAndView mv = new ModelAndView("adminnotice");
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
		
		paginationInfo.setTotalRecordCount(adminService.getNoticeCount(map));
		
		int startPage = paginationInfo.getFirstRecordIndex();
		int lastPage = paginationInfo.getRecordCountPerPage();
		PageDTO page = new PageDTO();
		page.setStartPage(startPage);
		page.setLastPage(lastPage);
		map.put("page", page);
		List<NoticeDTO> noticeList = adminService.noticeList(map);
		mv.addObject("noticeList", noticeList);
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("pageNo", pageNo);
		return mv;
	}
	
	@GetMapping(value = "/admin/noticecomdel/{n_no}")
	public String noticecomdel(@PathVariable("n_no") int n_no) {
		
		NoticeDTO dto = new NoticeDTO();
				
		dto.setU_no(n_no);
		adminService.noticecomdel(n_no);
		
		return "redirect:/admin/notice.do";
	}
	
	@GetMapping(value = "/admin/question.do")
	public ModelAndView adminquestion(@RequestParam(name = "pageNo", required = false, defaultValue = "1") int pageNo, @RequestParam(name="searchColumn", required = false) String searchColumn,
			@RequestParam(name="searchValue", required=false) String searchValue) {
		ModelAndView mv = new ModelAndView("adminquestion");
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
		
		paginationInfo.setTotalRecordCount(adminService.getQuestionCount(map));
		
		int startPage = paginationInfo.getFirstRecordIndex();
		int lastPage = paginationInfo.getRecordCountPerPage();
		PageDTO page = new PageDTO();
		page.setStartPage(startPage);
		page.setLastPage(lastPage);
		map.put("page", page);
		List<QuestionDTO> questionList = adminService.questionList(map);
		mv.addObject("questionList", questionList);
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("pageNo", pageNo);
		
		return mv;
	}
	
	@GetMapping(value = "/admin/qdel/{q_no}")
	public String qdel(@PathVariable("q_no") int q_no) {
		
		QuestionDTO dto = new QuestionDTO();
		dto.setQ_no(q_no);
		adminService.qdel(q_no);
		
		return "redirect:/admin/question.do";
	}
	
	@GetMapping(value = "/admin/qrpr/{q_no}")
	public String qrpr(@PathVariable("q_no") int q_no) {
		
		QuestionDTO dto = new QuestionDTO();
		dto.setQ_no(q_no);
		adminService.qrpr(q_no);
		
		return "redirect:/admin/question.do";
	}
	
	@GetMapping(value = "/admin/qcompledel/{q_no}")
	public String qcompledel(@PathVariable("q_no") int q_no) {
		
		QuestionDTO dto = new QuestionDTO();
		dto.setQ_no(q_no);
		adminService.qcompledel(q_no);
		
		return "redirect:/admin/question.do";
	}
	
	@GetMapping(value = "/admin/index.do")
	public String adminindex() {

		return "adminindex";
	}
	
	@GetMapping(value = "/admin/review.do")
	public ModelAndView adminreview(@RequestParam(name = "pageNo", required = false, defaultValue = "1") int pageNo, @RequestParam(name="searchColumn", required = false) String searchColumn,
			@RequestParam(name="searchValue", required=false) String searchValue) {
		ModelAndView mv = new ModelAndView("adminreview");
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
		
		paginationInfo.setTotalRecordCount(adminService.getReviewCount(map));
		
		int startPage = paginationInfo.getFirstRecordIndex();
		int lastPage = paginationInfo.getRecordCountPerPage();
		PageDTO page = new PageDTO();
		page.setStartPage(startPage);
		page.setLastPage(lastPage);
		map.put("page", page);
		List<ReviewDTO> reviewList = adminService.reviewList(map);
		mv.addObject("reviewList", reviewList);
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("pageNo", pageNo);
		
		return mv;
	}
	
	@GetMapping(value = "/admin/rdel/{r_no}")
	public String rdel(@PathVariable("r_no") int r_no) {
		
		ReviewDTO dto = new ReviewDTO();
		dto.setR_no(r_no);
		adminService.rdel(r_no);
		
		return "redirect:/admin/review.do";
	}
	
	@GetMapping(value = "/admin/rrpr/{r_no}")
	public String rrpr(@PathVariable("r_no") int r_no) {
		
		ReviewDTO dto = new ReviewDTO();
		dto.setR_no(r_no);
		adminService.rrpr(r_no);
		
		return "redirect:/admin/review.do";
	}
	
	@GetMapping(value = "/admin/rcompledel/{r_no}")
	public String rcompledel(@PathVariable("r_no") int r_no) {
		
		ReviewDTO dto = new ReviewDTO();
		dto.setR_no(r_no);
		adminService.rcompledel(r_no);
		
		return "redirect:/admin/review.do";
	}
}
