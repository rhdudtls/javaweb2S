package com.spring.javaweb2S.vo;

import lombok.Data;

@Data
public class OrderVO {
	  private int idx;
	  private String orderIdx;
	  private String mid;
	  private int productIdx;
	  private String orderDate;
	  private String productName;
	  private int productPrice;
	  private String thumbImg;
	  private String optionName;
	  private String optionPrice;
	  private String optionNum;
	  private int totalPrice;
	  
	  private String orderStatus;
	  private int price;
	  private int cartIdx;  // 장바구니 고유번호.
	  private int maxIdx;   // 주문번호를 구하기위한 기존 최대 비밀번호필드
	  private int cnt;
}
