package com.spring.javaweb2S.vo;

import lombok.Data;

@Data
public class ProductVO {
	private int idx;
	private String categoryMainCode;
	private String categorySubCode;
	private String productCode;
	private String productName;
	private int productPrice;
	private String fSName;
	private String content;
	
	
	private String categoryMainName;
	private String categorySubName;
}
