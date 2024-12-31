package com.exam.young.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.exam.young.dao.RegisterDao;
import com.exam.young.dto.GoodsDto;

@WebServlet("/register/Register.do")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	RegisterDao dao = new RegisterDao();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		String view = "register/goodsList.jsp";
		
		if (action == null) {
			List<GoodsDto> goods = dao.getGoodsList();
			request.setAttribute("goods", goods);
			request.setAttribute("count", dao.getCount());
		} else if ("register".equals(action)) {
			view = "register/registerGoods.jsp";
		}
		
		RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
		disp.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		if ("insert".equals(action)) {
			GoodsDto goods = new GoodsDto();
			
			int price = Integer.parseInt(request.getParameter("goods_price"));
			int qty = Integer.parseInt(request.getParameter("goods_qty"));
			String category = request.getParameter("goods_category");
			
			goods.setGoods_name(request.getParameter("goods_name"));
			goods.setGoods_price(price);
			goods.setGoods_category(category);
			goods.setGoods_qty(qty);
			
			String goodsDirectory = "resource/img/goods";
			String imageUploadPath = getServletContext().getRealPath(goodsDirectory);
//			String imageUploadPath2 = "C:\\Users\\kosa\\git\\young\\WebContent\\resource\\img\\goods";
			System.out.println(imageUploadPath);
		    new File(imageUploadPath).mkdirs();
	        
		    for (Part part : request.getParts()) {
		    	if (part.getSubmittedFileName() != null) {
		    		String fileName = category;
		    		
		    		if ("goods_desc".equals(part.getName())) {
		    			fileName += "_desc";
		    		} else if("sub_image".equals(part.getName())) {
		    			fileName += "_1";
		    		}
		    		fileName += "_" + System.currentTimeMillis() + ".jpg";
		    		
		    		if (fileName != null && !fileName.isEmpty()) {
		    			String filePath = imageUploadPath + File.separator + fileName;
		    			saveFile(part.getInputStream(), filePath);
//		    			saveFile(part.getInputStream(), imageUploadPath2 + File.separator + fileName);
		    		}
		    		
		    		if ("goods_desc".equals(part.getName())) {
		    			goods.setGoods_desc(goodsDirectory + "/" + fileName);
		    		} else if("main_image".equals(part.getName())) {
		    			goods.setGoods_fname_main(goodsDirectory + "/" + fileName);
		    		} else {
						goods.setGoods_fname_sub(goodsDirectory + "/" + fileName);
					}
		    	}
	            
	        }
		    System.out.println(goods);
		    
			try {
				dao.insertGoods(goods);
				response.sendRedirect("/register/Register.do");
			} catch (Exception e) {
				response.sendRedirect("/register/Register.do?action=register");
			}
		}
		
		
	}
	
	private void saveFile(InputStream inputStream, String path) throws IOException {
        try (FileOutputStream outputStream = new FileOutputStream(path)) {
            int read;
            final byte[] bytes = new byte[1024];
            while ((read = inputStream.read(bytes)) != -1) {
                outputStream.write(bytes, 0, read);
            }
        }
    }

}
