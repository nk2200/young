
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
           
    	MyPageDao dao = new MyPageDao();
    	
        HttpSession session = request.getSession();
        String customerid = (String) session.getAttribute("customerid");
        
    	CustomerDto customer = dao.getCustomer(customerid);
    	List<OrderDto> orderList = dao.getBuyAll(customerid);
    	
        
        request.setAttribute("customer", customer);
        request.setAttribute("orderList", orderList);
        
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/mypage/mypage.jsp");
        dispatcher.forward(request, response);
    }
}