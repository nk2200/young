package com.exam.young.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.exam.young.dao.MainDao;
import com.exam.young.dto.GoodsDto;

@WebServlet("/main")
public class MainServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");
        String searchName = request.getParameter("searchName");
        
		MainDao maindao = new MainDao();
        
        List<GoodsDto> goodsList;
        
        if (searchName != null && !searchName.isEmpty()) {
            goodsList = maindao.searchGoodsByName(searchName); 
            
            if (goodsList.isEmpty()) {
                request.setAttribute("noResult", true);
            }
        } else {
            goodsList = maindao.getRankedGoods(); 
        }

//        if ("search".equals(action) && searchName != null && !searchName.isEmpty()) {
//            goodsList = maindao.searchGoodsByName(searchName);
//            
//            // 검색 결과가 없으면 noResult 속성 추가
//            if (goodsList.isEmpty()) {
//                request.setAttribute("noResult", true);
//            }
//        }
//        // action이 "rank"일 경우, 랭킹 조회
//        else if ("rank".equals(action)) {
//            goodsList = maindao.getRankedGoods();
//        }
//        // action이 없거나 "rank"와 "search" 외의 값일 경우 기본 랭킹 조회
//        else {
//            goodsList = maindao.getRankedGoods();
//        }
        
        request.setAttribute("goodsList", goodsList);
        
        HttpSession session = request.getSession();
        session.setAttribute("customerId", "yhl9701");

        request.getRequestDispatcher("WEB-INF/views/index.jsp").forward(request, response);
	}


}
