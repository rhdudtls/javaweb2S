package com.spring.javaweb2S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb2S.vo.CategoryMainVO;
import com.spring.javaweb2S.vo.MemberVO;

public interface AdminDAO {

	public ArrayList<MemberVO> getMemberList();

	public int setMemberDel(@Param("idx")int idx);

	public int setMemberDel();

	public ArrayList<MemberVO> getMemberList(@Param("searchType")String searchType, @Param("searchString")String searchString);

	public int setLevelUpdate(@Param("idx")int idx, @Param("level")int level);

	public int setPointUpdate(@Param("idx")int idx, @Param("point")int point);

	public MemberVO getMemberInfo(@Param("idx")int idx);

	public ArrayList<CategoryMainVO> getCategoryMainList();

	public int setCategoryMainDelete(@Param("code")String code);

	public int setCategoryMainUpdate(@Param("code")String code, @Param("name")String name);
	
	public CategoryMainVO getCategoryMainInfo(@Param("name")String name);



}
