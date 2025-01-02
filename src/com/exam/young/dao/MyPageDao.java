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
	
//	public Map<List<GoodsDto>, List<BuyDto>> getBuyAll(String customerid) {
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
//					   + "WHERE a.customerid = ? AND buy_status = 1";
//			PreparedStatement stmt = con.prepareStatement(sql);
//			stmt.setString(1, customerid);
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
	
//	public Map<List<GoodsDto>, List<BuyDto>> getBuyAll(String customerid) {
//	    List<GoodsDto> goodsList = new ArrayList<>();
//	    List<BuyDto> buyList = new ArrayList<>();
//	    Map<List<GoodsDto>, List<BuyDto>> order = new HashMap<>();
//
//	    Connection con = null;
//
//	    try {
//	        con = dataSource.getConnection();
//	        String sql = "SELECT buy_date, goods_name "
//	                   + "FROM buy a JOIN goods b ON a.goodsid = b.goodsid "
//	                   + "WHERE a.customerid = ? AND buy_status = 1";
//	        PreparedStatement stmt = con.prepareStatement(sql);
//	        stmt.setString(1, customerid);
//
//	        ResultSet rs = stmt.executeQuery();
//
//	        while(rs.next()) {
//	            GoodsDto goods = new GoodsDto();
//	            BuyDto buy = new BuyDto();
//
//	            buy.setBuy_date(rs.getDate("buy_date"));
//	            goods.setGoods_name(rs.getString("goods_name"));
//
//	            goodsList.add(goods);
//	            buyList.add(buy);
//
//	            // 상품과 구매 정보를 매번 map에 넣는다
//	            order.put(new ArrayList<>(goodsList), new ArrayList<>(buyList)); // 새로운 리스트를 생성해서 넣기
//	            
//	            for (Map.Entry<List<GoodsDto>, List<BuyDto>> entry : order.entrySet()) {
//	                List<GoodsDto> goodsListInOrder = entry.getKey();  // goodsList가 entry의 key로 들어있음
//	                for (GoodsDto goodsInOrder : goodsListInOrder) { // 변수명 변경
//	                    System.out.println(goodsInOrder.getGoods_name()); // 각 GoodsDto에서 goods_name을 출력
//	                }
//	            }
//	        }
//
//	    } catch(Exception e) {
//	        System.out.println(e.getMessage());
//	        throw new RuntimeException(e);
//	    } finally {
//	        closeConnection(con);
//	    }
//	    return order;
//	}
// 잘되지만 더 쉬운 방법으로 아래에 변경
//	public Map<List<GoodsDto>, List<BuyDto>> getBuyAll(String customerid) {
//	    List<GoodsDto> goodsList = new ArrayList<>();
//	    List<BuyDto> buyList = new ArrayList<>();
//	    Map<List<GoodsDto>, List<BuyDto>> order = new HashMap<>();
//
//	    Connection con = null;
//
//	    try {
//	        con = dataSource.getConnection();
//	        String sql = "SELECT buy_date, goods_name "
//	                   + "FROM buy a JOIN goods b ON a.goodsid = b.goodsid "
//	                   + "WHERE a.customerid = ? AND buy_status = 1";
//	        PreparedStatement stmt = con.prepareStatement(sql);
//	        stmt.setString(1, customerid);
//
//	        ResultSet rs = stmt.executeQuery();
//
//	        while(rs.next()) {
//	            GoodsDto goods = new GoodsDto();
//	            BuyDto buy = new BuyDto();
//
//	            buy.setBuy_date(rs.getDate("buy_date"));
//	            goods.setGoods_name(rs.getString("goods_name"));
//
//	            goodsList.add(goods);
//	            buyList.add(buy);
//	        }
//
//	        // order 맵에 각 goodsList와 buyList를 넣을 때, 반복문 밖에서 한 번만 넣기
//	        order.put(new ArrayList<>(goodsList), new ArrayList<>(buyList));
//
//	        // order 맵에서 모든 goods_name 출력
//	        for (Map.Entry<List<GoodsDto>, List<BuyDto>> entry : order.entrySet()) {
//	            List<GoodsDto> goodsListInOrder = entry.getKey();  // goodsList가 entry의 key로 들어있음
//	            for (GoodsDto goodsInOrder : goodsListInOrder) {
//	                System.out.println(goodsInOrder.getGoods_name()); // 각 GoodsDto에서 goods_name을 출력
//	            }
//	        }
//
//	    } catch(Exception e) {
//	        System.out.println(e.getMessage());
//	        throw new RuntimeException(e);
//	    } finally {
//	        closeConnection(con);
//	    }
//	    return order;
//	}
	public List<OrderDto> getBuyAll(String customerid) {
		List<OrderDto> orders = new ArrayList<>();
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = dataSource.getConnection();
            
            String sql = "SELECT goods_fname_main, buy_date, buy_qty, total_price, goods_name "
                       + "FROM buy a "
                       + "JOIN goods b ON a.goodsid = b.goodsid "
                       + "WHERE a.customerid = ? AND a.buy_status = 1 "
                       + "ORDER BY buy_date desc";
            
            stmt = con.prepareStatement(sql);
            stmt.setString(1, customerid);
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
            	OrderDto order = new OrderDto();

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
				//nothing
			}
		}
 	}
}
