package com..Controller;

import java.util.HashMap;
import java.util.Map;

import javax.security.sasl.AuthenticationException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.ModelAndView;

import com..Config.MyUserDetails;
import com..DTO.AnswerDTO;
import com..DTO.BoardDTO;
import com..DTO.QuestionDTO;
import com..Service.AnswerService;
import com..Service.QuestionService;
import com..Util.FileSave;
import com..Util.Util;

@Controller
public class QuestionController {
	@Autowired
	private QuestionService questionService;
	@Autowired
	private AnswerService answerService;
	
	@Autowired
	private ServletContext servletContext;

	@Autowired
	private FileSave fileSave;
	
	@GetMapping("/question.do")
	public ModelAndView question(@RequestParam(name = "pageNo", required = false, defaultValue = "1") int pageNo, @RequestParam(name="searchColumn", required = false) String searchColumn, 
			@RequestParam(name="searchValue", required=false) String searchValue) {
		ModelAndView mv = new ModelAndView("question");
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageNo); // 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(10); // 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(10); // 페이징 리스트의 사이즈

		Map<String, Object> map = new HashMap<>();
		if(searchColumn != null && searchValue != null) {
			map.put("searchColumn", searchColumn);
			map.put("searchValue", searchValue);
			mv.addObject("searchColumn", searchColumn);
			mv.addObject("searchValue", searchValue);
		}
		paginationInfo.setTotalRecordCount(questionService.getCount(map));
		
