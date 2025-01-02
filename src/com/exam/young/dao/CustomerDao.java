package com.exam.young.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.exam.young.dto.CustomerDto;

public class CustomerDao {
	static DataSource dataSource;

	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	// Connection Close 메소드
	public void closeConnection(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				System.out.println("closeConnection 예외 발생: " + e.getMessage());
			}
		}
	}
	//비밀번호 가져오는 메소드
	public String getPassword(String customerid){
		Connection conn = null;
		String dbpw = null;
		try {
			conn = dataSource.getConnection();
			String sql = "SELECT password FROM customer WHERE customerid=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, customerid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpw = rs.getString("password");
			}
		}catch(Exception e) {
			throw new RuntimeException("getPassword 예외: "+e.getMessage());
		}finally {
			closeConnection(conn);
		}
		return dbpw;
	}
	//customer 삽입
	public void insertCustomer(CustomerDto customer) {
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			String sql = "INSERT INTO customer (customerid, customer_name, password, customer_address) "
					+ "VALUES(?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, customer.getCustomerid());
			pstmt.setString(2, customer.getCustomer_name());
			pstmt.setString(3, customer.getPassword());
			pstmt.setString(4, customer.getCustomer_address());
			int rc = pstmt.executeUpdate();
			if(rc<=0) {
				System.out.println("insertCustomer()=>회원 insert 실패..!");
			}else {
				System.out.println("insertCustomer()=>회원 insert 성공ㅎ");
			}
		}catch(Exception e) {
			throw new RuntimeException("insertCustomer 예외: "+e.getMessage());
		}finally {
			closeConnection(conn);
		}
	}
}
