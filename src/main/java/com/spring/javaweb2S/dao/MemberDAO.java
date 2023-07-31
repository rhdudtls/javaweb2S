package com.spring.javaweb2S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb2S.vo.CouponVO;
import com.spring.javaweb2S.vo.LikeVO;
import com.spring.javaweb2S.vo.MemberVO;
import com.spring.javaweb2S.vo.OrderVO;
import com.spring.javaweb2S.vo.ProductVO;

public interface MemberDAO {
	
	public MemberVO getMemberDupliCheck(@Param("data")String data, @Param("flag")String flag);

	public int setMemberJoin(@Param("vo")MemberVO vo);

	public void setMemberLastVisitDate(@Param("vo")MemberVO vo);

	public void setMemberAutoDelete();

	public MemberVO getMemberInfo(@Param("mid")String mid);

	public void setMemberPointUpdate(@Param("mid")String mid, @Param("point")int point);

	public ArrayList<CouponVO> getCouPonListMine(@Param("mid")String mid);

	public int setCouponGet(@Param("mid")String mid, @Param("number")String number);

	public CouponVO getCouponInfo(@Param("number")String number);

	public CouponVO getCouponDupli(@Param("mid")String mid, @Param("number")String number);

	public ArrayList<OrderVO> getMyOrderList(@Param("mid")String mid, @Param("startDate")String startDate, @Param("lastDate")String lastDate, @Param("part")String part);

	public int setMemberLikeInput(@Param("mid")String mid, @Param("idx")int idx);

	public LikeVO getMyLike(@Param("mid")String mid, @Param("idx")int idx);

	public int setMemberLikeDelete(@Param("mid")String mid, @Param("idx")int idx);

	public ArrayList<ProductVO> getMyLikeList(@Param("startIndexNo")int startIndexNo, @Param("pageSize")int pageSize, @Param("mid")String mid);

	public int totRecCntLike(@Param("mid")String mid);

}
