
package com.exam.young.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.exam.young.dao.CustomerDao;

// 마이페이지 서블릿,yhl
@WebServlet("/MyPage.do")
public class MyPageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
           
    	String userId = request.getParameter("userId");
    	
    	if(userId != null) {
	        HttpSession session = request.getSession();
	        session.setAttribute("userId", userId);
	
	        // 유저 아이디로 데이터베이스에서 유저 정보를 조회
	        CustomerDao userDAO = new CustomerDao();
	        //CustomerDao user = userDAO.getUserInfo(userId);
    	}
        // 유저 정보를 JSP에 전달
        request.setAttribute("user", user);

        // 마이페이지 JSP로 포워드
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/mypage/mypage.jsp");
        dispatcher.forward(request, response);
    }
}