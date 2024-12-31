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

	public List<CartDto> getCartDetails(String customerId) throws SQLException {
		Connection conn = null;
		List<CartDto> cartDetails = new ArrayList<>();

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
			goods.setGoods_fname_main(rs.getString("goods_filename"));
			goods.setGoods_fname_sub(rs.getNString("goods_filedetail"));

			cart.setGoods(goods);
			cartDetails.add(cart);
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
		}

		return goods;
	}

	public void deleteCart(int cartid) {
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			String sql = "SELECT * FROM cart WHERE cartid =? ";
			PreparedStatement pstm = null;

			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, cartid);

			pstm.executeUpdate();

		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}

	}
//	한번 머지하고 만들게여
//	public void addCart(CartDto cart) {
//		Connection conn = null;
//		try {
//			conn = dataSource.getConnection();
//			String sql = "INSERT INTO cart(customerid,goodsid,cart_qty) "
//					+ "values(?,?,?)";
//			PreparedStatement pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, );
//		}
//	}
}
