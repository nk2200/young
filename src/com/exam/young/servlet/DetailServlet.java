package com.exam.young.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.exam.young.dao.DetailDAO;
import com.exam.young.dto.CustomerDto;
import com.exam.young.dto.GoodsDto;



@WebServlet("/detail/Detail.do")
public class DetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	DetailDAO dao = new DetailDAO();
	
    public DetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//임시로 customer 생성
		CustomerDto customer = new CustomerDto("pororo", "뽀로로", "12345", "Antarctica");
		String customerid = customer.getCustomerid();
		
		String goodsid = request.getParameter("goodsid");
		System.out.println("getparameter goodsid: "+goodsid);
		HttpSession session = request.getSession();
//		String customerid = (String) session.getAttribute("customerid");
		String view = "shop-details.jsp";
		
		if(goodsid != null) {			
			GoodsDto goods = dao.getGoods(Integer.parseInt(goodsid));
			System.out.println(goods.toString());
			request.setAttribute("goods", goods);
			session.setAttribute("customerid", customerid);
		}else {
			System.out.println("request 넘어온 goodsid 없음");
		}
		
		
		RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
		disp.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		
		if("cart".equals(action)) {
			//장바구니 페이지 이동
			
		}
	}

}
