package com.spring.javaweb2S.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb2S.vo.CategoryMainVO;
import com.spring.javaweb2S.vo.CategorySubVO;
import com.spring.javaweb2S.vo.CouponVO;
import com.spring.javaweb2S.vo.MemberVO;
import com.spring.javaweb2S.vo.OptionVO;
import com.spring.javaweb2S.vo.ProductVO;

public interface AdminDAO {

	public ArrayList<MemberVO> getMemberList();

	public int setMemberDel(@Param("idx")int idx);

	public int setMemberDel();

	public ArrayList<MemberVO> getMemberList(@Param("searchType")String searchType, @Param("searchString")String searchString);

	public int setLevelUpdate(@Param("idx")int idx, @Param("level")int level);

	public int setPointUpdate(@Param("idx")int idx, @Param("point")int point);

	public MemberVO getMemberInfo(@Param("idx")int idx);

	public ArrayList<CategoryMainVO> getCategoryMainList();

	public int setCategoryMainUpdate(@Param("code")String code, @Param("name")String name);
	
	public CategoryMainVO getCategoryMainInfo(@Param("name")String name);

	public int getCategoryDupli(@Param("db")String db, @Param("flag")String flag, @Param("arr")String[] arr);

	public int setCategoryMainInput(@Param("list")List<Map<String, String>> list);

	public ArrayList<CategorySubVO> getCategorySubList();

	public int setCategoryDelete(@Param("flag")String flag, @Param("code")String code);

	public int getCategorySubDupli(@Param("flag")String flag, @Param("sub")String sub);

	public int setCategorySubUpdate(@Param("mName")String mName, @Param("sCode")String sCode, @Param("sName")String sName, @Param("originSCode")String originSCode);

	public int setCategorySubInput(@Param("list")List<Map<String, String>> list);

	public ArrayList<CategorySubVO> getCategorySubName(@Param("mainCode")String mainCode);

	public ProductVO getProductMaxIdx();

	public void setProductInput(@Param("vo")ProductVO vo);

	public ProductVO getProductInfo(@Param("productName")String productName);

	public ArrayList<ProductVO> getMainName();

	public ArrayList<ProductVO> getProductList(@Param("part")String part);

	public List<ProductVO> getCategoryProductName(@Param("categoryMainCode")String categoryMainCode, @Param("categorySubCode")String categorySubCode);

	public ProductVO getProductInfor(@Param("productName")String productName);

	public List<OptionVO> getOptionList(@Param("productIdx")int productIdx);

	public void setOptionDelete(@Param("idx")int idx);

	public int getOptionDupli(@Param("productIdx")int productIdx, @Param("optionName")String[] optionName);

	public void setOptionInput(@Param("vo")OptionVO vo);

	public ProductVO getProductInfoIdx(@Param("idx")int idx);

	public void setProductUpdate(@Param("vo")ProductVO vo, @Param("idx")int idx);

	public void setProductDelete(@Param("idx")int idx);

	public void setProductCategoryUpdate(@Param("mName")String mName, @Param("originSCode")String originSCode, @Param("pCode")String pCode);

	public ArrayList<CouponVO> getCouponList(@Param("startIndexNo")int startIndexNo, @Param("pageSize")int pageSize);

	public int setCouponInput(@Param("couponVO")CouponVO couponVO);

	public ArrayList<CouponVO> getCouponDupli(@Param("number")String number, @Param("name")String name);

	public int setCouponDelete(@Param("number")String number);

	public int totRecCnt();

	public ArrayList<CouponVO> getCouponListAll();

	public int setMemberCouponGive(@Param("midArr")String[] midArr, @Param("coupon")int coupon, @Param("date")int date);

}
