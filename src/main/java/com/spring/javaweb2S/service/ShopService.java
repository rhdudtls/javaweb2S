package com.spring.javaweb2S.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaweb2S.vo.BaesongVO;
import com.spring.javaweb2S.vo.CartVO;
import com.spring.javaweb2S.vo.CategoryMainVO;
import com.spring.javaweb2S.vo.OrderVO;
import com.spring.javaweb2S.vo.ProductVO;

public interface ShopService {

	public ArrayList<ProductVO> getProductShopList(String category, String part);

	public CategoryMainVO getCategoryMainInfo(String category);

	public CartVO getCartProductOptionSearch(int productIdx, int opIdx, String mid);

	public void setCartProductOptionUpdate(int idx, int opIdx, int totPrice);

	public void setCartProductOptionInput(CartVO vo, int opIdx, int opNum, String opName, int opPrc);

	public List<CartVO> getCartList(String mid);

	public void setCartProductOptionDelete(int[] idxArr, String flag, String mid);

	public void setCartProductOptionNumChange(int idx, int flag);

	public OrderVO getOrderMaxIdx();

	public CartVO getCartProductInfoIdx(int cartIdx);

	public void setOrderInput(OrderVO vo);

	public void setCartDeleteAfterPay(int cartIdx);

	public void setBaesongInput(BaesongVO baesongVO);

	public ArrayList<ProductVO> getProductSearch(String keyword, String searchCategory);

	public ArrayList<ProductVO> getNewProductList();

}
