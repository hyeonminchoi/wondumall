package com..Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com..DTO.FaqCategoryDTO;
import com..DTO.FaqDTO;
import com..DTO.NoticeDTO;
import com..Service.FaqService;
import com..Util.FileSave;
import com..Util.Util;

@Controller
public class FaqController {
	@Autowired
	private FaqService faqService;
	
	@Autowired
	private ServletContext servletContext;

	@Autowired
	private FileSave fileSave;

	@GetMapping("/faq.do")
	public ModelAndView faq() {
		ModelAndView mv = new ModelAndView("faq");

		List<FaqCategoryDTO> faqCategory = faqService.getFaqCategory();
		List<List<FaqDTO>> faqCategoryDetail = new ArrayList<>();
		
		for(int i=0;i<faqCategory.size();i++) {
			List<FaqDTO> temp = faqService.getFaqCategoryDetail(faqCategory.get(i).getFc_category());
			faqCategoryDetail.add(temp);
		}
		
		mv.addObject("faqCategory", faqCategory);
		mv.addObject("faqCategoryDetail", faqCategoryDetail);

		return mv;
	}
	
	@Secured("ROLE_ADMIN")
	@PostMapping("/faqWrite.do")
	public void faqWrite(HttpServletRequest request, HttpServletResponse response) throws Exception {
		FaqDTO faqDTO = new FaqDTO();
		faqDTO.setFaq_question(Util.xss_clean_check(request.getParameter("faq_question")));
		faqDTO.setFaq_answer(Util.xss_clean_check(request.getParameter("faq_answer"), request));
		faqDTO.setU_nickname(request.getParameter("u_nickname"));
		faqDTO.setFc_category(request.getParameter("fc_category"));
		int result = faqService.write(faqDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			response.getWriter().println(
					"<script> alert('자주묻는질문 작성에 성공했습니다'); location.href='./faq.do'</script>");
		} else {
			response.getWriter().println(
					"<script> alert('자주묻는질문 작성에 실패했습니다'); location.href='./faq.do'</script>");
		}
	}
	
	@Secured("ROLE_ADMIN")
	@PostMapping("/faqImage.do")
	public ResponseEntity<?> imageUpload(MultipartFile file) {
		try {
			String realPath = servletContext.getRealPath("resources/faqImage/");
			String realFileName = fileSave.save(realPath, file);
			
			return ResponseEntity.ok().body("./faqImage/" + realFileName);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.badRequest().build();
		}
	}
	
	@Secured("ROLE_ADMIN")
	@GetMapping("/faqDelete.do")
	public void faqDelete(@RequestParam("faq_no") int faq_no, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		FaqDTO faqDTO = new FaqDTO();
		faqDTO.setFaq_no(faq_no);
		int result = faqService.delete(faqDTO);
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
				response.getWriter().println("<script> alert('자주묻는질문 삭제에 성공했습니다'); location.href='./faq.do'</script>");
		} else {
				response.getWriter().println("<script> alert('자주묻는질문 삭제에 실패했습니다'); location.href='./faq.do'</script>");
		}
	}
}
