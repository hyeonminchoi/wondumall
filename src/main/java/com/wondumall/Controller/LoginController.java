package com..Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com..DTO.LoginDTO;
import com..Service.LoginService;

@Controller
public class LoginController {
	
	@Autowired
	private LoginService loginService;
	
	//회원정보수정	
	@PostMapping(value = "/update")
	public String update(LoginDTO dto) {
		loginService.update(dto);
		return "redirect:/login.do";
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
	public String join(LoginDTO dto) {
		
		int result = loginService.join(dto);
		
		if(result == 1) {
			return "./login";
		}else {
			return "./join";
		}
	}
	
//	//1. /login화면 불러오기
//	@GetMapping(value = "/login.do")
//	public String login() {
//		return "login";
//	}
//	
//	//1. 로그인 로직 처리하기 일반로그인(SNS X)
//	@PostMapping(value = "/login.do")
//	public String login(LoginDTO dto, HttpSession session) {
//		
//		//Service DAO 도 만들기
//		dto = loginService.login(dto);
//		if(dto != null) {
//			//정상 로그인 = 세션 만들고
//			session.setMaxInactiveInterval(15*60); //초단위로 세션 유지시간 지정
//			session.setAttribute("nickname", dto.getU_nickname());
//			
//			return "redirect:/";
//		}else {
//			//비정상 로그인 = 다시 로그인 하세요.
//			return "redirect:/login?error=1254";
//		}
//		
//		
//	}

	@GetMapping("/login.do")
    public String login() {
        return "login";
    }

}
