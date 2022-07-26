package com..Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.batch.MyBatisPagingItemReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com..Config.MyUserDetails;
import com..DTO.LoginDTO;
import com..Service.LoginService;
import com..Util.Util;

@Controller
public class LoginController {
	
	@Autowired
	private LoginService loginService;
	
	//회원정보수정	
	@GetMapping(value = "/update")
	public String update() {

		return "update";
	}
	
	@PostMapping(value = "/update.do")
	public String update(LoginDTO dto) {
		
		loginService.update(dto);
		
		return "index";
	}
	
	//마이페이지 구현
	@GetMapping(value = "/mypage")
	public String mypage() {
		return"mypage";
	}
	@PostMapping(value ="/mypage.do")
	public ModelAndView mypage(LoginDTO dto) {
		
		ModelAndView mv = new ModelAndView("mypage");
		
		loginService.mypage(dto);
		
		mv.addObject("mypage", dto);
		
		return mv;
	}

	
	//email 중복체크
	@PostMapping(value = "/emailCheck") //ResposeBody => 결과값을 내상태에서 출력
	@ResponseBody
	public int emailCheck(@RequestParam("email") String email) {
		int result = loginService.emailCheck(email);
		return result;
	}
	//nickname 중복체크
		@PostMapping(value = "/nicknameCheck") //ResposeBody => 결과값을 내상태에서 출력
		@ResponseBody
		public int nicknameCheck(@RequestParam("nickname") String nickname) {
			int result = loginService.nicknameCheck(nickname);
			return result;
		}
	//일반, 사업자 구분
		@PostMapping(value = "/gradeCheck") //ResposeBody => 결과값을 내상태에서 출력
		@ResponseBody
		public int gradeCheck(@RequestParam("grade") String grade) {
			int result = loginService.gradeCheck(grade);
			return result;
		}
	
	
	//2.join 화면 불러오기
	
	@GetMapping(value = "/join.do")
	public String join() {
		return "join";
	}
	@PostMapping(value = "/join.do")
	public String join(LoginDTO dto) throws Exception{
		Util.userInfoRegex("join", dto);
		int result = loginService.join(dto);
		
		if(result == 1) {
			return "./login";
		}else {
			return "./join";
		}
	}
	

	@GetMapping("/login.do")
    public String login() {
        return "login";
    }
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@GetMapping("/snsInfoCheck.do")
	public String snsInfoCheck(@AuthenticationPrincipal MyUserDetails myUserDetails) {
		if(myUserDetails.getNickname() == null) {
			return "/snsInfo";
		} else {
			return "redirect:/";
		}
	}
	
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@PostMapping("/snsInfo.do")
	public void snsInfoUpdate(LoginDTO loginDTO, @AuthenticationPrincipal MyUserDetails myUserDetails, HttpServletResponse response) throws Exception {
		Util.userInfoRegex("snsInfo", loginDTO);
		response.setContentType("text/html; charset=UTF-8");
		loginDTO.setU_provider(myUserDetails.getProvider());
		int result = loginService.snsInfoUpdate(loginDTO);
		if (result > 0) {
			response.getWriter().println(
					"<script> alert('회원정보 수정에 성공했습니다\\n다시 로그인해주세요.'); location.href='./logout.do'</script>");
		} else {
			response.getWriter().println(
					"<script> alert('회원정보 수정에 실패했습니다'); location.href='./snsInfoCheck.do'</script>");
		}
	}
}
