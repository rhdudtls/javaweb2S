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
import com.spring.javaweb2S.vo.ProductVO;

@Controller
public class HomeController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	ShopService shopService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		ArrayList<ProductVO> vosProduct = shopService.getNewProductList();
		model.addAttribute("vosProduct", vosProduct);
		
		ArrayList<CategoryMainVO> vosMain = adminService.getCategoryMainList();
		ArrayList<CategorySubVO> vosSub = adminService.getCategorySubList();
		
		model.addAttribute("vosMain", vosMain);
		model.addAttribute("vosSub", vosSub);
		
		return "home";
	}
	
}
