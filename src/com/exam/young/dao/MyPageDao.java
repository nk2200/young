package com.exam.young.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.exam.young.dto.BuyDto;
import com.exam.young.dto.CustomerDto;
import com.exam.young.dto.GoodsDto;

public class MyPageDao {
	
	static DataSource dataSource;

	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle");
		}catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	public CustomerDto getCustomer(String customerid) {
		CustomerDto customer = new CustomerDto();
		Connection con = null;
		try {
			con = dataSource.getConnection();
			String sql = "SELECT customerid, customer_name "
					   + "FROM customer WHERE customerid=?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, customerid);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				customer.setCustomerid(rs.getString("customer_name"));
				customer.setCustomer_name(rs.getString("customer_name"));
			}else {
				throw new RuntimeException("사용자가 없습니다.");
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		}finally {
			closeConnection(con);
		}
		return customer;
	}
	
//	public CustomerDto getBuyAll(String customerid) {
//		
//	    List<GoodsDto> goodsList = new ArrayList<>();
//	    List<BuyDto> buyList = new ArrayList<>();
//	    Map<List<GoodsDto>, List<BuyDto>> order = new HashMap<>();
//	    
//		Connection con = null;
//		
//		try {
//			con = dataSource.getConnection();
//			String sql = "SELECT buy_date, goods_name "
//					   + "FROM buy a JOIN goods b ON a.goodsid = b.goodsid "
//					   + "WHERE a.customerid = ? AND buy_status = ?";
//			PreparedStatement stmt = con.prepareStatement(sql);
//			stmt.setString(1, customerid);
//			stmt.setInt(2, 1);
//			
//			ResultSet rs = stmt.executeQuery();
//			
//			while(rs.next()) {
//	            GoodsDto goods = new GoodsDto();
//	            BuyDto buy = new BuyDto();
//	            
//				buy.setBuy_date(rs.getDate("buy_date"));
//				goods.setGoods_name(rs.getString("goods_name"));
//				
//	            goodsList.add(goods);
//	            buyList.add(buy);
//	            
//			}
//			if (!goodsList.isEmpty() && !buyList.isEmpty()) {
//	            order.put(goodsList, buyList);
//	        }
//			
//		}catch(Exception e) {
//			System.out.println(e.getMessage());
//			throw new RuntimeException(e);
//		}finally {
//			closeConnection(con);
//		}
//		return order;
//	}
	


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
