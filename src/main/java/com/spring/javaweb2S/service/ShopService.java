package com.spring.javaweb2S.service;

import java.util.ArrayList;

import com.spring.javaweb2S.vo.CategoryMainVO;
import com.spring.javaweb2S.vo.ProductVO;

public interface ShopService {

	public ArrayList<ProductVO> getProductShopList(String category, String part);

	public CategoryMainVO getCategoryMainInfo(String category);

}
