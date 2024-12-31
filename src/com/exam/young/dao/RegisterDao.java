package com.exam.young.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.exam.young.dto.GoodsDto;

public class RegisterDao {
	static DataSource dataSource;

	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	public List<GoodsDto> getGoodsList() {
		List<GoodsDto> goodsList = new ArrayList<>();
		Connection con = null;
		try {
			con = dataSource.getConnection();
			String sql = "select goodsid, goods_name, goods_price, goods_desc, goods_likes, goods_category, goods_qty, "
					+ "goods_regidate, goods_filename from goods";
			PreparedStatement stmt = con.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				int goodsId = rs.getInt("goodsid");
				String goods_name = rs.getString("goods_name");
				int goods_price = rs.getInt("goods_price");
				String goods_desc = rs.getString("goods_desc");
				int goods_likes = rs.getInt("goods_likes");
				String goods_category = rs.getString("goods_category");
				int goods_qty = rs.getInt("goods_qty");
				Date goods_regidate = rs.getDate("goods_regidate");
				String goods_filename = rs.getString("goods_filename");

				GoodsDto goods = new GoodsDto(goodsId, goods_name, goods_price, goods_desc, goods_likes, goods_category,
						goods_qty, goods_regidate, goods_filename);
				goodsList.add(goods);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e.getMessage());
		} finally {
			closeConnection(con);
		}
		return goodsList;
	}
	
	public int getCount() {
		int count = 0;
		Connection con = null;
		try {
			con = dataSource.getConnection();
			String sql = "select count(*) from goods";
			PreparedStatement stmt = con.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e.getMessage());
		} finally {
			closeConnection(con);
		}
		return count;
	}


	private void closeConnection(Connection con) {
		if (con != null) {
			try {
				con.close();
			} catch (Exception e) {
			}
		}
	}
}
