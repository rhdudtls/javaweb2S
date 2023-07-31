package com.spring.javaweb2S.vo;

import lombok.Data;

@Data
public class CouponVO {
	private int idx;
	private String number;
	private String name;
	private String type;
	private int price;
	private int ratio;
	private int max_value;
	private int use_min_price;
	private String content;
	
	private String getTime;
	private String deadline;
}
