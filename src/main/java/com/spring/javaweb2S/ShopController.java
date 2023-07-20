package com.spring.javaweb2S;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb2S.service.AdminService;
import com.spring.javaweb2S.service.MemberService;
import com.spring.javaweb2S.service.ShopService;
import com.spring.javaweb2S.vo.CartVO;
import com.spring.javaweb2S.vo.CategoryMainVO;
import com.spring.javaweb2S.vo.CategorySubVO;
import com.spring.javaweb2S.vo.MemberVO;
import com.spring.javaweb2S.vo.OptionVO;
import com.spring.javaweb2S.vo.ProductVO;

@Controller
@RequestMapping("/shop")
public class ShopController {
	
	@Autowired
	ShopService shopService;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
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
	
	@RequestMapping(value = "/shopCart", method = RequestMethod.GET)
	public String shopCartGet(Model model, HttpSession session) {
		String mid = (String)session.getAttribute("sMid");
		List<CartVO> vosCart = shopService.getCartList(mid);
		model.addAttribute("vosCart", vosCart);
		
		//헤더 메뉴
		ArrayList<CategoryMainVO> vosMain = adminService.getCategoryMainList();
		ArrayList<CategorySubVO> vosSub = adminService.getCategorySubList();
		model.addAttribute("vosMain", vosMain);
		model.addAttribute("vosSub", vosSub);
		
		return "shop/shopCart";
	}
	
	@ResponseBody
	@RequestMapping(value = "/cartDelete", method = RequestMethod.POST)
	public String cartDeletePost(HttpSession session, int[] idxArr, 
			@RequestParam(name="flag", defaultValue = "", required = false)String flag) {
		String mid = (String)session.getAttribute("sMid");

		shopService.setCartProductOptionDelete(idxArr, flag, mid);
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/cartNumChange", method = RequestMethod.POST)
	public String cartNumChangePost(
			@RequestParam(name="idx", defaultValue = "", required = false)int idx,
			@RequestParam(name="flag", defaultValue = "", required = false)int flag) {
		
		shopService.setCartProductOptionNumChange(idx, flag);
		
		return "";
	}
	
	@RequestMapping(value = "/shopDetail", method = RequestMethod.POST)
	public String shopDetailPost(CartVO vo, HttpSession session, String flag, int[] optionIdx, int[] optionNum, String[] optionName, int[] optionPrice) {
		int totPrice;
		String mid = (String)session.getAttribute("sMid");
		
		for(int i=0; i < optionIdx.length; i++) {
			int opIdx = optionIdx[i];
			int opNum = optionNum[i];
			int opPrc = optionPrice[i];
			String opName = optionName[i];
			CartVO resVo = shopService.getCartProductOptionSearch(vo.getProductIdx(), opIdx, mid);
			if(resVo != null) {		// 기존에 구매한적이 있었다면 '현재 구매한 내역'과 '기존 장바구니의 수량'을 합쳐서 'Update'시켜줘야한다.
				totPrice = (resVo.getProductPrice() + resVo.getOptionPrice()) * ( resVo.getOptionNum()+ opNum);
				shopService.setCartProductOptionUpdate(resVo.getIdx(), opNum, totPrice);
			}
			else {
				vo.setTotalPrice((vo.getProductPrice() + opPrc) * opNum);
				shopService.setCartProductOptionInput(vo, opIdx, opNum, opName, opPrc);
			}
		}
		
		if(flag.equals("goShop")) {
			return "redirect:/shop/shopDetail?idx="+vo.getProductIdx();
		}
		else if(flag.equals("goCart")) {
			return "redirect:/shop/shopCart";
		}
		return "shop/shopBasket"; //여기 수정해라
	}
	
	@RequestMapping(value = "/shopOrder", method = RequestMethod.GET)
	public String shopOrderGet(HttpSession session, Model model) {
		String mid = (String)session.getAttribute("sMid");
		MemberVO mvo = memberService.getMemberInfo(mid);
		model.addAttribute("mvo", mvo);
		
		List<CartVO> vosCart = shopService.getCartList(mid);
		model.addAttribute("vosCart", vosCart);
		
		//헤더 메뉴
		ArrayList<CategoryMainVO> vosMain = adminService.getCategoryMainList();
		ArrayList<CategorySubVO> vosSub = adminService.getCategorySubList();
		model.addAttribute("vosMain", vosMain);
		model.addAttribute("vosSub", vosSub);
				
		return "shop/shopOrder";
	}
	
}
