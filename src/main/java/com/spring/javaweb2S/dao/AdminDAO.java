package com.spring.javaweb2S.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb2S.vo.CategoryMainVO;
import com.spring.javaweb2S.vo.CategorySubVO;
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

	public int setCategoryMainUpdate(@Param("code")String code, @Param("name")String name);
	
	public CategoryMainVO getCategoryMainInfo(@Param("name")String name);

	public int getCategoryMainDupli(@Param("flag")String flag, @Param("arr")String[] arr);

	public int setCategoryMainInput(@Param("list")List<Map<String, String>> list);

	public ArrayList<CategorySubVO> getCategorySubList();

	public int setCategoryDelete(@Param("flag")String flag, @Param("code")String code);

}
