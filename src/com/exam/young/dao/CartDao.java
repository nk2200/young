package com.exam.young.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CartDao {
	static DataSource dataSource;
	
	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle");
		}catch(NamingException e) {
			
		}
	}
	
	public int getEmpCount() {
		int count =0;
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			String sql = "SELECT COUNT(*) FROM goods";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}	
		}catch(SQLException e) {
			System.out.println(e.getMessage());
		}
		
		return count;
	}
}
