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

import com.exam.young.dto.CustomerDto;
import com.exam.young.dto.GoodsDto;
import com.exam.young.dto.OrderDto;

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
	
	public List<OrderDto> getBuyAll(String customerid) {
		List<OrderDto> orders = new ArrayList<>();
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = dataSource.getConnection();
            
            String sql = "SELECT b.goodsid, goods_fname_main, buy_date, buy_qty, total_price, goods_name "
                       + "FROM buy a "
                       + "JOIN goods b ON a.goodsid = b.goodsid "
                       + "WHERE a.customerid = ? AND a.buy_status = 1 "
                       + "ORDER BY buy_date desc";
            
            stmt = con.prepareStatement(sql);
            stmt.setString(1, customerid);
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
            	OrderDto order = new OrderDto();

            	order.setGoodsid(rs.getInt("goodsid"));
                order.setGoods_fname_main(rs.getString("goods_fname_main"));
                order.setGoods_name(rs.getString("goods_name"));
                order.setBuy_date(rs.getDate("buy_date"));
                order.setBuy_qty(rs.getInt("buy_qty"));
                order.setTotal_price(rs.getInt("total_price"));
                orders.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Database error occurred while fetching buy data", e);
        } finally {
            closeConnection(con);
        }

        return orders;
	}


	private void closeConnection(Connection con) {
		if(con!=null) {
			try {
				con.close();
			}catch(Exception e) {
			}
		}
 	}
}
