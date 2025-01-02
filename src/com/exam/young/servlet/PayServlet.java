package com.exam.young.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.exam.young.dao.BuyDao;
import com.exam.young.dto.BuyDto;
import com.exam.young.dao.CartDao;
import com.exam.young.dto.CartDto;

/**
 * Servlet implementation class PayServlet
 */
@WebServlet("/pay/Pay.do")
public class PayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	BuyDao dao = new BuyDao();
	CartDao cartdao = new CartDao();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String view = "checkout.jsp";
		
		RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
		disp.forward(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String action = request.getParameter("action");
		HttpSession session = request.getSession();
		String customerid = (String) session.getAttribute("customerid");
		
		//detail에서 구매하기 버튼 클릭
		if("detail".equals(action)) {
			int goodsid = Integer.parseInt(request.getParameter("goodsid"));
			int goods_qty = Integer.parseInt(request.getParameter("goods_qty"));
			customerid = request.getParameter("customerid");
			
			//1. 상품명, 가격 가져오기
			Map<String, Object> goods = dao.getPrice(goodsid);
			String goodsName = (String) goods.get("goods_name");
			goodsName = URLEncoder.encode(goodsName,"utf-8");	//한글 깨짐 오류 수정
			int goodsPrice = (int) goods.get("goods_price");
			int totalPrice = goodsPrice * goods_qty;
			
			//임시 데이터 저장
			Map<String, Object> insertInfo = new HashMap<>();	//insert될 정보 저장
			insertInfo.put("userid", customerid);
			insertInfo.put("goodsid", goodsid);
			insertInfo.put("totalPrice", totalPrice);
			insertInfo.put("goods_qty", goods_qty);
			insertInfo.put("init", 1);		// 상세상품:1, 장바구니: 2
            session.setAttribute("tempData", insertInfo);
            
			
			//아래의 정보들  jsp에 redirect 하기
			String redirectURL = String.format("/pay/Pay.do?goodsName=%s&goods_qty=%d&price=%d&totalPrice=%d",
	                goodsName, goods_qty, goodsPrice, totalPrice);
	        response.sendRedirect(redirectURL);
			
		
		//장바구니에서 구매하기 버튼 클릭
		}else if("cart".equals(action)) {
			int cartid = Integer.parseInt(request.getParameter("cartid"));
			
			//1. 상품명, 상품 가격, 고객 id, 카트 수량
			Map<String, Object> cart = dao.getCartItems(cartid);
			int goodsid = (int) cart.get("goodsid");
			String goodsName = (String) cart.get("goods_name");
			int goodsPrice = (int) cart.get("goods_price");
			customerid = (String) cart.get("customerid");
			int cartQty = (int) cart.get("cart_qty");
			int totalPrice = goodsPrice * cartQty;
			
			//임시 데이터 저장
			Map<String, Object> insertInfo = new HashMap<>();	//insert될 정보 저장
			insertInfo.put("userid", customerid);
			insertInfo.put("goodsid", goodsid);
			insertInfo.put("totalPrice", totalPrice);
			insertInfo.put("goods_qty", cartQty);
			insertInfo.put("init", 2);		// 상세상품:1, 장바구니: 2
            session.setAttribute("tempData", insertInfo);
			
			dao.deleteCart(cartid);

		}else if("selectCart".equals(action)) {
			
			String selectItems = request.getParameter("selectedItems");
			System.out.println("selectItems" + selectItems);
			
		}else if("allCart".equals(action)) {
			
			String allIds = request.getParameter("allIds");
			System.out.println("allIds" + allIds);
    }

		
		//결제 버튼을 클릭했을 때(수정 필요)
		else if("payment".equals(action)) {
			Map<String, Object> insInfo = (Map<String, Object>) session.getAttribute("tempData");
			System.out.println(insInfo.get("init"));
			int buyid = 0;
			int buy_status = 1;
			
			java.util.Date utilDate = new java.util.Date();
		    java.sql.Date buy_date = new java.sql.Date(utilDate.getTime());
		    
		    String userid = (String)insInfo.get("userid");
		    int itemid = (int) insInfo.get("goodsid");
			int total_price = (int) insInfo.get("totalPrice");
			int buy_qty = (int) insInfo.get("goods_qty");
		    
			BuyDto buy = new BuyDto(buyid, buy_status, buy_date, userid, itemid, total_price, buy_qty);
			
			try {
				//여기에 insert 구문 기입
				dao.insertBuy(buy);
				System.out.println("결제가 완료 되었습니다!");
				
				//남은 상품 수량 변경 -- 수정 필
//                dao.updateGoodsQty(buy_qty, itemid);
				
				// 세션 데이터 제거
                session.removeAttribute("tempData");

				response.sendRedirect("/");
				return;
			}catch(Exception e) {
				throw new RuntimeException(e);
			}
		}
	}
}
