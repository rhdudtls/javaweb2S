package com.spring.javaweb2S;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb2S.service.AdminService;
import com.spring.javaweb2S.vo.MemberVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@RequestMapping(value = "/adminMain", method = RequestMethod.GET)
	public String adminMainGet() {
		return "admin/adminMain";
	}
	
	@RequestMapping(value = "/adMemberList", method = RequestMethod.GET)
	public String adMemberListGet(Model model) {
		
		ArrayList<MemberVO> vos = adminService.getMemberList();
		model.addAttribute("vos", vos);
		
		return "admin/adMemberList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/adMemberList", method = RequestMethod.POST)
	public ArrayList<MemberVO> adMemberListPost(Model model,
			@RequestParam(name="searchType", defaultValue = "", required = false)String searchType,
			@RequestParam(name="searchString", defaultValue = "", required = false)String searchString) {
		
		ArrayList<MemberVO> vosSearch = adminService.getMemberList(searchType, searchString);
		
		return vosSearch;
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberDelete", method = RequestMethod.POST)
	public String memberDeletePost(@RequestParam(name="idx", defaultValue = "0", required = false)int idx) {
		int res1 = 0, res2 = 0;
		
		// 오버로딩
		if(idx == 0) {
			res1 = adminService.setMemberDel();
			System.out.println(res1);
		}
		else {
			res2 = adminService.setMemberDel(idx);
		}
		
		if(res1 >= 0 || res2 >= 1) return "1";
		else return "0";
	}
	
	@ResponseBody
	@RequestMapping(value = "/adLevelUpdate", method = RequestMethod.POST)
	public String adLevelUpdatePost(
			@RequestParam(name="idx", defaultValue = "0", required = false)int idx,
			@RequestParam(name="level", defaultValue = "4", required = false)int level) {
		
		int res = adminService.setLevelUpdate(idx, level);
		
		if(res == 1) return "1";
		else return "0";
	}
	
	@ResponseBody
	@RequestMapping(value = "/adPointUpdate", method = RequestMethod.POST)
	public String adPointUpdatePost(
			@RequestParam(name="idx", defaultValue = "0", required = false)int idx,
			@RequestParam(name="point", defaultValue = "0", required = false)int point) {
		
		int res = adminService.setPointUpdate(idx, point);
		
		if(res == 1) return "1";
		else return "0";
	}
	
	@ResponseBody
	@RequestMapping(value = "/adMemberUpdateInfo", method = RequestMethod.POST)
	public MemberVO adMemberUpdateInfoPost(
			@RequestParam(name="idx", defaultValue = "0", required = false)int idx) {
		
		MemberVO vo = adminService.getMemberInfo(idx);
		
		return vo;
	}
	
	@RequestMapping(value = "/productInput", method = RequestMethod.GET)
	public String productInputGet() {
		return "admin/productInput";
	}
	
}
