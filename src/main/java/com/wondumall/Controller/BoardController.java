package com..Controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com..Config.MyUserDetails;
import com..DTO.BoardCommentDTO;
import com..DTO.BoardDTO;
import com..Service.BoardCommentService;
import com..Service.BoardService;
import com..Util.FileSave;
import com..Util.Util;

@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;
	@Autowired
	private BoardCommentService boardCommentService;
	
	@Autowired
	private ServletContext servletContext;

	@Autowired
	private FileSave fileSave;
	
	@GetMapping("/board.do")
	public ModelAndView board(@RequestParam(name = "pageNo", required = false, defaultValue = "1") int pageNo, @RequestParam(name="searchColumn", required = false) String searchColumn, 
			@RequestParam(name="searchValue", required=false) String searchValue) {
		ModelAndView mv = new ModelAndView("board");
		
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
		paginationInfo.setTotalRecordCount(boardService.getCount(map));
		
		map.put("firstIndex", paginationInfo.getFirstRecordIndex());
		map.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		mv.addObject("boardList", boardService.getBoardList(map));
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("pageNo", paginationInfo.getCurrentPageNo());
		return mv;
	}

	@GetMapping("/boardDetail.do")
	public ModelAndView boardDetail(@RequestParam("b_no") int b_no, @RequestParam("pageNo") int pageNo, HttpServletRequest request, HttpServletResponse response,@AuthenticationPrincipal MyUserDetails myUserDetails) {
		ModelAndView mv = new ModelAndView("boardDetail");
		
		//조회수 중복방지
		Cookie cookie = null;
		Cookie[] cookies = request.getCookies();
		if(cookies!=null) {
			for(Cookie c:cookies)
				if(c.getName().equals("boardView")) {
					cookie = c;
					break;
				}
		}
		
		if(cookie!=null) {
			if(!cookie.getValue().contains("[" + b_no + "]")) {
				boardService.countUp(b_no);
				cookie.setValue(cookie.getValue() + "_[" + b_no + "]");
				cookie.setMaxAge(60*60);
				response.addCookie(cookie);
			}
		} else {
			boardService.countUp(b_no);
			Cookie newCookie = new Cookie("boardView", "[" + b_no + "]");
			newCookie.setMaxAge(60*60);
			response.addCookie(newCookie);
		}
		
		if(myUserDetails != null) {
			BoardDTO temp = new BoardDTO();
			temp.setB_no(b_no);
			temp.setU_nickname(myUserDetails.getNickname());
			int like = boardService.containLike(temp);
			if(like > 0)
				mv.addObject("likeStatus", true);
			else
				mv.addObject("likeStatus", false);
		}
		
		mv.addObject("detail", boardService.getDetail(b_no));
		mv.addObject("pageNo", pageNo);
		mv.addObject("commentList", boardCommentService.getCommentList(b_no));
		return mv;
	}
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@PostMapping("/boardComment.do")
	public void boardCommentWrite(BoardCommentDTO boardCommentDTO, @RequestParam("pageNo") int pageNo,
			HttpServletResponse response, @RequestParam(name="searchColumn", required = false) String searchColumn, 
			@RequestParam(name="searchValue", required=false) String searchValue) throws Exception {
		if(boardCommentDTO.getC_comment().equals(""))
			boardCommentDTO.setC_comment(null);
		int result = boardCommentService.writeComment(boardCommentDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('댓글쓰기에 성공했습니다'); location.href='./boardDetail.do?b_no="
						+ boardCommentDTO.getB_no() + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('댓글쓰기에 성공했습니다'); location.href='./boardDetail.do?b_no="
						+ boardCommentDTO.getB_no() + "&pageNo=" + pageNo + "'</script>");
		} else {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('댓글쓰기에 실패했습니다'); location.href='./boardDetail.do?b_no="
						+ boardCommentDTO.getB_no() + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('댓글쓰기에 실패했습니다'); location.href='./boardDetail.do?b_no="
						+ boardCommentDTO.getB_no() + "&pageNo=" + pageNo + "'</script>");
		}
	}

	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@PostMapping("/boardWrite.do")
	public void boardWrite(@RequestParam("pageNo") int pageNo, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		BoardDTO boardDTO = new BoardDTO(Util.xss_clean_check(request.getParameter("b_title")), Util.xss_clean_check(request.getParameter("b_content"), request),
				request.getParameter("u_nickname"));
		int result = boardService.write(boardDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			response.getWriter().println(
					"<script> alert('글 작성에 성공했습니다'); location.href='./board.do?pageNo=" + pageNo + "'</script>");
		} else {
			response.getWriter().println(
					"<script> alert('글 작성에 실패했습니다'); location.href='./board.do?pageNo=" + pageNo + "'</script>");
		}
	}
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@PostMapping("/boardImage.do")
	public ResponseEntity<?> imageUpload(MultipartFile file) {
		try {
			String realPath = servletContext.getRealPath("resources/boardImage/");
			String realFileName = fileSave.save(realPath, file);
			
			return ResponseEntity.ok().body("./boardImage/" + realFileName);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.badRequest().build();
		}
	}
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@GetMapping("/boardDelete.do")
	public void boardDelete(@RequestParam("pageNo") int pageNo, @RequestParam("b_no") int b_no, HttpServletRequest request,
			HttpServletResponse response, @RequestParam(name="searchColumn", required = false) String searchColumn, 
			@RequestParam(name="searchValue", required=false) String searchValue) throws Exception {
		BoardDTO boardDTO = new BoardDTO();
		boardDTO.setB_no(b_no);
		int result = boardService.delete(boardDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('글 삭제에 성공했습니다'); location.href='./board.do?pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('글 삭제에 성공했습니다'); location.href='./board.do?pageNo=" + pageNo + "'</script>");
		} else {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('글 삭제에 실패했습니다'); location.href='./board.do?pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('글 삭제에 실패했습니다'); location.href='./board.do?pageNo=" + pageNo + "'</script>");
		}
	}
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@PostMapping("/boardEdit.do")
	public void boardEdit(@RequestParam("pageNo") int pageNo, @RequestParam("b_no") int b_no, HttpServletRequest request,
			HttpServletResponse response, @RequestParam(name="searchColumn", required = false) String searchColumn, 
			@RequestParam(name="searchValue", required=false) String searchValue) throws Exception {
		BoardDTO boardDTO = new BoardDTO(Util.xss_clean_check(request.getParameter("b_title")), Util.xss_clean_check(request.getParameter("b_content"), request),
				request.getParameter("u_nickname"));
		boardDTO.setB_no(b_no);
		int result = boardService.edit(boardDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('글 수정에 성공했습니다'); location.href='./boardDetail.do?b_no="
						+ b_no + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('글 수정에 성공했습니다'); location.href='./boardDetail.do?b_no="
						+ b_no + "&pageNo=" + pageNo + "'</script>");
		} else {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('글 수정에 실패했습니다'); location.href='./boardDetail.do?b_no="
						+ b_no + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('글 수정에 실패했습니다'); location.href='./boardDetail.do?b_no="
						+ b_no + "&pageNo=" + pageNo + "'</script>");
		}
	}
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@GetMapping("/boardCommentDelete.do")
	public void boardCommentDelete(@RequestParam("pageNo") int pageNo, @RequestParam("b_no") int b_no, @RequestParam("c_no") int c_no, HttpServletRequest request,
			HttpServletResponse response, @RequestParam(name="searchColumn", required = false) String searchColumn, 
			@RequestParam(name="searchValue", required=false) String searchValue, @AuthenticationPrincipal MyUserDetails myUserDetails) throws Exception {
		BoardCommentDTO boardCommentDTO = new BoardCommentDTO();
		boardCommentDTO.setB_no(b_no);
		boardCommentDTO.setC_no(c_no);
		boardCommentDTO.setU_nickname(myUserDetails.getNickname());
		int result = boardCommentService.delete(boardCommentDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('댓글 삭제에 성공했습니다'); location.href='./boardDetail.do?b_no="
						+ b_no + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('댓글 삭제에 성공했습니다'); location.href='./boardDetail.do?b_no="
						+ b_no + "&pageNo=" + pageNo + "'</script>");
		} else {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('댓글 삭제에 실패했습니다'); location.href='./boardDetail.do?b_no="
						+ b_no + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('댓글 삭제에 실패했습니다'); location.href='./boardDetail.do?b_no="
						+ b_no + "&pageNo=" + pageNo + "'</script>");
		}
	}
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@PostMapping("/boardCommentEdit.do")
	public void boardCommentEdit(BoardCommentDTO boardCommentDTO, @RequestParam("pageNo") int pageNo,
			HttpServletResponse response, @RequestParam(name="searchColumn", required = false) String searchColumn, 
			@RequestParam(name="searchValue", required=false) String searchValue) throws Exception {
		if(boardCommentDTO.getC_comment().equals(""))
			boardCommentDTO.setC_comment(null);
		int result = boardCommentService.edit(boardCommentDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('댓글수정에 성공했습니다'); location.href='./boardDetail.do?b_no="
						+ boardCommentDTO.getB_no() + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('댓글수정에 성공했습니다'); location.href='./boardDetail.do?b_no="
						+ boardCommentDTO.getB_no() + "&pageNo=" + pageNo + "'</script>");
		} else {
			if(searchColumn!=null && searchValue!=null)
				response.getWriter().println("<script> alert('댓글수정에 실패했습니다'); location.href='./boardDetail.do?b_no="
						+ boardCommentDTO.getB_no() + "&pageNo=" + pageNo + "&searchColumn=" + searchColumn + "&searchValue=" + searchValue + "'</script>");
			else
				response.getWriter().println("<script> alert('댓글수정에 실패했습니다'); location.href='./boardDetail.do?b_no="
						+ boardCommentDTO.getB_no() + "&pageNo=" + pageNo + "'</script>");
		}
	}
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@ResponseBody
	@PostMapping("/boardLikeAjax.do")
	public Map<String, Object> boardLike(BoardDTO boardDTO) {
		int result = boardService.containLike(boardDTO);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		if(result>0) { //이미 좋아요를 누른 상태
			boardService.deleteLike(boardDTO);
		} else { //좋아요를 누르지 않은 상태
			boardService.insertLike(boardDTO);
		}
		boardService.updateLike(boardDTO.getB_no());
		int count = boardService.like(boardDTO.getB_no());
		map.put("count", count);
		return map;
	}
	
}
