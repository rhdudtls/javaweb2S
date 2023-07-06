package com.spring.javaweb2S.service;

import java.util.ArrayList;

import com.spring.javaweb2S.vo.MemberVO;

public interface AdminService {

	public ArrayList<MemberVO> getMemberList();

	public int setMemberDel();
	
	public int setMemberDel(int idx);

	public ArrayList<MemberVO> getMemberList(String searchType, String searchString);

	public int setLevelUpdate(int idx, int level);

	public int setPointUpdate(int idx, int point);


}
