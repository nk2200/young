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

public class CategoryDao {
static DataSource dataSource;
	
	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle");
		}catch(NamingException e) {
			
		}
	}
	
	public List<GoodsDto> getCategory(String goodsCategory) {
		
		List<GoodsDto> goodsDetails = new ArrayList<>();
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			String sql = "SELECT goodsid, goods_name, goods_price, goods_desc, goods_likes,goods_category,goods_qty,goods_regidate,goods_fname_main FROM goods WHERE goods_category = ? order by goods_name asc";
			PreparedStatement pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, goodsCategory); // 매개변수 설정

	        ResultSet rs = pstmt.executeQuery();
	       
			while(rs.next()) {
				GoodsDto goods = new GoodsDto();
				goods.setGoodsid(rs.getInt("goodsid"));
				goods.setGoods_name(rs.getString("goods_name"));
				goods.setGoods_price(rs.getInt("goods_price"));
				goods.setGoods_desc(rs.getString("goods_desc"));
				goods.setGoods_likes(rs.getInt("goods_likes"));
				goods.setGoods_category(rs.getString("goods_category"));
				goods.setGoods_qty(rs.getInt("goods_qty"));
				goods.setGoods_regidate(rs.getDate("goods_regidate"));
				goods.setGoods_fname_main(rs.getString("goods_fname_main"));
				
				goodsDetails.add(goods);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			closeConnection(conn);
		}
		return goodsDetails;
	}
	
	public List<GoodsDto> getRankCategory(String goodsCategory) {
		
		Connection conn = null;
		List<GoodsDto> goodsDetails = new ArrayList<>();
		
		try {
			conn = dataSource.getConnection();
			String sql = "SELECT * FROM (" +
		             "    SELECT goodsid, goods_name, goods_price, goods_desc, goods_likes, goods_category, goods_qty, goods_regidate, goods_fname_main, ROWNUM AS rnum " +
		             "    FROM goods " +
		             "    WHERE goods_category = ? " +
		             "    ORDER BY goods_likes DESC" +
		             ") WHERE rnum <= 9";


			PreparedStatement pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, goodsCategory); // 매개변수 설정

	        ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				GoodsDto goods = new GoodsDto();
				goods.setGoodsid(rs.getInt("goodsid"));
				goods.setGoods_name(rs.getString("goods_name"));
				goods.setGoods_price(rs.getInt("goods_price"));
				goods.setGoods_desc(rs.getString("goods_desc"));
				goods.setGoods_likes(rs.getInt("goods_likes"));
				goods.setGoods_category(rs.getString("goods_category"));
				goods.setGoods_qty(rs.getInt("goods_qty"));
				goods.setGoods_regidate(rs.getDate("goods_regidate"));
				goods.setGoods_fname_main(rs.getString("goods_fname_main"));
				
				goodsDetails.add(goods);
			}
			
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			closeConnection(conn);
		}
		return goodsDetails;
	}
	
	public List<GoodsDto> getRankCategory_20(String goodsCategory) {
		
		Connection conn = null;
		List<GoodsDto> goodsDetails = new ArrayList<>();
		
		try {
			conn = dataSource.getConnection();
			String sql = "SELECT * FROM (" +
		             "    SELECT goodsid, goods_name, goods_price, goods_desc, goods_likes, goods_category, goods_qty, goods_regidate, goods_fname_main, ROWNUM AS rnum " +
		             "    FROM goods " +
		             "    WHERE goods_category = ? " +
		             "    ORDER BY goods_likes DESC" +
		             ") WHERE rnum <= 20";


			PreparedStatement pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, goodsCategory); // 매개변수 설정

	        ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				GoodsDto goods = new GoodsDto();
				goods.setGoodsid(rs.getInt("goodsid"));
				goods.setGoods_name(rs.getString("goods_name"));
				goods.setGoods_price(rs.getInt("goods_price"));
				goods.setGoods_desc(rs.getString("goods_desc"));
				goods.setGoods_likes(rs.getInt("goods_likes"));
				goods.setGoods_category(rs.getString("goods_category"));
				goods.setGoods_qty(rs.getInt("goods_qty"));
				goods.setGoods_regidate(rs.getDate("goods_regidate"));
				goods.setGoods_fname_main(rs.getString("goods_fname_main"));
				
				goodsDetails.add(goods);
			}
			
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			closeConnection(conn);
		}
		return goodsDetails;
	}
	
public List<GoodsDto> getRankAll_20(String goodsCategory) {
		
		Connection conn = null;
		List<GoodsDto> goodsDetails = new ArrayList<>();
		
		try {
			conn = dataSource.getConnection();
			String sql = "SELECT * FROM (" +
		             "    SELECT goodsid, goods_name, goods_price, goods_desc, goods_likes, goods_category, goods_qty, goods_regidate, goods_fname_main, ROWNUM AS rnum " +
		             "    FROM goods " +		             
		             "    ORDER BY goods_likes DESC" +
		             ") WHERE rnum <= 20";


			PreparedStatement pstmt = conn.prepareStatement(sql);

	        ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				GoodsDto goods = new GoodsDto();
				goods.setGoodsid(rs.getInt("goodsid"));
				goods.setGoods_name(rs.getString("goods_name"));
				goods.setGoods_price(rs.getInt("goods_price"));
				goods.setGoods_desc(rs.getString("goods_desc"));
				goods.setGoods_likes(rs.getInt("goods_likes"));
				goods.setGoods_category(rs.getString("goods_category"));
				goods.setGoods_qty(rs.getInt("goods_qty"));
				goods.setGoods_regidate(rs.getDate("goods_regidate"));
				goods.setGoods_fname_main(rs.getString("goods_fname_main"));
				
				goodsDetails.add(goods);
			}
			
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			closeConnection(conn);
		}
		return goodsDetails;
	}

	public int getGoodsCount(String goodsCategory) {
	    int goodscount = 0;
	    Connection conn = null;

	    try {
	        conn = dataSource.getConnection();
	        String sql = "SELECT count(*) FROM goods WHERE goods_category = ?";
	        PreparedStatement pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, goodsCategory); // 매개변수 설정

	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) { // 결과가 있을 경우
	            goodscount = rs.getInt(1); // 첫 번째 컬럼의 값을 가져옴
	        }
	    } catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			closeConnection(conn);
		}

	    return goodscount;
	}
	
	private void closeConnection(Connection con) {
		if(con!=null) {
			try {
				con.close();
			}catch(Exception e) {
				//nothing
			}
		}
 	}
	

}
