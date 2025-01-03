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

public class MainDao {
static DataSource dataSource;

	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	public List<GoodsDto> getRankedGoods() {
		Connection con = null;
		List<GoodsDto> goodsList = new ArrayList<>();
		
		try {
			con = dataSource.getConnection();
			
			String sql = "SELECT g.goodsid, g.goods_name, g.goods_price, g.goods_fname_main, NVL(SUM(b.buy_qty), 0) AS goods_cnt "
						+"FROM goods g LEFT JOIN buy b ON g.goodsid = b.goodsid "
						+"GROUP BY g.goodsid,g.goods_name, g.goods_price,g.goods_fname_main "
						+"ORDER BY goods_cnt DESC";
			
			PreparedStatement stmt = con.prepareStatement(sql);
			
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				
                GoodsDto goods = new GoodsDto();
                
                goods.setGoodsid(rs.getInt("goodsid"));
                goods.setGoods_name(rs.getString("goods_name"));
                goods.setGoods_price(rs.getInt("goods_price"));
                goods.setGoods_fname_main(rs.getString("goods_fname_main"));
    		                
                goodsList.add(goods);
			}
							
		} catch (SQLException e) {
			
			System.out.println(e.getMessage());
			
			throw new RuntimeException(e);
			
		} finally {
			
			if (con != null) try { con.close(); } catch (Exception e) {}
		}
		return goodsList;
	}
	
	public List<GoodsDto> searchGoodsByName(String searchName) {
		Connection con = null;
		List<GoodsDto> selectedGoodsList = new ArrayList<>();
		
		try {
			con = dataSource.getConnection();
			
			String sql = "SELECT GOODS_NAME,GOODS_PRICE,goods_fname_main FROM goods WHERE goods_name LIKE ?";
			
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, "%" + searchName + "%");
			
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				
                GoodsDto goods = new GoodsDto();
                
                goods.setGoods_name(rs.getString("GOODS_NAME"));
                goods.setGoods_price(rs.getInt("GOODS_PRICE"));
                goods.setGoods_fname_main(rs.getString("goods_fname_main"));
                
                selectedGoodsList.add(goods);
			}
							
		} catch (SQLException e) {
			
			System.out.println(e.getMessage());
			
			throw new RuntimeException(e);
		} finally {
			
			if (con != null) try { con.close(); } catch (Exception e) {}
		}
		return selectedGoodsList;
    }
	
	public List<GoodsDto> getRecommendedProducts(String customerid) {
	    List<GoodsDto> recommendedList = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;

	    try {
	        con = dataSource.getConnection();

	        String recommendedSql = "SELECT g.goods_name, g.goods_fname_main, g.goods_price, COUNT(*) AS purchase_count " +
	                                "FROM buy b " +
	                                "JOIN goods g ON b.goodsid = g.goodsid " +
	                                "WHERE b.customerid != ? " +
	                                "AND b.goodsid IN ( " +
	                                "    SELECT buy.goodsid " +
	                                "    FROM buy " +
	                                "    WHERE buy.customerid = ? " +
	                                ") " +
	                                "GROUP BY g.goods_name, g.goods_fname_main, g.goods_price " +
	                                "ORDER BY purchase_count DESC " +
	                                "FETCH FIRST 5 ROWS ONLY";

	        stmt = con.prepareStatement(recommendedSql);
	        stmt.setString(1, customerid);
	        stmt.setString(2, customerid);

	        rs = stmt.executeQuery();

	        while (rs.next()) {
	            GoodsDto recommendedGoods = new GoodsDto();
	            recommendedGoods.setGoods_fname_main(rs.getString("goods_fname_main"));
	            recommendedGoods.setGoods_name(rs.getString("goods_name"));
	            recommendedGoods.setGoods_price(rs.getInt("goods_price"));
	            recommendedList.add(recommendedGoods);
	        }

	        if (recommendedList.isEmpty()) {
	            String categorySql = "SELECT bb.goods_name, bb.goods_fname_main, bb.goods_price " +
	                                 "FROM buy aa " +
	                                 "JOIN goods bb ON aa.goodsid = bb.goodsid " +
	                                 "WHERE bb.goods_category IN ( " +
	                                 "    SELECT b.goods_category " +
	                                 "    FROM buy a " +
	                                 "    JOIN goods b ON a.goodsid = b.goodsid " +
	                                 "    WHERE a.customerid = ? " +  
	                                 "    GROUP BY b.goods_category " +
	                                 "    ORDER BY COUNT(*) DESC " +  
	                                 "    FETCH FIRST 3 ROWS ONLY " +  
	                                 ") " +
	                                 "GROUP BY bb.goods_name, bb.goods_fname_main, bb.goods_price " +
	                                 "ORDER BY SUM(aa.buy_qty) DESC";  

	            stmt = con.prepareStatement(categorySql);
	            stmt.setString(1, customerid);

	            rs = stmt.executeQuery();

	            while (rs.next()) {
	                GoodsDto categoryGoods = new GoodsDto();
	                categoryGoods.setGoods_fname_main(rs.getString("goods_fname_main"));
	                categoryGoods.setGoods_name(rs.getString("goods_name"));
	                categoryGoods.setGoods_price(rs.getInt("goods_price"));
	                recommendedList.add(categoryGoods);
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw new RuntimeException("Database error occurred while fetching product data", e);
	    } finally {
	        if (con != null) try { con.close(); } catch (Exception e) {}
	    }

	    return recommendedList;
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
			if (con != null) try { con.close(); } catch (Exception e) {}
		}
		return customer;
	}
}

