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

import com.exam.young.dto.CartDto;
import com.exam.young.dto.GoodsDto;

public class CartDao {
	static DataSource dataSource;

	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
		} catch (NamingException e) {

		}
	}

	public List<CartDto> getCartList(String customerId) throws SQLException {
		Connection conn = null;
		List<CartDto> cartDetails = new ArrayList<>();
		try {
			conn = dataSource.getConnection();
			String query = "SELECT c.cartid, c.customerid, c.cart_qty, g.goodsid, g.goods_name, g.goods_price, "
					+ "g.goods_desc, g.goods_likes, g.goods_category, g.goods_qty, g.goods_regidate, "
					+ "g.goods_fname_main, g.goods_fname_sub " + "FROM CART c " + "JOIN GOODS g ON c.goodsid = g.goodsid "
					+ "WHERE c.customerid = ?";
	
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, customerId);
			ResultSet rs = pstmt.executeQuery();
	
			while (rs.next()) {
				CartDto cart = new CartDto();
				cart.setCartid(rs.getInt("cartid"));
				cart.setCustomerid(rs.getString("customerid"));
				cart.setCart_qty(rs.getInt("cart_qty"));
	
				GoodsDto goods = new GoodsDto();
				goods.setGoodsid(rs.getInt("goodsid"));
				goods.setGoods_name(rs.getString("goods_name"));
				goods.setGoods_price(rs.getInt("goods_price"));
				goods.setGoods_desc(rs.getString("goods_desc"));
				goods.setGoods_likes(rs.getInt("goods_likes"));
				goods.setGoods_category(rs.getString("goods_category"));
				goods.setGoods_qty(rs.getInt("goods_qty"));
				goods.setGoods_regidate(rs.getDate("goods_regidate"));
				goods.setGoods_fname_main(rs.getString("goods_fname_main"));
				goods.setGoods_fname_sub(rs.getNString("goods_fname_sub"));
	
				cart.setGoods(goods);
				cartDetails.add(cart);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			closeConnection(conn);
		}

		return cartDetails;
	}
	
	

	public GoodsDto getCartGoodsList(String customerid) {
		GoodsDto goods = new GoodsDto();
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			String sql = "SELECT goodsid, goods_name, goods_price, FROM goods WHERE customerid = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerid);

			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				goods.setGoodsid(rs.getInt("cartid"));
				goods.setGoods_name(rs.getString("goods_name"));
				goods.setGoods_price(rs.getInt("goods_price"));
			} else {
				throw new RuntimeException("해당 customerid의 goodslist가 없습니다.");
			}

		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			closeConnection(conn);
		}

		return goods;
	}

	public void deleteCart(int cartid) {
		System.out.println("삭제");
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			String sql = "DELETE FROM cart WHERE cartid =? ";
			PreparedStatement pstm = null;

			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, cartid);

			pstm.executeUpdate();

		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			closeConnection(conn);
		}

	}

	public void addCart(CartDto cart) {
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			String sql = "INSERT INTO cart(customerid,goodsid,cart_qty) "
					+ "values(?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cart.getCustomerid());
			pstmt.setInt(2, cart.getGoodsid());
			pstmt.setInt(3, cart.getCart_qty());
			int rs = pstmt.executeUpdate();
			System.out.println(cart.toString()+"\n"+rs+"행 삽입 완료");
			if(rs <= 0) {
				throw new RuntimeException("저장된 행이 없습니다.");
			}
		}catch(Exception e) {
			System.out.println("addCart() 예외: "+e.getMessage());
			 throw new RuntimeException(e);
		}finally {
			closeConnection(conn);
		}
	}
	
