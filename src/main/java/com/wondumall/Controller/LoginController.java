package com..Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com..DTO.LoginDTO;
import com..Service.LoginService;

@Controller
public class LoginController {
	
	@Autowired
	private LoginService loginService;
	
	@PostMapping(value = "/checkID") //ResposeBody => 결과값을 내상태에서 출력
	public @ResponseBody String checkID(LoginDTO dto) {
		String result = "1";
		//db에게 물어보기 count(*)사용
		
		/*
		 * int count = loginService.checkID(request.getParameter("eamil"));
		 * 
		 * result = String.valueOf(count);
		 */
		
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