		map.put("firstIndex", paginationInfo.getFirstRecordIndex());
		map.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		mv.addObject("questionList", questionService.getQuestionList(map));
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("pageNo", paginationInfo.getCurrentPageNo());
		return mv;
	}

	@GetMapping("/questionDetail.do")
	public ModelAndView questionDetail(@RequestParam("q_no") int q_no, @RequestParam("pageNo") int pageNo, HttpServletRequest request, HttpServletResponse response,@AuthenticationPrincipal MyUserDetails myUserDetails) throws Exception {
		ModelAndView mv = new ModelAndView("questionDetail");
		
		QuestionDTO detail = questionService.getDetail(q_no);
		//비로그인 회원일 경우 접근 에러
		if(myUserDetails== null) {
			throw new ResponseStatusException(HttpStatus.FORBIDDEN);
		}
		
		//관리자가 아니거나 작성자가 아닐 경우 접근 에러
		boolean adminCheck = myUserDetails.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN")); 
		if(!adminCheck && !detail.getU_nickname().equals(myUserDetails.getNickname())){ // 관리자가 아니거나 글 작성자가 아닐 경우
			throw new ResponseStatusException(HttpStatus.FORBIDDEN);
		}
		if(detail==null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND);
		}
		mv.addObject("detail", detail);
		mv.addObject("pageNo", pageNo);
		mv.addObject("answerList", answerService.getAnswerList(q_no));
		return mv;
	}
	
	@Secured("ROLE_ADMIN")
	@PostMapping("/answer.do")
	public void answerWrite(AnswerDTO answerDTO, @RequestParam("pageNo") int pageNo,
			HttpServletResponse response, @RequestParam(name="searchColumn", required = false) String searchColumn, 
			@RequestParam(name="searchValue", required=false) String searchValue,
			@AuthenticationPrincipal MyUserDetails myUserDetails) throws Exception {
		if(answerDTO.getA_answer().equals(""))
			answerDTO.setA_answer(null);
		answerDTO.setU_nickname(myUserDetails.getNickname());
		int result = answerService.writeAnswer(answerDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('답변쓰기에 성공했습니다'); location.href='./questionDetail.do?q_no="
						+ answerDTO.getQ_no() + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('답변쓰기에 성공했습니다'); location.href='./questionDetail.do?q_no="
						+ answerDTO.getQ_no() + "&pageNo=" + pageNo + "'</script>");
		} else {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('답변쓰기에 실패했습니다'); location.href='./questionDetail.do?q_no="
						+ answerDTO.getQ_no() + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('답변쓰기에 실패했습니다'); location.href='./questionDetail.do?q_no="
						+ answerDTO.getQ_no() + "&pageNo=" + pageNo + "'</script>");
		}
	}

	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@PostMapping("/questionWrite.do")
	public void questionWrite(@RequestParam("pageNo") int pageNo, HttpServletRequest request,
			HttpServletResponse response, @AuthenticationPrincipal MyUserDetails myUserDetails) throws Exception {
		if(myUserDetails== null) {
			throw new ResponseStatusException(HttpStatus.FORBIDDEN);
		}
		QuestionDTO questionDTO = new QuestionDTO(Util.xss_clean_check(request.getParameter("q_title")), Util.xss_clean_check(request.getParameter("q_content"), request),
				myUserDetails.getNickname());
		int result = questionService.write(questionDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			response.getWriter().println(
					"<script> alert('질문 작성에 성공했습니다'); location.href='./question.do?pageNo=" + pageNo + "'</script>");
		} else {
			response.getWriter().println(
					"<script> alert('질문 작성에 실패했습니다'); location.href='./question.do?pageNo=" + pageNo + "'</script>");
		}
	}
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@PostMapping("/questionImage.do")
	public ResponseEntity<?> imageUpload(MultipartFile file) {
		try {
			String realPath = servletContext.getRealPath("resources/questionImage/");
			String realFileName = fileSave.save(realPath, file);
			
			return ResponseEntity.ok().body("./questionImage/" + realFileName);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.badRequest().build();
		}
	}
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@GetMapping("/questionDelete.do")
	public void questionDelete(@RequestParam("pageNo") int pageNo, @RequestParam("q_no") int q_no, @RequestParam("u_nickname") String u_nickname, HttpServletRequest request,
			HttpServletResponse response, @RequestParam(name="searchColumn", required = false) String searchColumn, 
			@RequestParam(name="searchValue", required=false) String searchValue,
			@AuthenticationPrincipal MyUserDetails myUserDetails) throws Exception {
		//비로그인 회원일 경우 접근 에러
		if(myUserDetails== null) {
			throw new ResponseStatusException(HttpStatus.FORBIDDEN);
		}
		boolean adminCheck = myUserDetails.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN")); 
		if(!adminCheck && !u_nickname.equals(myUserDetails.getNickname())){ // 관리자가 아니거나 글 작성자가 아닐 경우
			throw new ResponseStatusException(HttpStatus.FORBIDDEN);
		}
		
		QuestionDTO questionDTO = new QuestionDTO();
		questionDTO.setQ_no(q_no);
		int result = questionService.delete(questionDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('질문 삭제에 성공했습니다'); location.href='./question.do?pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('질문 삭제에 성공했습니다'); location.href='./question.do?pageNo=" + pageNo + "'</script>");
		} else {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('질문 삭제에 실패했습니다'); location.href='./question.do?pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('질문 삭제에 실패했습니다'); location.href='./question.do?pageNo=" + pageNo + "'</script>");
		}
	}
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@PostMapping("/questionEdit.do")
	public void questionEdit(@RequestParam("pageNo") int pageNo, @RequestParam("q_no") int q_no, @RequestParam("u_nickname") String u_nickname, HttpServletRequest request,
			HttpServletResponse response, @RequestParam(name="searchColumn", required = false) String searchColumn, 
			@RequestParam(name="searchValue", required=false) String searchValue, @AuthenticationPrincipal MyUserDetails myUserDetails) throws Exception {
		//비로그인 회원일 경우 접근 에러
		if(myUserDetails== null) {
			throw new ResponseStatusException(HttpStatus.FORBIDDEN);
		}
		boolean adminCheck = myUserDetails.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN")); 
		if(!adminCheck && !u_nickname.equals(myUserDetails.getNickname())){ // 관리자가 아니거나 글 작성자가 아닐 경우
			throw new ResponseStatusException(HttpStatus.FORBIDDEN);
		}
		
		QuestionDTO questionDTO = new QuestionDTO(Util.xss_clean_check(request.getParameter("q_title")), Util.xss_clean_check(request.getParameter("q_content"), request),
				myUserDetails.getNickname());
		questionDTO.setQ_no(q_no);
		int result = questionService.edit(questionDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('질문 수정에 성공했습니다'); location.href='./questionDetail.do?q_no="
						+ q_no + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('질문 수정에 성공했습니다'); location.href='./questionDetail.do?q_no="
						+ q_no + "&pageNo=" + pageNo + "'</script>");
		} else {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('질문 수정에 실패했습니다'); location.href='./questionDetail.do?q_no="
						+ q_no + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('질문 수정에 실패했습니다'); location.href='./questionDetail.do?q_no="
						+ q_no + "&pageNo=" + pageNo + "'</script>");
		}
	}
	
	@Secured("ROLE_ADMIN")
	@GetMapping("/answerDelete.do")
	public void answerDelete(@RequestParam("pageNo") int pageNo, @RequestParam("q_no") int q_no, @RequestParam("a_no") int a_no, HttpServletRequest request,
			HttpServletResponse response, @RequestParam(name="searchColumn", required = false) String searchColumn, 
			@RequestParam(name="searchValue", required=false) String searchValue, @AuthenticationPrincipal MyUserDetails myUserDetails) throws Exception {
		AnswerDTO answerDTO = new AnswerDTO();
		answerDTO.setQ_no(q_no);
		answerDTO.setA_no(a_no);
		answerDTO.setU_nickname(myUserDetails.getNickname());
		int result = answerService.delete(answerDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('답변 삭제에 성공했습니다'); location.href='./questionDetail.do?q_no="
						+ q_no + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('답변 삭제에 성공했습니다'); location.href='./questionDetail.do?q_no="
						+ q_no + "&pageNo=" + pageNo + "'</script>");
		} else {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('답변 삭제에 실패했습니다'); location.href='./questionDetail.do?q_no="
						+ q_no + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('답변 삭제에 실패했습니다'); location.href='./questionDetail.do?q_no="
						+ q_no + "&pageNo=" + pageNo + "'</script>");
		}
	}
	
	@Secured({"ROLE_ADMIN"})
	@PostMapping("/answerEdit.do")
	public void answerEdit(AnswerDTO answerDTO, @RequestParam("pageNo") int pageNo,
			HttpServletResponse response, @RequestParam(name="searchColumn", required = false) String searchColumn, 
			@RequestParam(name="searchValue", required=false) String searchValue,
			@AuthenticationPrincipal MyUserDetails myUserDetails) throws Exception {
		if(answerDTO.getA_answer().equals(""))
			answerDTO.setA_answer(null);
		answerDTO.setU_nickname(myUserDetails.getNickname());
		int result = answerService.edit(answerDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('답변수정에 성공했습니다'); location.href='./questionDetail.do?q_no="
						+ answerDTO.getQ_no() + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('답변수정에 성공했습니다'); location.href='./questionDetail.do?q_no="
						+ answerDTO.getQ_no() + "&pageNo=" + pageNo + "'</script>");
		} else {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('답변수정에 실패했습니다'); location.href='./questionDetail.do?q_no="
						+ answerDTO.getQ_no() + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('답변수정에 실패했습니다'); location.href='./questionDetail.do?q_no="
						+ answerDTO.getQ_no() + "&pageNo=" + pageNo + "'</script>");
		}
	}

}
