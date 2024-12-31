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
			String sql = "select * from goods order by goodsid desc";
			PreparedStatement stmt = con.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				GoodsDto goods = new GoodsDto();
				
				goods.setGoodsid(rs.getInt("goodsid"));
				goods.setGoods_name(rs.getString("goods_name"));
				goods.setGoods_price(rs.getInt("goods_price"));
				goods.setGoods_category(rs.getString("goods_category"));
				goods.setGoods_qty(rs.getInt("goods_qty"));
				goods.setGoods_fname_main(rs.getString("goods_fname_main"));
				goods.setGoods_fname_sub(rs.getString("goods_fname_sub"));

				goodsList.add(goods);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
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
			throw new RuntimeException(e);
		} finally {
			closeConnection(con);
		}
		return count;
	}
	
	public void insertGoods(GoodsDto goods) {
		Connection con = null;
		try {
			con = dataSource.getConnection();
			String sql = "insert into goods (goods_name, goods_price, goods_desc, goods_category, "
					+ "goods_qty, goods_fname_main, goods_fname_sub) "
					+ "values(?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, goods.getGoods_name());
			stmt.setInt(2, goods.getGoods_price());
			stmt.setString(3, goods.getGoods_desc());
			stmt.setString(4, goods.getGoods_category());
			stmt.setInt(5, goods.getGoods_qty());
			stmt.setString(6, goods.getGoods_fname_main());
			stmt.setString(7, goods.getGoods_fname_sub());
			
			int rowCount = stmt.executeUpdate();
			if (rowCount <= 0) {
				throw new SQLException("저장된 행이 없습니다.");
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		} finally {
			closeConnection(con);
		}
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
