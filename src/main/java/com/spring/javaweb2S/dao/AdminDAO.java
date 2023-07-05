package com.spring.javaweb2S.dao;

import java.util.ArrayList;

import com.spring.javaweb2S.vo.MemberVO;

public interface AdminDAO {

	public ArrayList<MemberVO> getMemberList();

	public int setMemberDel(int idx);

	public int setMemberDel();

}
