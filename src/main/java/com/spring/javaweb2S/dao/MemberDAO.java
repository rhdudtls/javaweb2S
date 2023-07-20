package com.spring.javaweb2S.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb2S.vo.MemberVO;

public interface MemberDAO {
	
	public MemberVO getMemberDupliCheck(@Param("data")String data, @Param("flag")String flag);

	public int setMemberJoin(@Param("vo")MemberVO vo);

	public void setMemberLastVisitDate(@Param("vo")MemberVO vo);

	public void setMemberAutoDelete();

	public MemberVO getMemberInfo(@Param("mid")String mid);


}
