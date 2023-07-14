package com.spring.javaweb2S;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb2S.service.AdminService;
import com.spring.javaweb2S.vo.CategoryMainVO;
import com.spring.javaweb2S.vo.CategorySubVO;
import com.spring.javaweb2S.vo.MemberVO;
import com.spring.javaweb2S.vo.OptionVO;
import com.spring.javaweb2S.vo.ProductVO;

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
		return "admin/shop/productInput";
	}
	
	@RequestMapping(value = "/d1Management", method = RequestMethod.GET)
	public String d1ManagementGet(Model model) {
		
		ArrayList<CategoryMainVO> vos = adminService.getCategoryMainList(); 
		
		model.addAttribute("vos", vos);
		return "admin/shop/d1Management";
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
		
		return "admin/shop/d2Management";
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
	
	// 관리자 상품등록시에 ckeditor에 그림을 올린다면 dbShop폴더에 저장되고, 저장된 파일을 브라우저 textarea상자에 보여준다. 
	@ResponseBody
	@RequestMapping("/imageUpload")
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String originalFilename = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date) + "_" + originalFilename;
		
		byte[] bytes = upload.getBytes();
		
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/shop/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath + originalFilename));
		outStr.write(bytes);
		
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/shop/" + originalFilename;
		out.println("{\"originalFilename\":\""+originalFilename+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();
		outStr.close();
	}
	
	// 상품 등록
	@RequestMapping(value = "/productInput", method = RequestMethod.POST)
	public String productInputPost(MultipartFile file, ProductVO vo) {
		// 이미지파일 업로드시에 ckeditor폴더에서 product폴더로 복사작업처리....(dbShop폴더에서 'dbShop/product'로)
		
		ProductVO voCheck = adminService.getProductInfo(vo.getProductName());
		
		if(voCheck != null) {
			return "redirect:/message/productInputNo";
		}
		
		adminService.imgCheckProductInput(file, vo);
		
		return "redirect:/message/productInputOk";
	}
	
	@RequestMapping(value = "/productList", method = RequestMethod.GET)
	public String productListGet(Model model,
			@RequestParam(name="part", defaultValue = "all", required = false) String part) {
		ArrayList<ProductVO> mainNameVos = adminService.getMainName();
		ArrayList<ProductVO> productVos = adminService.getProductList(part);
		
		model.addAttribute("mainNameVos", mainNameVos);
		model.addAttribute("productVos", productVos);
		
		return "admin/shop/productList";
	}
	
	@RequestMapping(value = "/productOption", method = RequestMethod.GET)
	public String productOptionGet(Model model) {
		ArrayList<CategoryMainVO> mainVos = adminService.getCategoryMainList();
		
		model.addAttribute("mainVos", mainVos);
		
		return "admin/shop/productOption";
	}
	
	@RequestMapping(value = "/productOption", method = RequestMethod.POST)
	public String productOptionPost(Model model, OptionVO vo, String productName, String[] optionName, int[] optionPrice,
			@RequestParam(name="flag", defaultValue = "", required=false) String flag) {
		
		int optionCnt = adminService.getOptionDupli(vo.getProductIdx(), optionName);
		if(optionCnt != 0) {
			model.addAttribute("temp", productName);
			return "redirect:/message/optionInputNo";
		}
		
		// 동일한 옵션이 없으면 vo에 set시킨후 옵션테이블에 등록시킨다.
		for(int i=0; i<optionName.length; i++) {
			vo.setProductIdx(vo.getProductIdx());
			vo.setOptionName(optionName[i]);
			vo.setOptionPrice(optionPrice[i]);
			
			adminService.setOptionInput(vo);
			
		}
		if(!flag.equals("option2")) return "redirect:/message/optionInputOk";
		else {
			model.addAttribute("temp", productName);
			return "redirect:/message/optionInputOk";
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/categoryProductName", method = RequestMethod.POST)
	public List<ProductVO> categoryProductNamePost(String categoryMainCode, String categorySubCode) {
		return adminService.getCategoryProductName(categoryMainCode, categorySubCode);
	}
	
	// 옵션 등록창에서, 상품을 선택하면 선택된 상품의 상세설명을 가져와서 뿌리기
	@ResponseBody
	@RequestMapping(value="/getProductInfor", method = RequestMethod.POST)
	public ProductVO getProductInforPost(String productName) {
		return adminService.getProductInfor(productName);
	}
	
	// 옵션등록창에서 '옵셔보기'버튼클릭시에 해당 제품의 모든 옵션을 보여주기
	@ResponseBody
	@RequestMapping(value="/getOptionList", method = RequestMethod.POST)
	public List<OptionVO> getOptionListPost(int productIdx) {
		return adminService.getOptionList(productIdx);
	}
	
	@ResponseBody
	@RequestMapping(value="/optionDelete", method = RequestMethod.POST)
	public String optionDeletePost(int idx) {
		adminService.setOptionDelete(idx);
		return "";
	}
	
	@RequestMapping(value = "/productContent", method = RequestMethod.GET)
	public String productContentGet(Model model, int idx) {
		
		ProductVO productVO = adminService.getProductInfoIdx(idx);	   // 1건의 상품 정보를 불러온다.
		List<OptionVO> optionVOS = adminService.getOptionList(idx); // 해당 상품의 모든 옵션 정보를 가져온다.
		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVOS", optionVOS);
		
		return "admin/shop/productContent";
	}
	
	@RequestMapping(value = "/productOption2", method = RequestMethod.GET)
	public String productOption2Get(Model model, String productName) {
		ProductVO vo = adminService.getProductInfor(productName);
		List<OptionVO> optionVOS = adminService.getOptionList(vo.getIdx());
		model.addAttribute("vo", vo);
		model.addAttribute("optionVOS", optionVOS);
		return "admin/shop/productOption2";
	}
	
	@RequestMapping(value = "/productUpdate", method = RequestMethod.GET)
	public String productUpdateGet(Model model, int idx) {
		ProductVO vo = adminService.getProductInfoIdx(idx);
		List<CategoryMainVO> vosMain = adminService.getCategoryMainList();
		List<CategorySubVO> vosSub = adminService.getCategorySubName(vo.getCategoryMainCode());
		
		model.addAttribute("vo", vo);
		model.addAttribute("vosMain", vosMain);
		model.addAttribute("vosSub", vosSub);
		return "admin/shop/productUpdate";
	}
	
}
