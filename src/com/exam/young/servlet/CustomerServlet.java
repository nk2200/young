package com.exam.young.servlet;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.exam.young.dao.CustomerDao;
import com.exam.young.dto.CustomerDto;

@WebServlet("/customer/Login.do")
public class CustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    CustomerDao dao = new CustomerDao();
    public CustomerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String view = "login.jsp";
		String action = request.getParameter("action");
		if(action!=null) {
			if("logout".equals(action)) {
				request.getSession().invalidate();
				response.sendRedirect("/main");
				return;
			}else if("signup".equals(action)) {
				view = "signup.jsp";
			}
		}
		
		RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
		disp.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		//로그인
		HttpSession session = request.getSession();
		
		String action = request.getParameter("action");
		if("login".equals(action)) {
			try {
				String customerid = request.getParameter("customerid");
				String password = request.getParameter("password");
				String dbpw = dao.getPassword(customerid);
				if(dbpw!=null) {
					if(dbpw.equals(password)) {
						session.setAttribute("customerid", customerid);
						response.setContentType("application/json");
				        response.setCharacterEncoding("UTF-8");
				        String json = "{\"result\": \"success\"}";
				        System.out.println("success");
				        response.getWriter().write(json);
//						String url = "/main";
//						response.sendRedirect(url);
				        return;
					}else {
						System.out.println("dbpw: "+dbpw);
						response.setContentType("application/json");
				        response.setCharacterEncoding("UTF-8");
				        String json = "{\"message\": \"비밀번호가 다릅니다.\", \"result\": \"fail\"}";
				        response.getWriter().write(json);
//						String url = "/customer/Login.do?message=" + URLEncoder.encode("비밀번호가 다릅니다.", "UTF-8");
//						response.sendRedirect(url);
						System.out.println("비밀번호 틀림");
						return;
					}
				}else {
					System.out.println("아이디 없음!!");
					String url = "/customer/Login.do?action=signup";
					response.sendRedirect(url);
					
				}
			}catch(Exception e) {
				System.out.println("customerservlet 예외:"+e.getMessage());
			}
			
		}else if("signup".equals(action)) {
			try {
				String customerid = request.getParameter("customerid");
				String customer_name = request.getParameter("customer_name");
				String password = request.getParameter("password");
				String customer_address = request.getParameter("customer_address");
				CustomerDto customer = new CustomerDto(customerid, customer_name, password, customer_address);
				System.out.println(customer.toString());
				dao.insertCustomer(customer);
				
				response.setContentType("application/json");
		        response.setCharacterEncoding("UTF-8");
		        String json = "{\"message\": \"회원가입에 성공하였습니다.\", \"result\": \"success\"}";
		        System.out.println("success");
		        response.getWriter().write(json);
		        
				/*
				 * String url = "/customer/Login.do"; response.sendRedirect(url);
				 */
			}catch(Exception e) {
				System.out.println("customerservlet 예외:"+e.getMessage());
			}
		}
		
	}

}
