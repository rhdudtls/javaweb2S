package com.spring.javaweb2S;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb2S.service.MemberService;
import com.spring.javaweb2S.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet() {
		return "member/memberLogin";
	}
	
	@RequestMapping(value = "/memberJoinType", method = RequestMethod.GET)
	public String memberJoinTypeGet() {
		return "member/memberJoinType";
	}
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJoin";
	}
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(MemberVO vo) {
		
		if(memberService.getMemberDupliCheck(vo.getMid(), "mid") != null) return "redirect:/message/idCheckNo";
		if(memberService.getMemberDupliCheck(vo.getNickName(), "nickName") != null) return "redirect:/message/nickCheckNo";
		if(memberService.getMemberDupliCheck(vo.getTel(), "tel") != null) return "redirect:/message/telCheckNo";
		if(memberService.getMemberDupliCheck(vo.getEmail(), "email") != null) return "redirect:/message/emailCheckNo";
		
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		int res = memberService.setMemberJoin(vo);
		
		if(res == 1) return "redirect:/message/memberJoinOk";
		else return "redirect:/message/memberJoinNo";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberDupliCheck/{flag}", method = RequestMethod.POST)
	public String memberDupliCheckPost(@PathVariable String flag,
			@RequestParam(name="data", defaultValue = "", required = false)String data) {
		
		MemberVO vo = memberService.getMemberDupliCheck(data, flag);
		
		if(vo == null) return "0";
		else return "1";
	}
}
