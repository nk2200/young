package com.exam.young.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

//주문내역 dto 추가,yhl
@Data @AllArgsConstructor @NoArgsConstructor
public class OrderDto {
	private int goodsid;
	private String goods_fname_main;
	private Date buy_date;
	private String goods_name;
	private int buy_qty;
	private int total_price;
}
