package com.exam.young.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.exam.young.dao.CartDao;

/**
 * Servlet implementation class CartServlet
 */
@WebServlet("/cart/Cart.do")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CartDao dao = new CartDao();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		int empCount = dao.getEmpCount();
		System.out.println(empCount);
		
		String view = "shop-details.jsp";
		
		RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
		disp.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		if("cart".equals(action)) {
			int goodsid = Integer.parseInt(request.getParameter("goodsid"));
			int goods_qty = Integer.parseInt(request.getParameter("goods_qty"));
			String customerid = request.getParameter("customerid");
			System.out.println(goodsid+", "+goods_qty+", "+customerid);
			
		}
	}

}