//package com.exam.young.dao;
//
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//
//import javax.naming.Context;
//import javax.naming.InitialContext;
//import javax.naming.NamingException;
//import javax.sql.DataSource;
//
//import com.exam.young.dto.GoodsDto;
//
//public class MainDao {
//    static DataSource dataSource;
//
//    static {
//        try {
//            Context context = new InitialContext();
//            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
//        } catch (NamingException e) {
//            e.printStackTrace();
//        }
//    }
//
//    // action에 따른 상품 조회 메서드
//    public List<GoodsDto> getGoods(String action, String searchName) {
//        if ("rank".equals(action)) {
//            return getRankedGoods(); // 랭킹 조회
//        } else if ("search".equals(action)) {
//            return searchGoodsByName(searchName); // 이름 검색
//        } else {
//            return new ArrayList<>(); // 기본 빈 리스트 반환
//        }
//    }
//
//    // 상품 랭킹 조회
//    public List<GoodsDto> getRankedGoods() {
//        Connection con = null;
//        List<GoodsDto> goodsList = new ArrayList<>();
//        try {
//            con = dataSource.getConnection();
//
//            String sql = "SELECT g.goods_name, g.goods_price, g.goods_fname_main, NVL(SUM(b.buy_qty), 0) AS goods_cnt "
//                    + "FROM goods g LEFT JOIN buy b ON g.goodsid = b.goodsid "
//                    + "GROUP BY g.goods_name, g.goods_price, g.goods_fname_main "
//                    + "ORDER BY goods_cnt DESC";
//
//            PreparedStatement stmt = con.prepareStatement(sql);
//
//            ResultSet rs = stmt.executeQuery();
//
//            while (rs.next()) {
//                GoodsDto goods = new GoodsDto();
//
//                goods.setGoods_name(rs.getString("goods_name"));
//                goods.setGoods_price(rs.getInt("goods_price"));
//                goods.setGoods_fname_main(rs.getString("goods_fname_main"));
//
//                goodsList.add(goods);
//            }
//
//        } catch (SQLException e) {
//            System.out.println(e.getMessage());
//            throw new RuntimeException(e);
//        } finally {
//            if (con != null) try { con.close(); } catch (Exception e) {}
//        }
//        return goodsList;
//    }
//
//    // 상품명으로 검색
//    public List<GoodsDto> searchGoodsByName(String searchName) {
//        Connection con = null;
//        List<GoodsDto> selectedGoodsList = new ArrayList<>();
//        try {
//            con = dataSource.getConnection();
//
//            String sql = "SELECT GOODS_NAME, GOODS_PRICE, goods_fname_main FROM goods WHERE goods_name LIKE ?";
//
//            PreparedStatement stmt = con.prepareStatement(sql);
//            stmt.setString(1, "%" + searchName + "%");
//
//            ResultSet rs = stmt.executeQuery();
//
//            while (rs.next()) {
//                GoodsDto goods = new GoodsDto();
//
//                goods.setGoods_name(rs.getString("GOODS_NAME"));
//                goods.setGoods_price(rs.getInt("GOODS_PRICE"));
//                goods.setGoods_fname_main(rs.getString("goods_fname_main"));
//
//                selectedGoodsList.add(goods);
//            }
//
//        } catch (SQLException e) {
//            System.out.println(e.getMessage());
//            throw new RuntimeException(e);
//        } finally {
//            if (con != null) try { con.close(); } catch (Exception e) {}
//        }
//        return selectedGoodsList;
//    }
//}

