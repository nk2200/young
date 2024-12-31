package com.exam.young.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.exam.young.dao.CartDao;
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
					List<CartDto> cartList = cartdao.getCartDetails(customerid);

					int totalPrice = 0;
					for (CartDto cart : cartList) {
						GoodsDto goods = cart.getGoods(); // CartDto에서 GoodsDto 가져오기
						int price = goods.getGoods_price(); // 상품 가격 가져오기
						int quantity = cart.getCart_qty(); // 장바구니 수량 가져오기

						totalPrice += price * quantity; // 가격 * 수량 계산하여 총합에 더하기
					}

					int totalQty = 0;
					for (CartDto cart : cartList) {

						totalQty += cart.getCart_qty();
					}

					request.setAttribute("totalQty", totalQty);
					request.setAttribute("totalPrice", totalPrice);
					request.setAttribute("cartList", cartList);
					session.setAttribute("customerid", customerid);
					String view = "cart/shoping-cart.jsp";

					RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
					disp.forward(request, response);
				} catch (SQLException e) {
					e.getMessage();
				}
			} else if ("pay".equals(action)) {

				request.setAttribute("customerid", customerid);
				request.setAttribute("cartid", cartid);
				session.setAttribute("customerid", customerid);

				RequestDispatcher dispatcher = request.getRequestDispatcher("/pay/Pay.do");
				dispatcher.forward(request, response);
			} else if ("deleteCart".equals(action)) {

				cartdao.deleteCart(cartid);

				String redirectUrl = "/cart/Cart.do?action=select&customerid=" + customerid;
				response.sendRedirect(redirectUrl);
			}

		} else {
			System.out.println("request 넘어온 action 없음");
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

}
