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
		String goodsid = request.getParameter("goodsid");
		System.out.println("getparameter goodsid: "+goodsid);
		//세션 가져오기
		HttpSession session = request.getSession();
		String customerid = (String) session.getAttribute("customerid");
		if (customerid == null) {
			request.setAttribute("message", "로그인하지 않은 사용자입니다. 다시 로그인해주세요.");
			String view = "/login.jsp";

			RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
			disp.forward(request, response);
			return;
		}
		
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
		HttpSession session = request.getSession();
		String customerid= (String) session.getAttribute("customerid");
		
		if (customerid == null) {
			request.setAttribute("message", "로그인하지 않은 사용자입니다. 다시 로그인해주세요.");
			String view = "/login.jsp";

			RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
			disp.forward(request, response);
			return;
		}
		
		if("likesPlus".equals(action)) {
			int goodsid = Integer.parseInt(request.getParameter("goodsid"));
			int updated_likes = dao.updateGoodsLikes(goodsid);
			//응답내용
			//json형식으로 데이터 전달
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        
	        session.setAttribute("customerid", customerid);
	        
	        String json = "{\"message\": \"좋아요를 추가하셨습니다.\", \"updated_likes\": " + updated_likes + "}";
	        response.getWriter().write(json);
	        
	        
	        
		}else if("likesMinus".equals(action)) {
			int goodsid = Integer.parseInt(request.getParameter("goodsid"));
			int updated_likes = dao.minusGoodsLikes(goodsid);
			// 응답 내용
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        
	        session.setAttribute("customerid", customerid);
	        
	        String json = "{\"message\": \"좋아요를 취소하셨습니다.\", \"updated_likes\": " + updated_likes + "}";
	        response.getWriter().write(json);
		}
	}

}
