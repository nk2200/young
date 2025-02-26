package com.exam.young.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor
public class CartDto {
	private int cartid;
	private String customerid;
	private int goodsid;
	private int cart_qty;
	private GoodsDto goods;

}