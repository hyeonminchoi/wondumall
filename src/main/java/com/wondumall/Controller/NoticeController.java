package com..Controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com..DTO.NoticeDTO;
import com..DTO.NoticecommentDTO;
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
	public ModelAndView notice(@RequestParam(name = "pageNo", required = false, defaultValue = "1") int pageNo) {
		ModelAndView mv = new ModelAndView("notice");

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageNo); // 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(10); // 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(10); // 페이징 리스트의 사이즈
		paginationInfo.setTotalRecordCount(noticeService.getCount());

		Map<String, Object> map = new HashMap<>();
		map.put("firstIndex", paginationInfo.getFirstRecordIndex());
		map.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		mv.addObject("noticeList", noticeService.getNoticeList(map));
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("pageNo", paginationInfo.getCurrentPageNo());
		return mv;
	}

	@GetMapping("/noticeDetail.do")
	public ModelAndView noticeDetail(@RequestParam("n_no") int n_no, @RequestParam("pageNo") int pageNo) {
		ModelAndView mv = new ModelAndView("noticeDetail");
		mv.addObject("detail", noticeService.getDetail(n_no));
		mv.addObject("pageNo", pageNo);
		mv.addObject("commentList", noticeCommentService.getCommentList(n_no));
		return mv;
	}

	@PostMapping("/noticeComment.do")
	public void noticeCommentWrite(NoticecommentDTO noticecommentDTO, @RequestParam("pageNo") int pageNo,
			HttpServletResponse response) throws Exception {

		int result = noticeCommentService.writeComment(noticecommentDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			response.getWriter().println("<script> alert('댓글쓰기에 성공했습니다'); location.href='./noticeDetail.do?n_no="
					+ noticecommentDTO.getN_no() + "&pageNo=" + pageNo + "'</script>");
		} else {
			response.getWriter().println("<script> alert('댓글쓰기에 실패했습니다'); location.href='./noticeDetail.do?n_no="
					+ noticecommentDTO.getN_no() + "&pageNo=" + pageNo + "'</script>");
		}
	}

	@PostMapping("/noticeWrite.do")
	public void noticeWrite(@RequestParam("pageNo") int pageNo, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		NoticeDTO noticeDTO = new NoticeDTO();
		noticeDTO.setN_title(Util.xss_clean_check(request.getParameter("n_title")));
		noticeDTO.setN_content(Util.xss_clean_check(request.getParameter("n_content"), request));
		noticeDTO.setU_nickname(request.getParameter("u_nickname"));
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

}
