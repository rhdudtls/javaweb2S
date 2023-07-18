package com.spring.javaweb2S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb2S.vo.CategoryMainVO;
import com.spring.javaweb2S.vo.ProductVO;

public interface ShopDAO {

	public ArrayList<ProductVO> getProductShopList(@Param("category")String category, @Param("part")String part);

	public CategoryMainVO getCategoryMainInfo(@Param("category")String category);

}
