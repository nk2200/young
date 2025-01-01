package com.exam.young.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.exam.young.dto.GoodsDto;

public class MainDao {
static DataSource dataSource;	

	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	public List<GoodsDto> getRankedGoods() {
		Connection con = null;
		List<GoodsDto> goodsList = new ArrayList<>();
		try {
			con = dataSource.getConnection();
			
			String sql = "SELECT g.goods_name, g.goods_price, g.goods_fname_main, NVL(SUM(b.buy_qty), 0) AS goods_cnt "
						+"FROM goods g LEFT JOIN buy b ON g.goodsid = b.goodsid "
						+"GROUP BY g.goods_name, g.goods_price,g.goods_fname_main "
						+"ORDER BY goods_cnt DESC";
			
			PreparedStatement stmt = con.prepareStatement(sql);
			
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
                GoodsDto goods = new GoodsDto();
                
                goods.setGoods_name(rs.getString("goods_name"));
                goods.setGoods_price(rs.getInt("goods_price"));
                goods.setGoods_fname_main(rs.getString("goods_fname_main"));
    		
                
                goodsList.add(goods);
			}
							
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			
			throw new RuntimeException(e);
		} finally {
			if (con != null) try { con.close(); } catch (Exception e) {}
		}
		return goodsList;
	}
	
	public List<GoodsDto> searchGoodsByName(String searchName) {
		Connection con = null;
		List<GoodsDto> selectedGoodsList = new ArrayList<>();
		try {
			con = dataSource.getConnection();
			
			String sql = "SELECT GOODS_NAME,GOODS_PRICE,goods_fname_main FROM goods WHERE goods_name LIKE ?";
			
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, "%" + searchName + "%");
			
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
                GoodsDto goods = new GoodsDto();
                
                goods.setGoods_name(rs.getString("GOODS_NAME"));
                goods.setGoods_price(rs.getInt("GOODS_PRICE"));
                goods.setGoods_fname_main(rs.getString("goods_fname_main"));
                
                selectedGoodsList.add(goods);
			}
							
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			
			throw new RuntimeException(e);
		} finally {
			if (con != null) try { con.close(); } catch (Exception e) {}
		}
		return selectedGoodsList;
    }
}
