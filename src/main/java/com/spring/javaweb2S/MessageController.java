package com.spring.javaweb2S;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String messageGet(@PathVariable String msgFlag, Model model) {
		if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원가입완료!!!");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "회원가입 실패~~");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("idCheckNo")) {
			model.addAttribute("msg", "중복된 아이디가 존재합니다. 다시 확인해주세요.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("nickCheckNo")) {
			model.addAttribute("msg", "중복된 닉네임이 존재합니다. 다시 확인해주세요.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("telCheckNo")) {
			model.addAttribute("msg", "이미 가입된 전화번호입니다. 기존 아이디로 로그인하세요.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("emailCheckNo")) {
			model.addAttribute("msg", "이미 가입된 이메일입니다. 기존 아이디로 로그인하세요.");
			model.addAttribute("url", "/member/memberJoin");
		}
			
		return "include/message";
	}
}
