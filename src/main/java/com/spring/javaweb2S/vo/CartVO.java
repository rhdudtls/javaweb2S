package com.spring.javaweb2S.vo;

import lombok.Data;

@Data
public class CartVO {
	private int idx;
	private String cartDate;
	private String mid;
	private int productIdx;
	private String productName;
	private int productPrice;
	private String thumbImg;
	private int optionIdx;
	private String optionName;
	private int optionPrice;
	private int optionNum;
	private int totalPrice;
}
