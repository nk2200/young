package com.exam.young.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.exam.young.dao.BuyDao;
import com.exam.young.dao.CartDao;
import com.exam.young.dto.CartDto;

/**
 * Servlet implementation class PayServlet
 */
@WebServlet("/pay/Pay.do")
public class PayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	BuyDao dao = new BuyDao();
	CartDao cartdao = new CartDao();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String view = "checkout.jsp";
		
		RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
		disp.forward(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
	  //HttpSession session = request.getSession();
		String customerid = (String) session.getAttribute("customerid");
	
		
		if("detail".equals(action)) {
			int goodsid = Integer.parseInt(request.getParameter("goodsid"));
			int goods_qty = Integer.parseInt(request.getParameter("goods_qty"));
			customerid = request.getParameter("customerid");
			System.out.println(goodsid+", "+goods_qty+", "+customerid);
			//이 정보를 /pay/Pay.do로 다시 뿌려주시는 작업을 하면될것같아용 이상하면 연락주세요 by가은

		}else if("selectCart".equals(action)) {
			
			String selectItems = request.getParameter("selectedItems");
			System.out.println("selectItems" + selectItems);
			
		}else if("allCart".equals(action)) {
			
			String allIds = request.getParameter("allIds");
			System.out.println("allIds" + allIds);
    }

		try {
			//여기에 insert 구문 기입
			
			return;
		}catch(Exception e) {
			throw new RuntimeException(e);
		}
		
	}
}
