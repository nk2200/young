package com.exam.young.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.exam.young.dto.CartDto;
import com.exam.young.dto.GoodsDto;

public class CategoryDao {
static DataSource dataSource;
	
	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle");
		}catch(NamingException e) {
			
		}
	}
	
	public GoodsDto getCategory(String goodsCategory) {
		GoodsDto goods = new GoodsDto();
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			String sql = "SELECT goodsid, goods_name, goods_price, goods_desc, goods_likes,goods_category,goods_qty,goods_regidate,goods_filename FROM goods WHERE goods_category = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, goodsCategory); // 매개변수 설정

	        ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				goods.setGoodsid(rs.getInt("goodsid"));
				goods.setGoods_name(rs.getString("goods_name"));
				goods.setGoods_price(rs.getInt("goods_price"));
				goods.setGoods_desc(rs.getString("goods_desc"));
				goods.setGoods_likes(rs.getInt("goods_likes"));
				goods.setGoods_category(rs.getString("goods_category"));
				goods.setGoods_qty(rs.getInt("goods_qty"));
				goods.setGoods_regidate(rs.getDate("goods_regidate"));
				goods.setGoods_fname_main(rs.getString("goods_filename"));
				
				
			}else {
				throw new RuntimeException("해당 카테고리에 goods가 없습니다.");
			}	
		}catch(SQLException e) {
			System.out.println(e.getMessage());
		}
		return goods;
	}
	
	public GoodsDto getRankCategory(String goodsCategory) {
		GoodsDto goods = new GoodsDto();
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			String sql = "SELECT goodsid, goods_name, goods_price, goods_desc, goods_likes,goods_category,goods_qty,goods_regidate,goods_fname_main FROM goods WHERE goods_category = ? order by goods_likes desc";
			PreparedStatement pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, goodsCategory); // 매개변수 설정

	        ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				goods.setGoodsid(rs.getInt("goodsid"));
				goods.setGoods_name(rs.getString("goods_name"));
				goods.setGoods_price(rs.getInt("goods_price"));
				goods.setGoods_desc(rs.getString("goods_desc"));
				goods.setGoods_likes(rs.getInt("goods_likes"));
				goods.setGoods_category(rs.getString("goods_category"));
				goods.setGoods_qty(rs.getInt("goods_qty"));
				goods.setGoods_regidate(rs.getDate("goods_regidate"));
				goods.setGoods_fname_main(rs.getString("goods_fname_main"));
				
				
			}else {
				throw new RuntimeException("해당 카테고리에 goods가 없습니다.");
			}	
		}catch(SQLException e) {
			System.out.println(e.getMessage());
		}
		return goods;
	}
}
