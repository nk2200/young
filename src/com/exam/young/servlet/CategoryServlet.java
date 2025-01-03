package com.exam.young.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.exam.young.dao.CategoryDao;
import com.exam.young.dto.GoodsDto;

/**
 * Servlet implementation class CategoryServlet
 */
@WebServlet("/category/Category.do")
public class CategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	CategoryDao dao = new CategoryDao();
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String customerid = (String) session.getAttribute("customerid");

		if(customerid == null) {
			request.setAttribute("message", "로그인하지 않은 사용자입니다. 다시 로그인해주세요.");
			String view ="/login.jsp";
			
			RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
			disp.forward(request, response);
		}
		
		String goodsCategory = request.getParameter("goodsCategory");
		String action = request.getParameter("action");
		String view ="";
		
		if("selectMain".equals(action)) {
			System.out.println("customerid" + customerid);
			if(goodsCategory != null) {			
				List <GoodsDto> dto = dao.getCategory(goodsCategory);
				List<GoodsDto> dto_like = dao.getRankCategory(goodsCategory);
				int goods_count = dao.getGoodsCount(goodsCategory);
				
				
				request.setAttribute("goods", dto);
				request.setAttribute("goods_like", dto_like);
				request.setAttribute("goods_count", goods_count);
				request.setAttribute("goodsCategory",goodsCategory);
				session.setAttribute("customerid", customerid);
				view = "category/shop-grid.jsp";
			}else {
				System.out.println("request 넘어온 goodsCategory 없음");
			}
		}else if("selectRank".equals(action)) {
			System.out.println("customerid" + customerid);
			if(goodsCategory != null) {			
				if("all".equals(goodsCategory)) {
					List<GoodsDto> dto_like = dao.getRankAll_20(goodsCategory);
					request.setAttribute("goods_like", dto_like);
				}else {
					List<GoodsDto> dto_like = dao.getRankCategory_20(goodsCategory);
					request.setAttribute("goods_like", dto_like);
				}
				request.setAttribute("goodsCategory", goodsCategory);
				session.setAttribute("customerid", customerid);
				view = "category/select_rank.jsp";
			}else {
				System.out.println("request 넘어온 goodsCategory 없음");
			}
		}
		
		
		RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
		disp.forward(request, response);
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
