package com.spring.javaweb2S.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb2S.dao.ShopDAO;
import com.spring.javaweb2S.vo.CartVO;
import com.spring.javaweb2S.vo.CategoryMainVO;
import com.spring.javaweb2S.vo.OptionVO;
import com.spring.javaweb2S.vo.ProductVO;

@Service
public class ShopServiceImpl implements ShopService {
	
	@Autowired
	ShopDAO shopDAO;

	@Override
	public ArrayList<ProductVO> getProductShopList(String category, String part) {
		return shopDAO.getProductShopList(category, part);
	}

	@Override
	public CategoryMainVO getCategoryMainInfo(String category) {
		return shopDAO.getCategoryMainInfo(category);
	}

	@Override
	public CartVO getCartProductOptionSearch(int productIdx, int opIdx, String mid) {
		return shopDAO.getCartProductOptionSearch(productIdx, opIdx, mid);
	}

	@Override
	public void setCartProductOptionUpdate(int idx, int opNum, int totPrice) {
		shopDAO.setCartProductOptionUpdate(idx, opNum, totPrice);
	}

	@Override
	public void setCartProductOptionInput(CartVO vo, int opIdx, int opNum, String opName, int opPrc) {
		shopDAO.setCartProductOptionInput(vo, opIdx, opNum, opName, opPrc);
	}

	@Override
	public List<CartVO> getCartList(String mid) {
		return shopDAO.getCartList(mid);
	}

	@Override
	public void setCartProductOptionDelete(int[] idxArr) {
		shopDAO.setCartProductOptionDelete(idxArr);
		
	}


}
