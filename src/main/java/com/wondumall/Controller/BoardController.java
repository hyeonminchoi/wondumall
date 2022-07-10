package com..Controller;

import java.util.HashMap;
import java.util.Map;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com..Service.BoardService;

@Controller
public class BoardController {
	@Autowired BoardService boardService;
	
	@GetMapping("/board.do")
	public ModelAndView notice(@RequestParam(name = "pageNo", required = false, defaultValue = "1") int pageNo) {
		ModelAndView mv = new ModelAndView("board");
		
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageNo); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(10); //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(10); //페이징 리스트의 사이즈
		paginationInfo.setTotalRecordCount(boardService.getCount());
		
		Map<String, Object> map = new HashMap<>();
		map.put("firstIndex", paginationInfo.getFirstRecordIndex());
		map.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		mv.addObject("boardList", boardService.getBoardList(map));
		mv.addObject("paginationInfo", paginationInfo);
		return mv;
	}
}
