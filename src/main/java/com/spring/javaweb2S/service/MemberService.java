package com.spring.javaweb2S.service;

import com.spring.javaweb2S.vo.MemberVO;

public interface MemberService {
	
	public MemberVO getMemberDupliCheck(String data, String flag);

	public int setMemberJoin(MemberVO vo);

	public void setMemberLastVisitDate(MemberVO vo);


}
