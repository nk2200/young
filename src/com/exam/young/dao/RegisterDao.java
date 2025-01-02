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
import com.exam.young.dto.SearchDto;

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

	public List<GoodsDto> getGoodsList(int pageNumber, int pageSize) {
		List<GoodsDto> goodsList = new ArrayList<>();
		Connection con = null;
		try {
			con = dataSource.getConnection();
			String sql = "SELECT goodsid, goods_name, goods_price, goods_desc, goods_category, goods_qty, goods_fname_main " + 
					"FROM (SELECT g.*, ROW_NUMBER() OVER (ORDER BY g.goodsid desc) AS rn FROM goods g) " + 
					"WHERE rn BETWEEN ? AND ?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setInt(1, getStartRow(pageNumber, pageSize));
			stmt.setInt(2, getEndRow(pageNumber, pageSize));
			
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				GoodsDto goods = new GoodsDto();
				
				goods.setGoodsid(rs.getInt("goodsid"));
				goods.setGoods_name(rs.getString("goods_name"));
				goods.setGoods_price(rs.getInt("goods_price"));
				goods.setGoods_category(rs.getString("goods_category"));
				goods.setGoods_qty(rs.getInt("goods_qty"));
				goods.setGoods_fname_main(rs.getString("goods_fname_main"));

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
	
	public GoodsDto getOneGoods(int goodsid) {
		GoodsDto goods = new GoodsDto();
		Connection con = null;
		try {
			con = dataSource.getConnection();
			String sql = "select * from goods where goodsid = ?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setInt(1, goodsid);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				goods.setGoods_name(rs.getString("goods_name"));
				goods.setGoods_price(rs.getInt("goods_price"));
				goods.setGoods_category(rs.getString("goods_category"));
				goods.setGoods_qty(rs.getInt("goods_qty"));
				goods.setGoods_desc(rs.getString("goods_desc"));
				goods.setGoods_fname_main(rs.getString("goods_fname_main"));
				goods.setGoods_fname_sub(rs.getString("goods_fname_sub"));
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		} finally {
			closeConnection(con);
		}
		return goods;
	}
	
	public List<GoodsDto> searchGoods(SearchDto search) {
		List<GoodsDto> goodsList = new ArrayList<>();
		Connection con = null;
		try {
			con = dataSource.getConnection();
			String sql = "SELECT goodsid, goods_name, goods_price, goods_desc, goods_category, goods_qty, goods_fname_main " + 
					"FROM (SELECT g.*, ROW_NUMBER() OVER (ORDER BY g.goodsid desc) AS rn FROM goods g where ";

	        // 조건 추가
	        if ("name".equals(search.getType())) {
	            sql += "goods_name like ?)";
	        } else if ("category".equals(search.getType())) {
	        	sql += "goods_category like ?)";
			}
	        sql += " WHERE rn BETWEEN ? AND ?";
	        
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, "%" + search.getKeyword() + "%");
			stmt.setInt(2, getStartRow(search.getPageNumber(), search.getPageSize()));
			stmt.setInt(3, getEndRow(search.getPageNumber(), search.getPageSize()));
			
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				GoodsDto goods = new GoodsDto();
				
				goods.setGoodsid(rs.getInt("goodsid"));
				goods.setGoods_name(rs.getString("goods_name"));
				goods.setGoods_price(rs.getInt("goods_price"));
				goods.setGoods_category(rs.getString("goods_category"));
				goods.setGoods_qty(rs.getInt("goods_qty"));
				goods.setGoods_fname_main(rs.getString("goods_fname_main"));

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
	
	public int getCount(String goodsName, String category) {
		int count = 0;
		Connection con = null;
		try {
			con = dataSource.getConnection();
			String sql = "select count(*) from goods";
			boolean hasCondition = false;

	        // 조건 추가
	        if (!isNameEmpty(goodsName) || !isCategoryEmpty(category)) {
	            sql += " where";
	        }
	        if (!isNameEmpty(goodsName)) {
	            sql += " goods_name like ?";
	            hasCondition = true;
	        }
	        if (!isCategoryEmpty(category)) {
	            if (hasCondition) {
	                sql += " and";
	            }
	            sql += " goods_category = ?";
	        }
	        
			PreparedStatement stmt = con.prepareStatement(sql);
			int parameterIndex = 1;
	        if (!isNameEmpty(goodsName)) {
	            stmt.setString(parameterIndex++, "%" + goodsName + "%");
	        }
	        if (!isCategoryEmpty(category)) {
	            stmt.setString(parameterIndex++, category);
	        }
	        
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
	
	private boolean isNameEmpty(String goodsName) {
	    return goodsName == null || goodsName.trim().isEmpty();
	}
	
	private boolean isCategoryEmpty(String category) {
		return category == null || category.isEmpty();
	}
	
	private int getStartRow(int pageNumber, int pageSize) {
		return (pageNumber - 1) * pageSize + 1;
	}
	
	private int getEndRow(int pageNumber, int pageSize) {
		return pageNumber * pageSize;
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

	public void updateGoods(GoodsDto goods) {
		Connection con = null;
		try {
			con = dataSource.getConnection();
			String sql = "update goods set goods_name=?, goods_price=?, goods_category=?, goods_qty=?, "
					   + "goods_desc=?, goods_fname_main=?, goods_fname_sub=? "
					   + "where goodsid=?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, goods.getGoods_name());
			stmt.setInt(2, goods.getGoods_price());
			stmt.setString(3, goods.getGoods_category());
			stmt.setInt(4, goods.getGoods_qty());
			stmt.setString(5, goods.getGoods_desc());
			stmt.setString(6, goods.getGoods_fname_main());
			stmt.setString(7, goods.getGoods_fname_sub());
			stmt.setInt(8, goods.getGoodsid());
			
			int rowCount = stmt.executeUpdate();
			if (rowCount <= 0) {
				throw new RuntimeException("변경된 행이 없습니다.");
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		} finally {
			closeConnection(con);
		}
	}
	
	public void deleteGoods(int goodsid) {
		Connection con = null;
		try {
			con = dataSource.getConnection();
			String sql = "delete from goods where goodsid=?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setInt(1, goodsid);
			
			int rowCount = stmt.executeUpdate();
			if (rowCount <= 0) {
				throw new RuntimeException("상품이 존재하지 않습니다.");
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
