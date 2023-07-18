package com.spring.javaweb2S.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb2S.dao.ShopDAO;
import com.spring.javaweb2S.vo.CategoryMainVO;
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
}
