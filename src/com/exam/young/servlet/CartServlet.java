package com.exam.young.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.exam.young.dao.CartDao;
import com.exam.young.dao.DetailDAO;
import com.exam.young.dto.CartDto;
import com.exam.young.dto.GoodsDto;

/**
 * Servlet implementation class CartServlet
 */
@WebServlet("/cart/Cart.do")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CartDao cartdao = new CartDao();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();

		String action = request.getParameter("action");
		String customerid = request.getParameter("customerid");
		// String customerid = session.getAttribute("customerid");
		String cartidParam = request.getParameter("cartid");
		int cartid = 0;
		
		if (cartidParam != null && !cartidParam.isEmpty()) {
			try {
		        cartid = Integer.parseInt(cartidParam); // String을 int로 변환
		    } catch (NumberFormatException e) {
		        e.printStackTrace();
		    }
		} 

		if (action != null) {
			if ("select".equals(action)) {
				try {
					System.out.println("select 실행");
					List<CartDto> cartList = cartdao.getCartList(customerid);
					System.out.println("cartList" + cartList);
					
					int totalPrice = gettotalPrice(cartList);
					int totalQty = getQty(cartList);
					
					request.setAttribute("totalQty", totalQty);
					request.setAttribute("totalPrice", totalPrice);
					request.setAttribute("cartList", cartList);
					//session.setAttribute("customerid", customerid);
					String view = "cart/shoping-cart.jsp";

					RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
					disp.forward(request, response);
				} catch (SQLException e) {
					System.out.println("오류 발생");
					e.getStackTrace();
					e.getMessage();
				}
			} 

		} else {
			System.out.println("request 넘어온 action 없음");
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String customerid ="cust001"; 
				//request.getParameter("customerid");
		// String customerid = session.getAttribute("customerid");
		String cartidParam = request.getParameter("cartid");

		int cartid=0;
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		if("cart".equals(action)) {
			int goodsid = Integer.parseInt(request.getParameter("goodsid"));
			int goods_qty = Integer.parseInt(request.getParameter("goods_qty"));
			customerid = request.getParameter("customerid");
			System.out.println(goodsid+", "+goods_qty+", "+customerid);
			//원래 cart에 있는 goods면 추가, 아니면 새로 cart삽입
			if(cartdao.existCart(goodsid) != 0) {
				cartdao.plusQty(goodsid, goods_qty);
			}else {
				CartDto cart = new CartDto();
				cart.setGoodsid(goodsid);
				cart.setCart_qty(goods_qty);
				cart.setCustomerid(customerid);
				cartdao.addCart(cart);
			}
			
			response.setContentType("text/plain");
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().write("카트에 넣기 성공");
			
		}else if ("pay".equals(action)) { //이따 해야지
			//cartdao.payByCartId(customerid);
			
			request.setAttribute("customerid", customerid);
			request.setAttribute("cartid", cartid);
			//session.setAttribute("customerid", customerid);

			RequestDispatcher dispatcher = request.getRequestDispatcher("/pay/Pay.do");
			dispatcher.forward(request, response);
		} else if ("deleteCart".equals(action)) {
			cartid = Integer.parseInt(request.getParameter("cartid"));
			customerid="user1";
			
			cartdao.deleteCart(cartid);
		
			String redirectUrl = "/cart/Cart.do?action=select&customerid=" + customerid;
			response.sendRedirect(redirectUrl);
		} else if("selectDelete".equals(action)) {
			String selectItems = request.getParameter("selectedItems");
			
			String[] items = selectItems.split(",");
			
			for (String item : items) {
				String number = item.replaceAll("[^0-9]", "");
				cartid = Integer.parseInt(number);
				cartdao.deleteCart(cartid);
			}
			String redirectUrl = "/cart/Cart.do?action=select&customerid=" + customerid;
			response.sendRedirect(redirectUrl);
		}else if ("updateQty".equals(action)) {
		    cartid = Integer.parseInt(request.getParameter("cartid"));
		    int cart_qty = Integer.parseInt(request.getParameter("cart_qty"));
		    
		    boolean isUpdated = false;
		    try {
		        // 수량 업데이트
		        isUpdated = cartdao.updateQty(cartid, cart_qty);
		        
		        if (isUpdated) {
		            try {
		               
		                List<CartDto> cartList = cartdao.getCartList(customerid); // customerid는 세션에서 가져와야 함
		                int totalPrice = gettotalPrice(cartList);
		                int totalQty = getQty(cartList);
		                
		                StringBuilder jsonResponse = new StringBuilder();
		                jsonResponse.append("{");
		                jsonResponse.append("\"status\":\"success\",");
		                jsonResponse.append("\"totalPrice\":").append(totalPrice).append(",");
		                jsonResponse.append("\"totalQty\":").append(totalQty);
		                jsonResponse.append("}");

		                response.setContentType("application/json");
		                response.setCharacterEncoding("UTF-8");

		                PrintWriter out = response.getWriter();
		                out.print(jsonResponse.toString());
		                out.flush();

		            } catch (SQLException e) {
		                e.printStackTrace();
		                response.getWriter().write("{\"status\":\"fail\", \"error\":\"장바구니 목록을 가져오는 중 오류가 발생했습니다.\"}");
		            }
		        } else {
		            response.getWriter().write("{\"status\":\"fail\", \"error\":\"수량 업데이트 실패\"}");
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		        response.getWriter().write("{\"status\":\"fail\", \"error\":\"알 수 없는 오류가 발생했습니다.\"}");
		    }
		    return;
		}else if("addCart".equals(action)) {
			int goodsid = Integer.parseInt(request.getParameter("goodsid"));
			customerid="cust001";
		
			if(cartdao.existCart(goodsid) != 0) {
				cartdao.plusQty(goodsid); 
			}else {
				cartdao.addCart(customerid, goodsid, 1);
			}
		}



	}
	
	private int gettotalPrice(List<CartDto> cartList){
		int totalPrice = 0;
	
		for (CartDto cart : cartList) {
			GoodsDto goods = cart.getGoods(); // CartDto에서 GoodsDto 가져오기
			int price = goods.getGoods_price(); // 상품 가격 가져오기
			int quantity = cart.getCart_qty(); // 장바구니 수량 가져오기
			
			totalPrice += price * quantity; // 가격 * 수량 계산하여 총합에 더하기
		}
		
		return totalPrice;
	}
	
	private int getQty(List<CartDto> cartList) {

		int totalQty = 0;
		
		for (CartDto cart : cartList) {

			totalQty += cart.getCart_qty();
		}
		
		return totalQty;
	}

}
