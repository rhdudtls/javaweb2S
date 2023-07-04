package com.spring.javaweb2S;

import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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
	
	@Autowired
	JavaMailSender mailSender;
	
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
	public String memberJoinPost(MemberVO vo,
			@RequestParam(name="emailAgree", defaultValue = "off", required = false)String emailAgree) {
		System.out.println("emailAgree :" + emailAgree);
		
		if(emailAgree.equals("on")) vo.setSnsCheck("YES");
		else vo.setSnsCheck("NO");
		
		if(memberService.getMemberDupliCheck(vo.getMid(), "mid") != null) return "redirect:/message/idCheckNo";
		if(memberService.getMemberDupliCheck(vo.getNickName(), "nickName") != null) return "redirect:/message/nickCheckNo";
		if(memberService.getMemberDupliCheck(vo.getTel(), "tel") != null) return "redirect:/message/telCheckNo";
		if(memberService.getMemberDupliCheck(vo.getEmail(), "email") != null) return "redirect:/message/emailCheckNo";
		
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		int res = memberService.setMemberJoin(vo);
		
		if(res == 1) return "redirect:/message/memberJoinOk"; else return
		"redirect:/message/memberJoinNo";
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberDupliCheck/{flag}", method = RequestMethod.POST)
	public String memberDupliCheckPost(@PathVariable String flag,
			@RequestParam(name="data", defaultValue = "", required = false)String data) {
		
		MemberVO vo = memberService.getMemberDupliCheck(data, flag);
		
		if(vo == null) return "0";
		else return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberEmailSend", method = RequestMethod.POST)
	public String memberEmailSend(HttpSession eSession,
			@RequestParam(name="email", defaultValue = "", required = false)String email) throws MessagingException {
		String uid = UUID.randomUUID().toString().substring(0,6);
		
		String toMail = email;
		String title = "[마이닭]회원가입 인증번호 발송";
		String content = "";
		
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		messageHelper.setTo(toMail);
		messageHelper.setSubject(title);
		messageHelper.setText(content);
		
		content += "<h2 style='text-align:center'>마이닭 인증번호</h2>";
		content += "<hr style='width:60%'>";
		content += "<div style='text-align:center'><b><font color='blue' size='4'>"+uid+"</font></b></div>";
		
		messageHelper.setText(content,true);
		
		mailSender.send(message);
		
		eSession.setAttribute("sEmailKey", uid);
		eSession.setMaxInactiveInterval(60*5);
		
		return "";
				
	}
	@ResponseBody
	@RequestMapping(value = "/memberEmailAuth", method = RequestMethod.POST)
	public String memberEmailAuthPost(HttpSession eSession, HttpServletRequest request,
			@RequestParam(name="emailKey", defaultValue = "", required = false)String emailKey) {
		
		eSession = request.getSession();
		String sEmailKey = (String) eSession.getAttribute("sEmailKey");
		if(sEmailKey == null) {
			return "2";
		}
		else if(sEmailKey.equals(emailKey)) {
			eSession.removeAttribute("sEmailKey");
			return "1";
		}
		else {
			return "0";
		}
		
	}
}
