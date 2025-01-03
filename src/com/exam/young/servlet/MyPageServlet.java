
package com.exam.young.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.exam.young.dao.CustomerDao;
import com.exam.young.dao.MyPageDao;
import com.exam.young.dto.BuyDto;
import com.exam.young.dto.CustomerDto;
import com.exam.young.dto.GoodsDto;
import com.exam.young.dto.OrderDto;

// 마이페이지 서블릿,yhl
@WebServlet("/mypage/MyPage.do")
public class MyPageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
           
    	//String userId = request.getParameter("userId");
    	MyPageDao dao = new MyPageDao();
    	
        HttpSession session = request.getSession();
        String customerid = (String) session.getAttribute("customerid");
        
    	CustomerDto customer = dao.getCustomer(customerid);
    	List<OrderDto> orderList = dao.getBuyAll(customerid);
    	
    	//if(userId != null) {
//	        HttpSession session = request.getSession();
//	        session.setAttribute("userId", "유혜린");
	
	        // 유저 아이디로 데이터베이스에서 유저 정보를 조회
//	        CustomerDao userDAO = new CustomerDao();
	        //CustomerDao user = userDAO.getUserInfo(userId);
    	//}
        
        request.setAttribute("customer", customer);
        request.setAttribute("orderList", orderList);
        
        
        HttpSession session = request.getSession();
        String customerId = (String) session.getAttribute("customerId");
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/mypage/mypage.jsp");
        dispatcher.forward(request, response);
    }
}