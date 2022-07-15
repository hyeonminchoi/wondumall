package com..Controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.ModelAndView;

import com..Config.MyUserDetails;
import com..DTO.NoticeDTO;
import com..DTO.BoardDTO;
import com..DTO.NoticeCommentDTO;
import com..Service.NoticeCommentService;
import com..Service.NoticeService;
import com..Util.FileSave;
import com..Util.Util;

@Controller
public class NoticeController {
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private NoticeCommentService noticeCommentService;
	
	@Autowired
	private ServletContext servletContext;

	@Autowired
	private FileSave fileSave;
	
	@GetMapping("/notice.do")
	public ModelAndView notice(@RequestParam(name = "pageNo", required = false, defaultValue = "1") int pageNo, @RequestParam(name="searchColumn", required = false) String searchColumn, 
			@RequestParam(name="searchValue", required=false) String searchValue) {
		ModelAndView mv = new ModelAndView("notice");
		
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
		paginationInfo.setTotalRecordCount(noticeService.getCount(map));
		
		map.put("firstIndex", paginationInfo.getFirstRecordIndex());
		map.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		mv.addObject("noticeList", noticeService.getNoticeList(map));
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("pageNo", paginationInfo.getCurrentPageNo());
		return mv;
	}

	@GetMapping("/noticeDetail.do")
	public ModelAndView noticeDetail(@RequestParam("n_no") int n_no, @RequestParam("pageNo") int pageNo, HttpServletRequest request, HttpServletResponse response,@AuthenticationPrincipal MyUserDetails myUserDetails) {
		ModelAndView mv = new ModelAndView("noticeDetail");
		
		//조회수 중복방지
		Cookie cookie = null;
		Cookie[] cookies = request.getCookies();
		if(cookies!=null) {
			for(Cookie c:cookies)
				if(c.getName().equals("noticeView")) {
					cookie = c;
					break;
				}
		}
		
		if(cookie!=null) {
			if(!cookie.getValue().contains("[" + n_no + "]")) {
				noticeService.countUp(n_no);
				cookie.setValue(cookie.getValue() + "_[" + n_no + "]");
				cookie.setMaxAge(60*60);
				response.addCookie(cookie);
			}
		} else {
			noticeService.countUp(n_no);
			Cookie newCookie = new Cookie("noticeView", "[" + n_no + "]");
			newCookie.setMaxAge(60*60);
			response.addCookie(newCookie);
		}
		
		if(myUserDetails != null) {
			NoticeDTO temp = new NoticeDTO();
			temp.setN_no(n_no);
			temp.setU_nickname(myUserDetails.getNickname());
			int like = noticeService.containLike(temp);
			if(like > 0)
				mv.addObject("likeStatus", true);
			else
				mv.addObject("likeStatus", false);
		}
		NoticeDTO detail = noticeService.getDetail(n_no);
		if(detail==null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND);
		}
		mv.addObject("detail", detail);
		mv.addObject("pageNo", pageNo);
		mv.addObject("commentList", noticeCommentService.getCommentList(n_no));
		return mv;
	}
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@PostMapping("/noticeComment.do")
	public void noticeCommentWrite(NoticeCommentDTO noticecommentDTO, @RequestParam("pageNo") int pageNo,
			HttpServletResponse response, @RequestParam(name="searchColumn", required = false) String searchColumn, 
			@RequestParam(name="searchValue", required=false) String searchValue) throws Exception {
		if(noticecommentDTO.getNc_comment().equals(""))
			noticecommentDTO.setNc_comment(null);
		int result = noticeCommentService.writeComment(noticecommentDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('댓글쓰기에 성공했습니다'); location.href='./noticeDetail.do?n_no="
						+ noticecommentDTO.getN_no() + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('댓글쓰기에 성공했습니다'); location.href='./noticeDetail.do?n_no="
						+ noticecommentDTO.getN_no() + "&pageNo=" + pageNo + "'</script>");
		} else {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('댓글쓰기에 실패했습니다'); location.href='./noticeDetail.do?n_no="
						+ noticecommentDTO.getN_no() + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('댓글쓰기에 실패했습니다'); location.href='./noticeDetail.do?n_no="
						+ noticecommentDTO.getN_no() + "&pageNo=" + pageNo + "'</script>");
		}
	}

	@Secured("ROLE_ADMIN")
	@PostMapping("/noticeWrite.do")
	public void noticeWrite(@RequestParam("pageNo") int pageNo, HttpServletRequest request,
			HttpServletResponse response, @AuthenticationPrincipal MyUserDetails myUserDetails) throws Exception {
		if(myUserDetails== null) {
			throw new ResponseStatusException(HttpStatus.FORBIDDEN);
		}
		NoticeDTO noticeDTO = new NoticeDTO(Util.xss_clean_check(request.getParameter("n_title")), Util.xss_clean_check(request.getParameter("n_content"), request),
				myUserDetails.getNickname());
		int result = noticeService.write(noticeDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			response.getWriter().println(
					"<script> alert('공지사항 작성에 성공했습니다'); location.href='./notice.do?pageNo=" + pageNo + "'</script>");
		} else {
			response.getWriter().println(
					"<script> alert('공지사항 작성에 실패했습니다'); location.href='./notice.do?pageNo=" + pageNo + "'</script>");
		}
	}
	
	@Secured("ROLE_ADMIN")
	@PostMapping("/noticeImage.do")
	public ResponseEntity<?> imageUpload(MultipartFile file) {
		try {
			String realPath = servletContext.getRealPath("resources/noticeImage/");
			String realFileName = fileSave.save(realPath, file);
			
			return ResponseEntity.ok().body("./noticeImage/" + realFileName);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.badRequest().build();
		}
	}
	
	@Secured("ROLE_ADMIN")
	@GetMapping("/noticeDelete.do")
	public void noticeDelete(@RequestParam("pageNo") int pageNo, @RequestParam("n_no") int n_no, @RequestParam("u_nickname") String u_nickname, HttpServletRequest request,
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
		
		NoticeDTO noticeDTO = new NoticeDTO();
		noticeDTO.setN_no(n_no);
		int result = noticeService.delete(noticeDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('공지사항 삭제에 성공했습니다'); location.href='./notice.do?pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('공지사항 삭제에 성공했습니다'); location.href='./notice.do?pageNo=" + pageNo + "'</script>");
		} else {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('공지사항 삭제에 실패했습니다'); location.href='./notice.do?pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('공지사항 삭제에 실패했습니다'); location.href='./notice.do?pageNo=" + pageNo + "'</script>");
		}
	}
	
	@Secured("ROLE_ADMIN")
	@PostMapping("/noticeEdit.do")
	public void noticeEdit(@RequestParam("pageNo") int pageNo, @RequestParam("n_no") int n_no, HttpServletRequest request,
			HttpServletResponse response, @RequestParam(name="searchColumn", required = false) String searchColumn, 
			@RequestParam(name="searchValue", required=false) String searchValue) throws Exception {
		NoticeDTO noticeDTO = new NoticeDTO(Util.xss_clean_check(request.getParameter("n_title")), Util.xss_clean_check(request.getParameter("n_content"), request),
				request.getParameter("u_nickname"));
		noticeDTO.setN_no(n_no);
		int result = noticeService.edit(noticeDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('공지사항 수정에 성공했습니다'); location.href='./noticeDetail.do?n_no="
						+ n_no + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('공지사항 수정에 성공했습니다'); location.href='./noticeDetail.do?n_no="
						+ n_no + "&pageNo=" + pageNo + "'</script>");
		} else {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('공지사항 수정에 실패했습니다'); location.href='./noticeDetail.do?n_no="
						+ n_no + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('공지사항 수정에 실패했습니다'); location.href='./noticeDetail.do?n_no="
						+ n_no + "&pageNo=" + pageNo + "'</script>");
		}
	}
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@GetMapping("/noticeCommentDelete.do")
	public void noticeCommentDelete(@RequestParam("pageNo") int pageNo, @RequestParam("n_no") int n_no, @RequestParam("nc_no") int nc_no, HttpServletRequest request,
			HttpServletResponse response, @RequestParam(name="searchColumn", required = false) String searchColumn, 
			@RequestParam(name="searchValue", required=false) String searchValue, @AuthenticationPrincipal MyUserDetails myUserDetails) throws Exception {
		NoticeCommentDTO noticecommentDTO = new NoticeCommentDTO();
		noticecommentDTO.setN_no(n_no);
		noticecommentDTO.setNc_no(nc_no);
		noticecommentDTO.setU_nickname(myUserDetails.getNickname());
		int result = noticeCommentService.delete(noticecommentDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('댓글 삭제에 성공했습니다'); location.href='./noticeDetail.do?n_no="
						+ n_no + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('댓글 삭제에 성공했습니다'); location.href='./noticeDetail.do?n_no="
						+ n_no + "&pageNo=" + pageNo + "'</script>");
		} else {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('댓글 삭제에 실패했습니다'); location.href='./noticeDetail.do?n_no="
						+ n_no + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('댓글 삭제에 실패했습니다'); location.href='./noticeDetail.do?n_no="
						+ n_no + "&pageNo=" + pageNo + "'</script>");
		}
	}
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@PostMapping("/noticeCommentEdit.do")
	public void noticeCommentEdit(NoticeCommentDTO noticecommentDTO, @RequestParam("pageNo") int pageNo,
			HttpServletResponse response, @RequestParam(name="searchColumn", required = false) String searchColumn, 
			@RequestParam(name="searchValue", required=false) String searchValue) throws Exception {
		if(noticecommentDTO.getNc_comment().equals(""))
			noticecommentDTO.setNc_comment(null);
		int result = noticeCommentService.edit(noticecommentDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('댓글수정에 성공했습니다'); location.href='./noticeDetail.do?n_no="
						+ noticecommentDTO.getN_no() + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('댓글수정에 성공했습니다'); location.href='./noticeDetail.do?n_no="
						+ noticecommentDTO.getN_no() + "&pageNo=" + pageNo + "'</script>");
		} else {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('댓글수정에 실패했습니다'); location.href='./noticeDetail.do?n_no="
						+ noticecommentDTO.getN_no() + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('댓글수정에 실패했습니다'); location.href='./noticeDetail.do?n_no="
						+ noticecommentDTO.getN_no() + "&pageNo=" + pageNo + "'</script>");
		}
	}
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@ResponseBody
	@PostMapping("/noticeLikeAjax.do")
	public Map<String, Object> noticeLike(NoticeDTO noticeDTO) {
		int result = noticeService.containLike(noticeDTO);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		if(result>0) { //이미 좋아요를 누른 상태
			noticeService.deleteLike(noticeDTO);
		} else { //좋아요를 누르지 않은 상태
			noticeService.insertLike(noticeDTO);
		}
		noticeService.updateLike(noticeDTO.getN_no());
		int count = noticeService.like(noticeDTO.getN_no());
		map.put("count", count);
		return map;
	}
	
}
