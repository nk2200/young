package com.exam.young.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor
public class GoodsDto {
    private int goodsid;
    private String goods_name;
    private int goods_price;
    private String goods_desc;
    private int goods_likes;
    private String goods_category;
    private int goods_qty;
    private Date goods_regidate;
    private String goods_filename;
}
