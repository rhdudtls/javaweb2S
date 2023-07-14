package com.spring.javaweb2S.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb2S.vo.CategoryMainVO;
import com.spring.javaweb2S.vo.CategorySubVO;
import com.spring.javaweb2S.vo.MemberVO;
import com.spring.javaweb2S.vo.OptionVO;
import com.spring.javaweb2S.vo.ProductVO;

public interface AdminService {

	public ArrayList<MemberVO> getMemberList();

	public int setMemberDel();
	
	public int setMemberDel(int idx);

	public ArrayList<MemberVO> getMemberList(String searchType, String searchString);

	public int setLevelUpdate(int idx, int level);

	public int setPointUpdate(int idx, int point);

	public MemberVO getMemberInfo(int idx);

	public ArrayList<CategoryMainVO> getCategoryMainList();

	public int setCategoryMainUpdate(String code, String name);

	public CategoryMainVO getCategoryMainInfo(String name);

	public int getCategoryDupli(String db, String flag, String[] arr);

	public int setCategoryMainInput(String[] codeArr, String[] nameArr);

	public ArrayList<CategorySubVO> getCategorySubList();

	public int setCategoryDelete(String flag, String code);

	public int getCategorySubDupli(String string, String sub);

	public int setCategorySubUpdate(String mName, String sCode, String sName, String originSCode);

	public int setCategorySubInput(String[] sCodeArr, String[] sNameArr, String[] mCodeArr);

	public ArrayList<CategorySubVO> getCategorySubName(String mainCode);

	public void imgCheckProductInput(MultipartFile file, ProductVO vo);

	public ProductVO getProductInfo(String productName);

	public ArrayList<ProductVO> getMainName();

	public ArrayList<ProductVO> getProductList(String part);

	public List<ProductVO> getCategoryProductName(String categoryMainCode, String categorySubCode);

	public ProductVO getProductInfor(String productName);

	public List<OptionVO> getOptionList(int productIdx);

	public void setOptionDelete(int idx);

	public int getOptionDupli(int productIdx, String[] optionName);

	public void setOptionInput(OptionVO vo);

	public ProductVO getProductInfoIdx(int idx);


}
