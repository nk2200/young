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
//		String action = request.getParameter("action");
		String goodsid = request.getParameter("goodsid");
		System.out.println("getparameter goodsid: "+goodsid);
		HttpSession session = request.getSession();
		String view = "/WEB-INF/views/shop-details.jsp";
		
		if(goodsid != null) {			
			GoodsDto goods = dao.getGoods(Integer.parseInt(goodsid));
			System.out.println(goods.toString());
			request.setAttribute("goods", goods);
		}else {
			System.out.println("request 넘어온 goodsid 없음");
		}
		
		
		RequestDispatcher disp = request.getRequestDispatcher(view);
		disp.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
