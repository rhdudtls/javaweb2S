package com.spring.javaweb2S;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import com.spring.javaweb2S.vo.BaesongVO;
import com.spring.javaweb2S.vo.CartVO;
import com.spring.javaweb2S.vo.CategoryMainVO;
import com.spring.javaweb2S.vo.CategorySubVO;
import com.spring.javaweb2S.vo.LikeVO;
import com.spring.javaweb2S.vo.MemberVO;
import com.spring.javaweb2S.vo.OptionVO;
import com.spring.javaweb2S.vo.OrderVO;
import com.spring.javaweb2S.vo.PaymentVO;
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
	public String shopDetailGet(Model model, HttpSession session,
			@RequestParam(name="idx", defaultValue = "", required = false)int idx) {
		String mid = (String)session.getAttribute("sMid");
		
		LikeVO likeVO = memberService.getMyLike(mid, idx);
		if(likeVO == null) model.addAttribute("like", "no");
		else model.addAttribute("like", "yes");
		
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
	public String shopOrderGet(Model model, HttpSession session) {
		String mid = (String)session.getAttribute("sMid");
		@SuppressWarnings("unchecked")
		ArrayList<OrderVO> orderVOS = (ArrayList<OrderVO>)session.getAttribute("sOrderVOS");
		session.setAttribute("sOrderVOS", orderVOS);
		
		MemberVO memberVO = memberService.getMemberInfo(mid);
		String[] address = memberVO.getAddress().split("/");
		String[] tel = memberVO.getTel().split("-");
		String[] email = memberVO.getEmail().split("@");
	    model.addAttribute("memberVO", memberVO);
	    model.addAttribute("postcode", address[0]);
	    model.addAttribute("roadAddress", address[1]);
	    model.addAttribute("detailAddress", address[2]);
	    model.addAttribute("extraAddress", address[3]);
	    model.addAttribute("tel1", tel[0]);
	    model.addAttribute("tel2", tel[1]);
	    model.addAttribute("tel3", tel[2]);
	    model.addAttribute("email1", email[0]);
	    model.addAttribute("email2", email[1]);
	    
		//헤더 메뉴
		ArrayList<CategoryMainVO> vosMain = adminService.getCategoryMainList();
		ArrayList<CategorySubVO> vosSub = adminService.getCategorySubList();
		model.addAttribute("vosMain", vosMain);
		model.addAttribute("vosSub", vosSub);
				
		return "shop/shopOrder";
	}
	
	@RequestMapping(value = "/shopCart", method = RequestMethod.POST)
	public String shopCartPost(int[] buyIdx,HttpServletRequest request, Model model, HttpSession session) {
		String mid = (String)session.getAttribute("sMid");
		// 주문한 상품에 대하여 '고유번호'를 만들어준다.
		// 고유주문번호(idx) = 기존에 존재하는 주문테이블의 고유번호 + 1
		OrderVO maxIdx = shopService.getOrderMaxIdx();
		int idx = 1;
		if(maxIdx != null) idx = maxIdx.getMaxIdx() + 1;
		  
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String orderIdx = sdf.format(today) + idx;
		        
		CartVO cartVo = new CartVO();
		ArrayList<OrderVO> orderVOS = new ArrayList<OrderVO>();
		
		for(int cartIdx : buyIdx) {
	         cartVo = shopService.getCartProductInfoIdx(cartIdx);
	         OrderVO orderVo = new OrderVO();
	         orderVo.setProductIdx(cartVo.getProductIdx());
	         orderVo.setProductName(cartVo.getProductName());
	         orderVo.setProductPrice(cartVo.getProductPrice());
	         orderVo.setThumbImg(cartVo.getThumbImg());
	         orderVo.setOptionName(cartVo.getOptionName());
	         orderVo.setOptionPrice(cartVo.getOptionPrice()+"");
	         orderVo.setOptionNum(cartVo.getOptionNum()+"");
	         orderVo.setTotalPrice(cartVo.getTotalPrice());
	         orderVo.setCartIdx(cartVo.getIdx());
	         orderVo.setPrice(cartVo.getProductPrice() + cartVo.getOptionPrice());
	         
	         orderVo.setOrderIdx(orderIdx);   // 관리자가 만들어준 '주문고유번호'를 저장
	         orderVo.setMid(mid);                  // 로그인한 아이디를 저장한다.
	         
	         orderVOS.add(orderVo);
		}
	    session.setAttribute("sOrderVOS", orderVOS);
	      
	    return "redirect:/shop/shopOrder";
	}
	@RequestMapping(value="/payment", method=RequestMethod.POST)
	public String paymentGet(PaymentVO paymentVO, BaesongVO baesongVO, HttpSession session, Model model) {
		@SuppressWarnings("unchecked")
		ArrayList<OrderVO> orderVOS = (ArrayList<OrderVO>)session.getAttribute("sOrderVOS");
		paymentVO.setAmount(10);
		if(orderVOS.size() == 1) {
			paymentVO.setName(orderVOS.get(0).getProductName());
		}
		else paymentVO.setName(orderVOS.get(0).getProductName() + "외 " + (orderVOS.size()-1) + "종");
		model.addAttribute("paymentVO", paymentVO);
		
		session.setAttribute("sPaymentVO", paymentVO);
		session.setAttribute("sBaesongVO", baesongVO);
		
		return "shop/paymentOk";
	}
	
	@RequestMapping(value="/paymentResult", method=RequestMethod.GET)
	public String paymentResult(HttpSession session, PaymentVO receivePaymentVO, Model model) {
		@SuppressWarnings("unchecked")
		List<OrderVO> orderVOS = (List<OrderVO>) session.getAttribute("sOrderVOS");
		PaymentVO paymentVO = (PaymentVO) session.getAttribute("sPaymentVO");
		BaesongVO baesongVO = (BaesongVO) session.getAttribute("sBaesongVO");
		
		session.removeAttribute("sBaesongVO");
		
		for(OrderVO vo : orderVOS) {
			vo.setIdx(Integer.parseInt(vo.getOrderIdx().substring(8)));
			shopService.setOrderInput(vo);                 	// 주문내용을 주문테이블(dbOrder)에 저장.
			//shopService.setCartDeleteAfterPay(vo.getCartIdx()); // 주문이 완료되었기에 장바구니(dbCart)테이블에서 주문한 내역을 삭체처리한다.
		}
		
		baesongVO.setOIdx(orderVOS.get(0).getIdx());
		baesongVO.setOrderIdx(orderVOS.get(0).getOrderIdx());
		baesongVO.setAddress(paymentVO.getBuyer_addr());
		baesongVO.setTel(paymentVO.getBuyer_tel());
		baesongVO.setOrderTotalPrice(baesongVO.getOrderTotalPrice()-paymentVO.getPoint());
		
		shopService.setBaesongInput(baesongVO);  // 배송내용을 배송테이블(dbBaesong)에 저장
		
		paymentVO.setImp_uid(receivePaymentVO.getImp_uid());
		paymentVO.setMerchant_uid(receivePaymentVO.getMerchant_uid());
		paymentVO.setPaid_amount(receivePaymentVO.getPaid_amount());
		paymentVO.setApply_num(receivePaymentVO.getApply_num());
		
		if(paymentVO.getPoint() != 0) {
			memberService.setMemberPointUpdate(baesongVO.getMid(), paymentVO.getPoint());
		}
		
		session.setAttribute("sPayMentVO", paymentVO);
		session.setAttribute("orderTotalPrice", baesongVO.getOrderTotalPrice());
		
		return "redirect:/message/paymentResultOk";
	}
	
	@RequestMapping(value="/paymentResultOk", method=RequestMethod.GET)
	public String paymentResultOkGet(HttpSession session, Model model) {
		@SuppressWarnings("unchecked")
		List<OrderVO> orderVOS = (List<OrderVO>) session.getAttribute("sOrderVOS");
		model.addAttribute("orderVOS", orderVOS);
		session.removeAttribute("sOrderVOS");
		return "shop/paymentResult";
	}
	
	@RequestMapping(value="/shopSearch", method=RequestMethod.GET)
	public String paymentResultOkGet( Model model,
			@RequestParam(name="keyword", defaultValue = "", required = false)String keyword,
			@RequestParam(name="searchCategory", defaultValue = "productName", required = false)String searchCategory,
			@RequestParam(name="keyword2", defaultValue = "", required = false)String keyword2,
			@RequestParam(name="flag", defaultValue = "", required = false)String flag) {
		
		ArrayList<ProductVO> vos = null;
		
		if(flag.equals("header")) {
			vos = shopService.getProductSearch(keyword, searchCategory);
			model.addAttribute("keyword", keyword);
		}
		else {
			vos = shopService.getProductSearch(keyword2, searchCategory);
			model.addAttribute("keyword", keyword2);
		}
		model.addAttribute("vos", vos);
		model.addAttribute("part", searchCategory);
		
		ArrayList<CategoryMainVO> vosMain = adminService.getCategoryMainList();
		ArrayList<CategorySubVO> vosSub = adminService.getCategorySubList();
		model.addAttribute("vosMain", vosMain);
		model.addAttribute("vosSub", vosSub);
		
		return "shop/shopSearch";
	}
}
