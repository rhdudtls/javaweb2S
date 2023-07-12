package com.spring.javaweb2S;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb2S.service.AdminService;
import com.spring.javaweb2S.vo.CategoryMainVO;
import com.spring.javaweb2S.vo.CategorySubVO;
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
	public String productInputGet(Model model) {
		ArrayList<CategoryMainVO> vosMain = adminService.getCategoryMainList();
		
		model.addAttribute("vosMain", vosMain);
		return "admin/productInput";
	}
	
	@RequestMapping(value = "/d1Management", method = RequestMethod.GET)
	public String d1ManagementGet(Model model) {
		
		ArrayList<CategoryMainVO> vos = adminService.getCategoryMainList(); 
		
		model.addAttribute("vos", vos);
		return "admin/d1Management";
	}
	
	@ResponseBody
	@RequestMapping(value = "/categoryMainUpdate", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String categoryMainUpdatePost(
			@RequestParam(name="code", defaultValue = "", required = false)String code,
			@RequestParam(name="name", defaultValue = "", required = false)String name) {
		
		CategoryMainVO vo = adminService.getCategoryMainInfo(name);
		
		if(vo != null) { 
			if(vo.getCategoryMainCode().equals(code)) {
				return "수정사항이 없습니다.";
			}
			else {
				return "대분류명이 이미 존재합니다. 대분류명은 중복될 수 없습니다.";
			}
		}

		int res = adminService.setCategoryMainUpdate(code, name);
		
		if(res == 1) return "대분류 수정 완료!";
		else return "대분류 수정 실패!";
	}
	
	@ResponseBody
	@RequestMapping(value = "/categoryMainInput", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String categoryMainInputPost(HttpServletRequest request) {
		
		String[] codeArr = request.getParameterValues("codeArr");
		String[] nameArr = request.getParameterValues("nameArr");
		
		int codeCnt = adminService.getCategoryDupli("main", "categoryMainCode", codeArr);
		int nameCnt = adminService.getCategoryDupli("main", "categoryMainName", nameArr);
		
		if(codeCnt != 0 || nameCnt != 0) {
			return "입력된 대분류 코드 또는 대분류명이 중복되었습니다. 다시 확인하세요.";
		}
		
		int res = adminService.setCategoryMainInput(codeArr, nameArr);
		
		
		if(res >= 1) return "대분류가 추가되었습니다.";
		else return "대분류 추가 실패";
		
	}
	
	@RequestMapping(value = "/d2Management", method = RequestMethod.GET)
	public String d2ManagementGet(Model model) {
		
		ArrayList<CategoryMainVO> vosMain = adminService.getCategoryMainList(); 
		ArrayList<CategorySubVO> vosSub = adminService.getCategorySubList();
		
		model.addAttribute("vosMain", vosMain);
		model.addAttribute("vosSub", vosSub);
		
		return "admin/d2Management";
	}

	@ResponseBody
	@RequestMapping(value = "/categoryDelete", method = RequestMethod.POST)
	public String categorySubDeletePost(
			@RequestParam(name="code", defaultValue = "", required = false)String code,
			@RequestParam(name="flag", defaultValue = "", required = false)String flag) {
		
		int res = adminService.setCategoryDelete(flag, code);
		
		if(res == 1) return "1";
		else return "0";
	}
	
	@ResponseBody
	@RequestMapping(value = "/categorySubUpdate", method = RequestMethod.POST)
	public String categorySubUpdatePost(
			@RequestParam(name="mName", defaultValue = "", required = false)String mName,
			@RequestParam(name="originSCode", defaultValue = "", required = false)String originSCode,
			@RequestParam(name="originSName", defaultValue = "", required = false)String originSName,
			@RequestParam(name="sCode", defaultValue = "", required = false)String sCode,
			@RequestParam(name="sName", defaultValue = "", required = false)String sName) {
		
		int codeCnt = 0, nameCnt = 0;
		
		if(!originSCode.equals(sCode)) codeCnt = adminService.getCategorySubDupli("categorySubCode", sCode);
		if(!originSName.equals(sName)) nameCnt = adminService.getCategorySubDupli("categorySubName", sName);

		if(codeCnt == 1 || nameCnt == 1) {
			return "1";
		}
		
		int res = adminService.setCategorySubUpdate(mName,sCode,sName,originSCode);
		
		if(res == 1) return "2";
		else return "0";
	}
	
	@ResponseBody
	@RequestMapping(value = "/categorySubInput", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String categorySubInputPost(HttpServletRequest request) {
		
		String[] sCodeArr = request.getParameterValues("sCodeArr");
		String[] sNameArr = request.getParameterValues("sNameArr");
		String[] mCodeArr = request.getParameterValues("mCodeArr");
		
		int codeCnt = adminService.getCategoryDupli("sub", "categorySubCode", sCodeArr);
		int nameCnt = adminService.getCategoryDupli("sub", "categorySubName", sNameArr);
		
		if(codeCnt != 0 || nameCnt != 0) {
			return "1";
		}
		
		int res = adminService.setCategorySubInput(sCodeArr, sNameArr, mCodeArr);
		
		
		if(res >= 1) return "2";
		else return "0";
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/getCategorySubName", method = RequestMethod.POST)
	public ArrayList<CategorySubVO> categorySubDeletePost(
			@RequestParam(name="mainCode", defaultValue = "", required = false)String mainCode) {
		
		ArrayList<CategorySubVO> vos = adminService.getCategorySubName(mainCode);
		
		return vos;
	}


}
