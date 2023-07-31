package com.spring.javaweb2S.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb2S.dao.MemberDAO;
import com.spring.javaweb2S.vo.CouponVO;
import com.spring.javaweb2S.vo.LikeVO;
import com.spring.javaweb2S.vo.MemberVO;
import com.spring.javaweb2S.vo.OrderVO;
import com.spring.javaweb2S.vo.ProductVO;

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

	@Override
	public void setMemberAutoDelete() {
		memberDAO.setMemberAutoDelete();
	}

	@Override
	public MemberVO getMemberInfo(String mid) {
		return memberDAO.getMemberInfo(mid);
	}

	@Override
	public void setMemberPointUpdate(String mid, int point) {
		memberDAO.setMemberPointUpdate(mid, point);
	}
	
	@Override
	public ArrayList<CouponVO> getCouPonListMine(String mid) {
		return memberDAO.getCouPonListMine(mid);
	}

	@Override
	public int setCouponGet(String mid, String number) {
		return memberDAO.setCouponGet(mid, number);
	}

	@Override
	public CouponVO getCouponInfo(String number) {
		return memberDAO.getCouponInfo(number);
	}

	@Override
	public CouponVO getCouponDupli(String mid, String number) {
		return memberDAO.getCouponDupli(mid, number);
	}

	@Override
	public ArrayList<OrderVO> getMyOrderList(String mid, String startDate, String lastDate, String part) {
		return memberDAO.getMyOrderList(mid, startDate, lastDate, part);
	}

	@Override
	public int setMemberLikeInput(String mid, int idx) {
		return memberDAO.setMemberLikeInput(mid, idx);
	}

	@Override
	public LikeVO getMyLike(String mid, int idx) {
		return memberDAO.getMyLike(mid, idx);
	}

	@Override
	public int setMemberLikeDelete(String mid, int idx) {
		return memberDAO.setMemberLikeDelete(mid, idx);
	}

	@Override
	public ArrayList<ProductVO> getMyLikeList(int startIndexNo, int pageSize, String mid) {
		return memberDAO.getMyLikeList(startIndexNo, pageSize, mid);
	}

}
