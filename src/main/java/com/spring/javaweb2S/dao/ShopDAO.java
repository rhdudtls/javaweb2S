package com.spring.javaweb2S.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb2S.vo.CartVO;
import com.spring.javaweb2S.vo.CategoryMainVO;
import com.spring.javaweb2S.vo.ProductVO;

public interface ShopDAO {

	public ArrayList<ProductVO> getProductShopList(@Param("category")String category, @Param("part")String part);

	public CategoryMainVO getCategoryMainInfo(@Param("category")String category);

	public CartVO getCartProductOptionSearch(@Param("productIdx")int productIdx, @Param("opIdx")int opIdx, @Param("mid")String mid);

	public void setCartProductOptionUpdate(@Param("idx")int idx, @Param("opNum")int opNum, @Param("totPrice")int totPrice);

	public void setCartProductOptionInput(@Param("vo")CartVO vo, @Param("opIdx")int opIdx, @Param("opNum")int opNum, @Param("opName")String opName, @Param("opPrc")int opPrc);

	public List<CartVO> getCartList(@Param("mid")String mid);

	public void setCartProductOptionDelete(@Param("idxArr")int[] idxArr);


}
