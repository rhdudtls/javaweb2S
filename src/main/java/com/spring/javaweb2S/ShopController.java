package com.spring.javaweb2S;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaweb2S.service.AdminService;
import com.spring.javaweb2S.service.ShopService;
import com.spring.javaweb2S.vo.CategoryMainVO;
import com.spring.javaweb2S.vo.CategorySubVO;
import com.spring.javaweb2S.vo.OptionVO;
import com.spring.javaweb2S.vo.ProductVO;

@Controller
@RequestMapping("/shop")
public class ShopController {
	
	@Autowired
	ShopService shopService;
	
	@Autowired
	AdminService adminService;
	
	@RequestMapping(value = "/shopList", method = RequestMethod.GET)
	public String shopListGet(Model model,
			@RequestParam(name="category", defaultValue = "", required = false)String category,
			@RequestParam(name="part", defaultValue = "", required = false)String part) {
		
		//쇼핑 리스트에 쓰는 부분
		CategoryMainVO mainVO = shopService.getCategoryMainInfo(category);
		ArrayList<CategorySubVO> CateSubVos = adminService.getCategorySubName(category);
		ArrayList<ProductVO> vosProduct = shopService.getProductShopList(category, part);
		
		// 헤더 메뉴에 쓰는 부분
		ArrayList<CategoryMainVO> vosMain = adminService.getCategoryMainList();
		ArrayList<CategorySubVO> vosSub = adminService.getCategorySubList();
		
		model.addAttribute("vosMain", vosMain);
		model.addAttribute("category", category);
		model.addAttribute("mainVO", mainVO);
		model.addAttribute("vosSub", vosSub);
		model.addAttribute("CateSubVos", CateSubVos);
		model.addAttribute("vosProduct", vosProduct);
		
		return "shop/shopList";
	}

	@RequestMapping(value = "shopDetail", method = RequestMethod.GET)
	public String shopDetailGet(Model model,
			@RequestParam(name="idx", defaultValue = "", required = false)int idx) {
		
		ProductVO productVO = adminService.getProductInfoIdx(idx);
		List<OptionVO> optionVOS = adminService.getOptionList(idx);
		
		// 헤더 메뉴에 쓰는 부분
		ArrayList<CategoryMainVO> vosMain = adminService.getCategoryMainList();
		ArrayList<CategorySubVO> vosSub = adminService.getCategorySubList();
		model.addAttribute("vosMain", vosMain);
		model.addAttribute("vosSub", vosSub);
		
		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVOS", optionVOS);
		return "shop/shopDetail";
	}
}
