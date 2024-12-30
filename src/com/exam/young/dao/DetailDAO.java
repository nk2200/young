package com.exam.young.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.management.RuntimeErrorException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.exam.young.dto.GoodsDto;

public class DetailDAO {
	static DataSource dataSource;
	//DataSource
	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	//Connection Close 메소드
	public void closeConnection(Connection conn) {
		if(conn!=null) {
			try {
				conn.close();
			}catch(Exception e) {
				System.out.println("closeConnection 예외 발생: "+e.getMessage());
			}
		}
	}
	
	public GoodsDto getGoods(int goodsid) {
		GoodsDto goods = new GoodsDto();
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			String sql = "SELECT goodsid, goods_name, goods_price, goods_desc,"
					+ " goods_likes, goods_category, goods_qty, "
					+ "goods_regidate, goods_filename "
					+ "FROM goods WHERE goodsid=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, goodsid);
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
				goods.setGoods_filename(rs.getString("goods_filename"));
			}else {
				throw new RuntimeException("선택한 goods가 없습니다.");
			}
		}catch(Exception e) {
			throw new RuntimeException(e);
		}finally {
			closeConnection(conn);
		}
		return goods;
	}
	
}
