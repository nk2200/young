package com.exam.young.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		String goodsCategory = request.getParameter("goodsCategory");
		if(goodsCategory != null) {			
			GoodsDto dto = dao.getCategory(goodsCategory);
			GoodsDto dto_like = dao.getRankCategory(goodsCategory);
			
			request.setAttribute("goods", dto);
			request.setAttribute("goods_like", dto_like);
		}else {
			System.out.println("request 넘어온 goodsCategory 없음");
		}
		
		
		
		String view = "category/shop-grid.jsp";
		
		RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
		disp.forward(request, response);
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
