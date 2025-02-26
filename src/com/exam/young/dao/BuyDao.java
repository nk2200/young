package com.exam.young.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.exam.young.dto.BuyDto;
import com.exam.young.dto.CartDto;

public class BuyDao {

	//DataSource 초기화 및 설정
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
					+ "values (?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setFloat(1, buyinfo.getBuyid());				// 구매 id
			stmt.setInt(2, buyinfo.getBuy_status());			// 구매 상태 (0, 1)
			stmt.setDate(3, (Date) buyinfo.getBuy_date());		// 구매 일자
			stmt.setString(4, buyinfo.getCustomerid());			// 고객 id
			stmt.setInt(5, buyinfo.getGoodsid());				// 상품 id
			stmt.setInt(6, buyinfo.getTotal_price());			// 총 가격
			stmt.setInt(7, buyinfo.getBuy_qty());				// 총 수량	
			
			int rowCount = stmt.executeUpdate();
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
	
	//Goods 테이블에서 제품 id로 가격 가져오기 - 상세 페이지
	public Map<String, Object> getPrice(int goodsid) {
		Map<String, Object> gInfo = new HashMap<>();
		Connection con = null;
		
		try {
			con = dataSource.getConnection();
			String  sql = "SELECT goods_name, goods_price FROM goods WHERE goodsid=?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setInt(1, goodsid);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				gInfo.put("goods_name", rs.getString("goods_name"));
				gInfo.put("goods_price", rs.getInt("goods_price"));
			}
			
			if(gInfo.size()==0){
				throw new RuntimeException("상품아이디가 없습니다.");
			}
		}catch(SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		}finally {
			closeConnection(con);
		}
		return gInfo;
	}
	
	//Cart 테이블에서 카트 id를 전달받아 상품의 이름과 가격을 리턴
	public Map<String, Object> getCartItems(int cartid){
		Map<String, Object> gInfo = new HashMap<>();
		Connection con = null;
		
		try {
			con = dataSource.getConnection();
			String sql = "SELECT g.goodsid, g.goods_name, g.goods_price, c.customerid, c.cart_qty FROM cart c "
						+ "JOIN goods g ON c.goodsid = g.goodsid "
						+ "WHERE c.cartid=?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setInt(1,cartid);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				//goods_name과 goods_price를 가져와 BuyDto 객체에 저장
				gInfo.put("goodsid", rs.getInt("goodsid"));
				gInfo.put("goods_name", rs.getString("goods_name"));
				gInfo.put("goods_price", rs.getInt("goods_price"));
				gInfo.put("customerid", rs.getString("customerid"));
				gInfo.put("cart_qty", rs.getInt("cart_qty"));
				
			}
			if(gInfo.size()==0) {
				throw new RuntimeException("상품을 찾을 수 없습니다.");
			}
		
		}catch(SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		}finally {
			closeConnection(con);
		}
		return gInfo;
	}
	
	//카트 장바구니 삭제
	public void deleteCart(int cartid) {
		Connection con = null;
		try {
			con = dataSource.getConnection();
			String sql = "DELETE cart WHERE cartid=?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setInt(1, cartid);
			
			int rowCount = stmt.executeUpdate();
			System.out.println("CartId: "+cartid+" 의 장바구니 항목 삭제됨");
			if(rowCount <= 0) {
				throw new RuntimeException("카트 아이디가 없습니다.");
			}
		}catch(SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		}finally {
			closeConnection(con);
		}
	}
	
	// 결제 완료 시 goods 테이블의 수량 변경
	public void updateGoodsQty(int buyQty, int goodsid) {
		Connection con = null;
		try {
			con = dataSource.getConnection();
			String sql = "update goods set goods_qty = (goods_qty - ?) where goodsid= ? and goods_qty >= ?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setInt(1, buyQty);
			stmt.setInt(2, goodsid);
			stmt.setInt(3, buyQty);
			int rowCount = stmt.executeUpdate();
			
			//남은 수량이 변경되지 않았다면
			if(rowCount<0) {
				throw new RuntimeException("수량의 변경이 없습니다.");
			}
		}catch(SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		}finally {
			closeConnection(con);
		}
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
}
