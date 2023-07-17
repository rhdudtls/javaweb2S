package com.spring.javaweb2S;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaweb2S.service.AdminService;
import com.spring.javaweb2S.service.ShopService;
import com.spring.javaweb2S.vo.CategoryMainVO;
import com.spring.javaweb2S.vo.CategorySubVO;

@Controller
@RequestMapping("/shop")
public class ShopController {
	
	@Autowired
	ShopService shopService;
	
	@Autowired
	AdminService adminService;
	
	@RequestMapping(value = "/shopList", method = RequestMethod.GET)
	public String shopListGet(Model model) {
		
		ArrayList<CategoryMainVO> vosMain = adminService.getCategoryMainList();
		ArrayList<CategorySubVO> vosSub = adminService.getCategorySubList();
		
		model.addAttribute("vosMain", vosMain);
		model.addAttribute("vosSub", vosSub);
		
		return "shop/shopList";
	}

}
