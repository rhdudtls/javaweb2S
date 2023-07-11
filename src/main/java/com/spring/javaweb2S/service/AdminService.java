package com.spring.javaweb2S.service;

import java.util.ArrayList;

import com.spring.javaweb2S.vo.CategoryMainVO;
import com.spring.javaweb2S.vo.CategorySubVO;
import com.spring.javaweb2S.vo.MemberVO;

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

	public int getCategoryMainDupli(String flag, String[] arr);

	public int setCategoryMainInput(String[] codeArr, String[] nameArr);

	public ArrayList<CategorySubVO> getCategorySubList();

	public int setCategoryDelete(String flag, String code);

}
