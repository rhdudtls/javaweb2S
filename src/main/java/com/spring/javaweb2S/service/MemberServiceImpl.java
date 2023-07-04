package com.spring.javaweb2S.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb2S.dao.MemberDAO;
import com.spring.javaweb2S.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDAO memberDAO;

	@Override
	public MemberVO getMemberDupliCheck(String data, String flag) {
		return memberDAO.getMemberDupliCheck(data, flag);
	}

	@Override
	public int setMemberJoin(MemberVO vo) {
		return memberDAO.setMemberJoin(vo);
	}

	@Override
	public void setMemberLastVisitDate(MemberVO vo) {
		memberDAO.setMemberLastVisitDate(vo);
	}

}
