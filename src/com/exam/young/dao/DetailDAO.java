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
	//goods 가져오기
	public GoodsDto getGoods(int goodsid) {
		GoodsDto goods = new GoodsDto();
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			String sql = "SELECT goodsid, goods_name, goods_price, goods_desc,"
					+ " goods_likes, goods_category, goods_qty, "
					+ "goods_regidate, goods_fname_main, goods_fname_sub "
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
				goods.setGoods_fname_main(rs.getString("goods_fname_main"));
				goods.setGoods_fname_sub(rs.getString("goods_fname_sub"));
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
	//goods likes 증가 메소드
	public int updateGoodsLikes(int goodsid) {
		int plus_goods_likes = getGoods(goodsid).getGoods_likes()+1;
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			String sql = "UPDATE goods SET goods_likes=? WHERE goodsid=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, plus_goods_likes);
			pstmt.setInt(2, goodsid);
			int rs = pstmt.executeUpdate();
			System.out.println("goods like 증가완료 => "+plus_goods_likes);
			if(rs<=0) {
				System.out.println("updateGoodsLikes() 예외: ");
				throw new RuntimeException("변경된 행이 없습니다.");
			}
		}catch(Exception e) {
			System.out.println("updateGoodsLikes() 예외: ");
			throw new RuntimeException(e.getMessage());
		}finally {
			closeConnection(conn);
		}
		return plus_goods_likes;
	}
	//goods likes 감소 메소드
	public int minusGoodsLikes(int goodsid) {
		int minus_goods_likes = getGoods(goodsid).getGoods_likes()-1;
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			String sql = "UPDATE goods SET goods_likes=? WHERE goodsid=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, minus_goods_likes);
			pstmt.setInt(2, goodsid);
			int rs = pstmt.executeUpdate();
			System.out.println("goods like 감소완료 => "+minus_goods_likes);
			if(rs<=0) {
				System.out.println("minusGoodsLikes() 예외: ");
				throw new RuntimeException("변경된 행이 없습니다.");
			}
		}catch(Exception e) {
			System.out.println("minusGoodsLikes() 예외: ");
			throw new RuntimeException(e.getMessage());
		}finally {
			closeConnection(conn);
		}
		return minus_goods_likes;
	}
}
