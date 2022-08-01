package com..Controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	public String update(LoginDTO dto, @AuthenticationPrincipal MyUserDetails myUserDetails) throws Exception	{
		Util.userInfoRegex("update", dto);
		dto.setU_no(myUserDetails.getNo());
		loginService.update(dto);
		return "redirect:./logout.do";
	}
	
	@GetMapping("/findpw.do")
	public String findpw() {
		return "findpw";
	}
	
	//비밀번호찾기
	@PostMapping(value = "/findpw.do")
	public ModelAndView findpw(HttpServletResponse response, @RequestParam String u_email, @RequestParam String u_tel,  HttpSession session, @AuthenticationPrincipal MyUserDetails myUserDetails) throws Exception {
		ModelAndView mv = new ModelAndView();
		LoginDTO user = new LoginDTO();
		user.setU_email(u_email);
		user.setU_tel(u_tel);
		user.setU_provider("");
		if(loginService.contain(user)>0) {
			//변경 페이지 이동
			mv.setViewName("resetpw");
			mv.addObject("user", user);
			return mv;
		} else {
			//존재하지 않는 경우
			mv.setViewName("findpw");
			return mv;
		}
	}
	
	@PostMapping("/resetpw.do")
	public String resetpw(LoginDTO user) {
		System.out.println(user);
		loginService.resetpw(user);
		return "resetpw";
	}
	
	//비밀번호변경
	//현재비밀번호 확인
	@GetMapping(value = "/pwchange")
	public ModelAndView pwchange() {
		return new ModelAndView("pwchange");
	}
	
	@PostMapping(value = "/pwchange.do")
	public void checkpw(HttpServletResponse response, @RequestParam String changepw, @RequestParam String u_pw, HttpSession session, @AuthenticationPrincipal MyUserDetails myUserDetails) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		if(loginService.checkpw(myUserDetails.getNo(), u_pw)) { //기존 비밀번호랑 일치
			if(loginService.checkpw(myUserDetails.getNo(), changepw)) { //기존 비밀번호랑 현재 비밀번호가 일치
				response.getWriter().println("<script>alert('기존 비밀번호와 일치합니다.'); window.location.href = document.referrer;</script>");
			} else { //기존 비밀번호랑 현재 비밀번호가 다를 경우
				LoginDTO user = new LoginDTO();
				user.setU_no(myUserDetails.getNo());
				user.setU_pw(changepw);
				if(loginService.changepw(user)>0) { //변경 성공
					session.invalidate();
					response.getWriter().println("<script>alert('비밀번호 변경에 성공했습니다.\\n다시 로그인해주세요.'); location.href='./login.do';</script>");
				} else { //변경 실패
					response.getWriter().println("<script>alert('비밀번호 변경에 실패했습니다.'); window.location.href = document.referrer;</script>");
				}
			}
		} else {
			response.getWriter().println("<script>alert('현재 비밀번호와 다릅니다.'); window.location.href = document.referrer;</script>");
		}
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
	//회원탈퇴
	@Secured({"ROLE_USER", "ROLE_BUSINESS", "ROLE_ADMIN"})
	@GetMapping (value = "/resign.do")
	public String resign (@AuthenticationPrincipal MyUserDetails myUserDetails) {
		loginService.resign(myUserDetails.getNo());
		
		return "redirect:./logout.do";
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
			return "redirect:./login.do";
		}else {
			return "redirect:./join.do";
		}
	}
	
	//로그인
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
