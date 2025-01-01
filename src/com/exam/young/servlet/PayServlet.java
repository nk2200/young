package com.exam.young.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.exam.young.dao.BuyDao;

/**
 * Servlet implementation class PayServlet
 */
@WebServlet("/pay/Pay.do")
public class PayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	BuyDao dao = new BuyDao();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String view = "checkout.jsp";
		
		RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
		disp.forward(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		
		try {
			//여기에 insert 구문 기입
			
			return;
		}catch(Exception e) {
			throw new RuntimeException(e);
		}
		
	}
}
