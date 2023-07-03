package com.spring.javaweb2S.vo;

import lombok.Data;

@Data
public class MemberVO {
	private int idx;
	private String mid;
	private String pwd;
	private String name;
	private String nickName;
	private String tel;
	private String email;
	private String gender;
	private String birthday;
	private String address;
	private int level;
	private String memberDel;
	private String lastVisitDate;
	private int point;
	private String snsCheck;
}
