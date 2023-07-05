package com.spring.javaweb2S.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb2S.dao.AdminDAO;
import com.spring.javaweb2S.vo.MemberVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDAO adminDAO;

	@Override
	public ArrayList<MemberVO> getMemberList() {
		return adminDAO.getMemberList();
	}

	@Override
	public int setMemberDel(int idx) {
		return adminDAO.setMemberDel(idx);
	}

	@Override
	public int setMemberDel() {
		return adminDAO.setMemberDel();
	}
}
