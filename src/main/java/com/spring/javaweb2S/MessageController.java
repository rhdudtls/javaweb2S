package com.spring.javaweb2S;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String messageGet(@PathVariable String msgFlag, Model model,
			@RequestParam(name="mid", defaultValue = "", required = false)String mid,
			@RequestParam(name="temp", defaultValue = "", required=false) String temp) {
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
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "아이디와 비밀번호가 올바르지 않습니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("productInputOk")) {
			model.addAttribute("msg", "상품이 등록되었습니다.");
			model.addAttribute("url", "/admin/productInput");
		}
		else if(msgFlag.equals("productInputNo")) {
			model.addAttribute("msg", "같은 이름의 상품이 존재합니다. 다시 입력하세요.");
			model.addAttribute("url", "/admin/productInput");
		}
		else if(msgFlag.equals("optionInputNo")) {
			model.addAttribute("msg", "같은 이름의 옵션이 존재합니다. 다시 입력하세요.");
			if(temp == "") {
				model.addAttribute("url", "/admin/productOption");
			}
			else {
				model.addAttribute("url", "/admin/productOption2?productName="+temp);
			}
		}
		else if(msgFlag.equals("optionInputOk")) {
			if(temp == "") {
				model.addAttribute("msg", "옵션이 등록되었습니다.");
				model.addAttribute("url", "/admin/productOption");
			}
			else {
				model.addAttribute("msg", "옵션이 등록되었습니다.");
				model.addAttribute("url", "/admin/productOption2?productName="+temp);
			}
		}
		
		
		return "include/message";
	}
}
