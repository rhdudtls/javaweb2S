package com.spring.javaweb2S.service;

import java.util.ArrayList;

import com.spring.javaweb2S.vo.CouponVO;
import com.spring.javaweb2S.vo.LikeVO;
import com.spring.javaweb2S.vo.MemberVO;
import com.spring.javaweb2S.vo.OrderVO;
import com.spring.javaweb2S.vo.ProductVO;

public interface MemberService {
	
	public MemberVO getMemberDupliCheck(String data, String flag);

	public int setMemberJoin(MemberVO vo);

	public void setMemberLastVisitDate(MemberVO vo);

	public void setMemberAutoDelete();

	public MemberVO getMemberInfo(String mid);

	public void setMemberPointUpdate(String mid, int point);

	public ArrayList<CouponVO> getCouPonListMine(String mid);

	public int setCouponGet(String mid, String number);

	public CouponVO getCouponInfo(String number);

	public CouponVO getCouponDupli(String mid, String number);

	public ArrayList<OrderVO> getMyOrderList(String mid, String startDate, String lastDate, String part);

	public int setMemberLikeInput(String mid, int idx);
	
	public LikeVO getMyLike(String mid, int idx);

	public int setMemberLikeDelete(String mid, int idx);

	public ArrayList<ProductVO> getMyLikeList(int startIndexNo, int pageSize, String mid);
}