//	public void payByCartId(String customerid) {
//		Connection conn = null;
//		
//		try {
//			conn = dataSource.getConnection();
//			String sql = "SELECT "
//			
//		} catch (SQLException e) {
//			System.out.println(e.getMessage());
//		}finally {
//			closeConnection(conn);
//		}
//	}
	public boolean updateQty(int cartid, int cart_qty) {
	    Connection conn = null;

	    try {
	        conn = dataSource.getConnection(); // DataSource로부터 연결 가져오기
	        String sql = "UPDATE cart SET cart_qty = ? WHERE cartid = ?"; // 올바른 SQL 작성
	        PreparedStatement stmt = conn.prepareStatement(sql);

	       
	        stmt.setInt(1, cart_qty); 
	        stmt.setInt(2, cartid);  

	      
	        int rowsAffected = stmt.executeUpdate();
	        return rowsAffected > 0; 

	    } catch (SQLException e) {
	        System.out.println("Error updating cart quantity: " + e.getMessage());
	        return false;
	    } finally {
	        closeConnection(conn);
	    }
	}

	public int existCart(int goodsid) {
		int cartcount = 0;
		 Connection conn = null;

		    try {
		        conn = dataSource.getConnection(); // DataSource로부터 연결 가져오기
		        String sql = "SELECT count(*) FROM cart WHERE goodsid = ?";
		        PreparedStatement pstmt = conn.prepareStatement(sql);
		        pstmt.setInt(1, goodsid); // 매개변수 설정

		        ResultSet rs = pstmt.executeQuery();
		        if (rs.next()) { // 결과가 있을 경우
		        	cartcount = rs.getInt(1); // 첫 번째 컬럼의 값을 가져옴
		        } 

		    } catch (SQLException e) {
		        System.out.println("Error updating cart quantity: " + e.getMessage());
		       
		    } finally {
		        closeConnection(conn);
		    }
		return cartcount;
	}
	
	
	public boolean plusQty(int goodsid) {
		Connection conn = null;
		System.out.println("plusQty 실행");
		
	    try {
	        conn = dataSource.getConnection(); // DataSource로부터 연결 가져오기
	        String sql = "UPDATE cart SET cart_qty = cart_qty + 1 WHERE goodsid = ?"; // 올바른 SQL 작성
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        conn.setAutoCommit(false); // Auto-commit 비활성화
	        stmt.setInt(1, goodsid);
	        int rowsAffected = stmt.executeUpdate();
	       
	        conn.commit(); 
	        return rowsAffected > 0; 

	    } catch (SQLException e) {
	        System.out.println("Error updating cart quantity: " + e.getMessage());
	        return false;
	    } finally {
	        closeConnection(conn);
	    }
	}
	
	public void addCart(String customerid, int goodsid, int goods_qty) {
		Connection conn = null;

	    try {
	        conn = dataSource.getConnection(); // DataSource로부터 연결 가져오기
	        String sql = "INSERT INTO CART(customerid, goodsid, cart_qty) VALUES ( ?, ?, ?)"; // 올바른 SQL 작성
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setString(1, customerid); // 매개변수 설정
	        stmt.setInt(2, goodsid); // 매개변수 설정
	        stmt.setInt(3, goods_qty);
	        
	        int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("상품이 카트에 추가되었습니다.");
            } else {
                System.out.println("상품 추가에 실패했습니다.");
            }

	    } catch (SQLException e) {
	        System.out.println("Error updating cart quantity: " + e.getMessage());
	     
	    } finally {
	        closeConnection(conn);
	    }
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
	
	public boolean plusQty(int goodsid, int goods_qty) {
		Connection conn = null;
		System.out.println("plusQty 실행");
		
	    try {
	        conn = dataSource.getConnection(); // DataSource로부터 연결 가져오기
	        String sql = "UPDATE cart SET cart_qty = cart_qty + ? WHERE goodsid = ?"; // 올바른 SQL 작성
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        conn.setAutoCommit(false); // Auto-commit 비활성화
	        stmt.setInt(1, goods_qty);
	        stmt.setInt(2, goodsid);
	        int rowsAffected = stmt.executeUpdate();
	       
	        conn.commit(); 
	        return rowsAffected > 0; 

	    } catch (SQLException e) {
	        System.out.println("Error updating cart quantity: " + e.getMessage());
	        return false;
	    } finally {
	        closeConnection(conn);
	    }
	}
	
	
}
