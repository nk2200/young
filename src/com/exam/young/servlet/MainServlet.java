package com.exam.young.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.exam.young.dao.MainDao;
import com.exam.young.dto.GoodsDto;

@WebServlet("/main")
public class MainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		MainDao maindao = new MainDao();
		
        String searchName = request.getParameter("searchName");
        
        List<GoodsDto> goodsList;
        
        if (searchName != null && !searchName.isEmpty()) {
            goodsList = maindao.searchGoodsByName(searchName); 
            
            if (goodsList.isEmpty()) {
                request.setAttribute("noResult", true);
            }
        } else {
            goodsList = maindao.getRankedGoods(); 
        }

        request.setAttribute("goodsList", goodsList);

        request.getRequestDispatcher("WEB-INF/views/index.jsp").forward(request, response);
	}


}
