package com.exam.young.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
			List<Map<String, Object>> tempDataList = new ArrayList<>();
			Map<String, Object> goods = dao.getPrice(goodsid);
			String goodsName = (String) goods.get("goods_name");
			int goodsPrice = (int) goods.get("goods_price");
			int totalPrice = goodsPrice * goods_qty;
			
			//임시 데이터 저장
			Map<String, Object> insertInfo = new HashMap<>();	//insert될 정보 저장
			insertInfo.put("userid", customerid);
			insertInfo.put("goodsid", goodsid);
			insertInfo.put("totalPrice", totalPrice);
			insertInfo.put("goods_qty", goods_qty);
			insertInfo.put("init", 1);		// 상세상품:1, 장바구니: 2
			insertInfo.put("goodsName", goodsName);
			insertInfo.put("goodsPrice", goodsPrice);
			tempDataList.add(insertInfo);
			
            session.setAttribute("tempDataList", tempDataList);
            
			
			//정보를  jsp에 redirect 하기
            response.sendRedirect("/pay/Pay.do");
			
		
		//장바구니에서 구매하기 버튼 클릭
		}else if("selectCart".equals(action)) {
			
			String selectItems = request.getParameter("selectedItems");	//String [cartid, cartid, cartid ...]
			
			String[] selectIds = selectItems.split(",");
			for (String id: selectIds) {
			    int cartid = Integer.parseInt(id.trim());
			    //1. 상품명, 상품 가격, 고객 id, 카트 수량
			    Map<String, Object> cart = dao.getCartItems(cartid);
				int goodsid = (int) cart.get("goodsid");
				String goodsName = (String) cart.get("goods_name");
				int goodsPrice = (int) cart.get("goods_price");
				customerid = (String) cart.get("customerid");
				int cartQty = (int) cart.get("cart_qty");
				int totalPrice = goodsPrice * cartQty;
						
	            
				// 상품 데이터를 리스트로 관리
	            List<Map<String, Object>> tempDataList = (List<Map<String, Object>>) session.getAttribute("tempDataList");
	            if (tempDataList == null) {
	            	tempDataList = new ArrayList<>();
	            }

	            // 현재 상품 추가
	            Map<String, Object> item = new HashMap<>();
	            item.put("userid", customerid);
	            item.put("goodsid", goodsid);
	            item.put("totalPrice", totalPrice);
	            item.put("goods_qty", cartQty);
	            item.put("init", 2);
	            item.put("goodsName", goodsName);
	            item.put("goodsPrice", goodsPrice);
	            item.put("cartid", cartid);
	            tempDataList.add(item);

	            // 세션에 저장
	            session.setAttribute("tempDataList", tempDataList);
			    
			}
	
			response.sendRedirect("/pay/Pay.do");
			
		}else if("allCart".equals(action)) {
			
			String allIds = request.getParameter("allIds"); // String [cartid, cartid, cartid ...]
			
			String[] selectIds = allIds.split(",");
			for (String id: selectIds) {
			    int cartid = Integer.parseInt(id.trim());
			    
			    //1. 상품명, 상품 가격, 고객 id, 카트 수량
			    Map<String, Object> cart = dao.getCartItems(cartid);
				int goodsid = (int) cart.get("goodsid");
				String goodsName = (String) cart.get("goods_name");
				int goodsPrice = (int) cart.get("goods_price");
				customerid = (String) cart.get("customerid");
				int cartQty = (int) cart.get("cart_qty");
				int totalPrice = goodsPrice * cartQty;
				
				// 상품 데이터를 리스트로 관리
	            List<Map<String, Object>> tempDataList = (List<Map<String, Object>>) session.getAttribute("tempDataList");
	            if (tempDataList == null) {
	            	tempDataList = new ArrayList<>();
	            }

	            // 현재 상품 추가
	            Map<String, Object> item = new HashMap<>();
	            item.put("userid", customerid);
	            item.put("goodsid", goodsid);
	            item.put("totalPrice", totalPrice);
	            item.put("goods_qty", cartQty);
	            item.put("init", 2);
	            item.put("goodsName", goodsName);
	            item.put("goodsPrice", goodsPrice);
	            item.put("cartid", cartid);
	            tempDataList.add(item);

	            // 세션에 저장
	            session.setAttribute("tempDataList", tempDataList);
			    
			}
			
			response.sendRedirect("/pay/Pay.do");
		}

		
		//결제 버튼을 클릭했을 때
		else if ("payment".equals(action)) {
		    // 세션에서 데이터 가져오기
		    List<Map<String, Object>> insInfoList = (List<Map<String, Object>>) session.getAttribute("tempDataList");
		    List<Integer> deleteCartidList = new ArrayList<>();
		    
		    if (insInfoList == null || insInfoList.isEmpty()) {
//		        response.sendRedirect("/errorPage"); // 에러 처리 페이지로 리디렉션
		    	System.out.println("제품 리스트 없음");
		        return;
		    }
		    
		    try {
		        for (Map<String, Object> insInfo : insInfoList) {
		            int init = (int) insInfo.get("init");
		            int buyid = 0; // auto-generated ID
		            int buy_status = 1;

		            java.util.Date utilDate = new java.util.Date();
		            java.sql.Date buy_date = new java.sql.Date(utilDate.getTime());

		            String userid = (String) insInfo.get("userid");
		            int itemid = (int) insInfo.get("goodsid");
		            int total_price = (int) insInfo.get("totalPrice");
		            int buy_qty = (int) insInfo.get("goods_qty");

		            // DTO 생성
		            BuyDto buy = new BuyDto(buyid, buy_status, buy_date, userid, itemid, total_price, buy_qty);

		            // 데이터베이스에 저장
		            dao.insertBuy(buy);
		            
		            //장바구니 요청이면 장바구니 항목 삭제
		            if(init == 2) {
		            	int cartid = (int) insInfo.get("cartid");
		            	deleteCartidList.add(cartid);
		            }
		        }

		        System.out.println("결제가 완료되었습니다!");

		        // 세션 데이터 제거
		        session.removeAttribute("tempDataList");
		        
		        //장바구니 삭제
		        if(deleteCartidList.size() != 0) {
		        	for (Integer item : deleteCartidList) {
			            dao.deleteCart(item);
			        }
		        }

		        //customerid를 main에 넘겨주기
		        session.setAttribute("customerid", customerid);
		        response.sendRedirect("/");

		        return;
		    } catch (Exception e) {
		        e.printStackTrace(); // 디버깅을 위해 에러 로그 출력
		        throw new RuntimeException(e);
		    }
		}
	}
}
