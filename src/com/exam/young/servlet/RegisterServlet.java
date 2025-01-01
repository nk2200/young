package com.exam.young.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
	private static final String GOODS_DIRECTORY = "resource/img/goods";
     
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
		} else if ("update".equals(action)) {
			int goodsid = Integer.parseInt(request.getParameter("goodsid"));
			request.setAttribute("goods", dao.getOneGoods(goodsid));
			view = "register/updateGoods.jsp";
		} else if ("delete".equals(action)) {
			int goodsid = Integer.parseInt(request.getParameter("goodsid"));
			request.setAttribute("goods", dao.getOneGoods(goodsid));
			view = "register/deleteGoods.jsp";
		}
		
		RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
		disp.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		
		String imageUploadPath = getServletContext().getRealPath("");
//		String imageUploadPath2 = "C:\\dev\\young\\WebContent";
		new File(imageUploadPath).mkdirs();
		
		if ("insert".equals(action)) {
			GoodsDto goods = new GoodsDto();
			
			int price = Integer.parseInt(request.getParameter("goods_price"));
			int qty = Integer.parseInt(request.getParameter("goods_qty"));
			String category = request.getParameter("goods_category");
			
			goods.setGoods_name(request.getParameter("goods_name"));
			goods.setGoods_price(price);
			goods.setGoods_category(category);
			goods.setGoods_qty(qty);
			
		    for (Part part : request.getParts()) {
		    	if (part.getSubmittedFileName() != null && part.getSize() > 0) {
		    		String fileName = getFileName(category, part);
		    		
		    		if (fileName != null) {
		    			String filePath = imageUploadPath + File.separator + fileName;
		    			saveFile(part.getInputStream(), filePath);
//		    			saveFile(part.getInputStream(), imageUploadPath2 + File.separator + fileName);
		    		}
		    		
		    		if ("goods_desc".equals(part.getName())) {
		    			goods.setGoods_desc(fileName);
		    		} else if("main_image".equals(part.getName())) {
		    			goods.setGoods_fname_main(fileName);
		    		} else {
						goods.setGoods_fname_sub(fileName);
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
		} else if ("update".equals(action)) {
			int goodsid = Integer.parseInt(request.getParameter("goodsid"));
			if (goodsid == 0) {
				throw new RuntimeException("상품이 존재하지 않습니다.");
			} else {
				GoodsDto goods = new GoodsDto();
				
				int price = Integer.parseInt(request.getParameter("goods_price"));
				int qty = Integer.parseInt(request.getParameter("goods_qty"));
				String category = request.getParameter("goods_category");
				
				goods.setGoodsid(goodsid);
				goods.setGoods_name(request.getParameter("goods_name"));
				goods.setGoods_price(price);
				goods.setGoods_category(category);
				goods.setGoods_qty(qty);
				
				//이전 이미지 경로
				String desc = request.getParameter("oldDescPath");
				String mainImage = request.getParameter("oldMainPath");
				String subImage = request.getParameter("oldSubPath");
				
				for (Part part : request.getParts()) {
					String partName = part.getName();
			    	if (part.getSubmittedFileName() != null && part.getSize() > 0) {
			    		String newFileName = getFileName(category, part);
			    		
			    		if ("goods_desc".equals(partName)) {
			    			deleteFile(imageUploadPath, desc);
//			    			deleteFile(imageUploadPath2, desc);
				    		desc = newFileName;
				    	} else if("main_image".equals(partName)) {
				    		deleteFile(imageUploadPath, mainImage);
//				    		deleteFile(imageUploadPath2, mainImage);
				    		mainImage = newFileName;
				    	} else {
				    		deleteFile(imageUploadPath, subImage);
//				    		deleteFile(imageUploadPath2, subImage);
				    		subImage = newFileName;
				    	}
			    		
		    			String filePath = imageUploadPath + File.separator + newFileName;
		    			saveFile(part.getInputStream(), filePath);
//		    			saveFile(part.getInputStream(), imageUploadPath2 + File.separator + newFileName);
			    	}
			    	
			    	if ("goods_desc".equals(part.getName())) {
			    		goods.setGoods_desc(desc);
			    	} else if("main_image".equals(part.getName())) {
			    		goods.setGoods_fname_main(mainImage);
			    	} else {
			    		goods.setGoods_fname_sub(subImage);
			    	}
		        }
				
				goods.setGoods_desc(desc);
				goods.setGoods_fname_main(mainImage);
				goods.setGoods_fname_sub(subImage);
				
				System.out.println(goods);
				dao.updateGoods(goods);
				response.sendRedirect("/register/Register.do");
			}
		} else if ("delete".equals(action)) {
			int goodsid = Integer.parseInt(request.getParameter("goodsid"));
			if (goodsid != 0) {
				dao.deleteGoods(goodsid);
				response.sendRedirect("/register/Register.do");
			} else {
				throw new RuntimeException("상품이 존재하지 않습니다.");
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
	
	private String getFileName(String category, Part part) {
		String fileName = GOODS_DIRECTORY + "/" + category + "_" + System.currentTimeMillis();
		if ("goods_desc".equals(part.getName())) {
			fileName += "_desc";
		} else if("sub_image".equals(part.getName())) {
			fileName += "_1";
		}
		fileName += ".jpg";
		return fileName;
	}
	
	private void deleteFile(String directory, String fileName) {
        if (fileName != null && !fileName.isEmpty()) {
            File oldFile = new File(directory + File.separator + fileName);
            if (oldFile.exists()) {
                oldFile.delete();
            }
        }
    }

}
