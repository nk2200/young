package com.exam.young.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.exam.young.dto.BuyDto;

public class BuyDao {

	static DataSource dataSource;
	
	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle");
		}catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	//Buy 테이블에 구매 정보 Insert
	public void insertBuy(BuyDto buyinfo) {
		Connection con = null;
		try {
			con = dataSource.getConnection();
			String sql = "INSERT INTO BUY (buyid, buy_status, buy_date, customerid, goodsid, total_price, buy_qty) "
					+ "VALUSE (?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setFloat(1, buyinfo.getBuyid());				// 구매 id
			stmt.setInt(2, buyinfo.getBuy_status());			// 구매 상태 (0, 1)
			stmt.setDate(3, (Date) buyinfo.getBuy_date());		// 구매 일자
			stmt.setString(4, buyinfo.getCustomerid());			// 고객 id
			stmt.setInt(5, buyinfo.getGoodsid());				// 상품 id
			stmt.setInt(6, buyinfo.getTotal_price());			// 총 가격
			stmt.setInt(7, buyinfo.getBuy_qty());				// 총 수량
			
			
			int rowCount = stmt.executeUpdate();
			System.out.println(rowCount + "개 상품이 결제되었습니다.");
			if(rowCount <=0) {
				throw new SQLException("결제 된 내역이 없습니다.");
			}
		}catch(SQLException e){
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		}finally {
			closeConnection(con);
		}
	}
	
	//Goods 테이블에서 제품 id로 가격 가져오기
	public int getPrice(int goodsid) {
		int price = 0;
		Connection con = null;
		
		try {
			con = dataSource.getConnection();
			String  sql = "SELECT goods_price FROM goods WHERE goodsid=?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setInt(1, goodsid);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				price = rs.getInt("goods_price");
			}else {
				throw new RuntimeException("상품아이디가 없습니다.");
			}
		}catch(SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		}finally {
			closeConnection(con);
		}
		return price;
	}
	
	//DB 커넥션 닫기
	private void closeConnection(Connection con) {
		if(con!=null) {
			try {
				con.close();
			}catch(Exception e) {
				//nothing
			}
		}
 	}
	
	//상세 페이지에서 결제 창 호출 시 실행
	public void detailPay(String arg[]) {
		
	}
	
	//장바구니 페이지에서 결제 창 호출 시 실행
	public void cartPay() {
		
	}
}
