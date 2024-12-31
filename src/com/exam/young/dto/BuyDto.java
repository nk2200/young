package com.exam.young.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor
public class BuyDto {
	private int buyid;
	private int buy_status;
	private Date buy_date;
	private String customerid;
	private int goodsid;
	private int total_price;
	private int buy_qty;
}
