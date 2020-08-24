package com.bd.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller("user.userController")
@RequestMapping("/user/*")
public class UserController {
	@Autowired
	private UserService service;
	
	/*@RequestMapping(value="user", method=RequestMethod.GET)
	public String userForm(Model model) {
		model.addAttribute("mode","user");
		return ".user.user";
	}*/
	
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String loginForm() {
		return ".user.login";
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String loginSubmit(
			@RequestParam String userId,
			@RequestParam String userPwd,
			HttpSession session,
			Model model
			) {
		User dto = service.loginUser(userId);
		if(dto==null||!userPwd.equals(dto.getUserPwd())) {
			model.addAttribute("message","아이디 또는 패스워드가 일치하지 않습니다.");
			return ".user.login";
		}
		SessionInfo info=new SessionInfo();
		info.setUserId(dto.getUserId());
		info.setUserName(dto.getUserName());
		info.setSeparate(dto.getSeparate());
		info.setUserIdx(dto.getUserIdx());
		
		if(info.getSeparate()==1) {
			int restaurantsNum = service.readRestaurantsNum(dto.getUserIdx());
			info.setRestaurantsNum(restaurantsNum);
		}
		session.setMaxInactiveInterval(30*60);
		session.setAttribute("user", info);
		
		
		String uri=(String)session.getAttribute("preLoginURI");
		session.removeAttribute("preLoginURI");
		if(uri==null)
			uri="redirect:/";
		else
			uri="redirect:"+uri;
		
		return uri;
	}
	
	@RequestMapping(value="logout")
	public String logout(HttpSession session) {
		session.removeAttribute("user");
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value="joincheck", method=RequestMethod.GET)
	public String joincheck() {
		return ".user.joincheck";
	}
	
	@RequestMapping(value="join", method=RequestMethod.GET)
	public String joinForm1(
			Model model
			) {
		model.addAttribute("state","user");
		return  ".user.join";
	}
	
	@RequestMapping(value="fcjoin", method=RequestMethod.GET)
	public String joinForm2(
			Model model
			) {
		model.addAttribute("state","user");
		return  ".user.fcjoin";
	}
	
	@RequestMapping(value="join", method=RequestMethod.POST)
	public String joinSubmit1(
			User dto,
			final RedirectAttributes reAttr,
			Model model
			 ){
		try {
			service.insertUser(dto);
		} catch (Exception e) {
			return ".user.join";
		}
		
		StringBuilder sb = new StringBuilder();
		sb.append(dto.getUserName()+"님의 회원가입이 정상 승인되었습니다.<br>");
		sb.append("메인화면으로 이동하여 로그인해주시요.");
		
		reAttr.addFlashAttribute("message",sb.toString());
		
		
		return "redirect:/user/complete";
	}
	
	@RequestMapping(value="fcjoin", method=RequestMethod.POST)
	public String joinSubmit2(
			User dto,
			final RedirectAttributes reAttr,
			Model model
			) {
		try {
			service.insertfcUser(dto);
		} catch (Exception e) {
			model.addAttribute("message","회원가입 실패");
			return ".user.fcjoin";
		}
		StringBuilder sb = new StringBuilder();
		sb.append(dto.getUserName()+"님의 회원가입이 정상 승인되었습니다.");
		sb.append("메인화면으로 이동하여 로그인해주세요.<br>");
		sb.append("※가게 상세정보를 업데이트 하셔야 승인요청이 됩니다.<br>");
		
		reAttr.addFlashAttribute("message",sb.toString());
		
		
		return "redirect:/user/complete";
	}
	
	@RequestMapping(value="location", method=RequestMethod.POST)
	@ResponseBody
	public String location(
			@RequestParam String ln,
			@RequestParam String lt,
			@RequestParam String addr,
			HttpSession session
			) {
		if(ln==null||lt==null) {
			String check = "true";
			return check;
		}
		Sessionlocation location = new Sessionlocation();
		location.setLongitude(ln);
		location.setLatitude(lt);
		location.setAddr(addr);
		session.setMaxInactiveInterval(30*60);
		session.setAttribute("location", location);
		return "";
	}
	
	@RequestMapping(value="complete")
	public String complete(
			@ModelAttribute("message") String message
			) throws Exception{
		if(message == null || message.length()==0) {
			return "redirect:/";
		}
		
		return ".user.message";
	}
	
	
	
	@RequestMapping(value="userIdCheck", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> idCheck(
			@RequestParam String userId
			) throws Exception {
		
		String p="true";
		User dto=service.readUser(userId);
		if(dto!=null)
			p="false";
		
		Map<String, Object> model=new HashMap<>();
		model.put("passed", p);
		return model;
	}
	

}
