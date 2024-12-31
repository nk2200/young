package com.exam.young.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.exam.young.dao.RegisterDao;
import com.exam.young.dto.GoodsDto;

@WebServlet("/register/Register.do")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	RegisterDao dao = new RegisterDao();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		String view = "register/goodsList.jsp";
		
		if (action == null) {
			List<GoodsDto> goods = dao.getGoodsList();
			request.setAttribute("goods", goods);
			request.setAttribute("count", dao.getCount());
		}
		
		RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
		disp.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
