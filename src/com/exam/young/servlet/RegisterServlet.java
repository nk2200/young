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
import javax.servlet.http.Part;

import com.exam.young.dao.RegisterDao;
import com.exam.young.dto.GoodsDto;
import com.exam.young.dto.SearchDto;

@WebServlet("/register/Register.do")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 3, // 3MB
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
			String searchName = request.getParameter("searchName");
			String category = request.getParameter("category");
			
			int count = dao.getCount(searchName, category);
			int pageSize = 9;
			int totalPages = (int) Math.ceil((double) count / pageSize);
			String page = request.getParameter("page");
			int pageNumber = 0;
			if (page == null) {
				pageNumber = 1;
			} else {
				pageNumber = Integer.parseInt(page);
			}
			
			List<GoodsDto> goods;
			if (searchName == null && category == null) {
				goods = dao.getGoodsList(pageNumber, pageSize);
			} else if (category == null) {
				SearchDto search = new SearchDto(searchName, "name", pageNumber, pageSize);
				goods = dao.searchGoods(search);
			} else {
				SearchDto search = new SearchDto(category, "category", pageNumber, pageSize);
				goods = dao.searchGoods(search);
			}
			
			if (goods.isEmpty()) {
                request.setAttribute("noResult", true);
            }
			request.setAttribute("goods", goods);
			request.setAttribute("count", count);
			request.setAttribute("page", pageNumber);
			request.setAttribute("totalPages", totalPages);
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
		
		String view = "/register/Register.do";
		String searchName = request.getParameter("searchName");
		String searchCate = request.getParameter("searchCate");
		String page = request.getParameter("page");
		boolean hasCondition = false;
		
		StringBuffer url = new StringBuffer(view);
		if (!"".equals(page) && page != null) {
			url.append("?page=" + page);
			hasCondition = true;
		}
		if (!"".equals(searchName) && searchName != null) {
			if (hasCondition) {
				url.append("&");
			} else {
				url.append("?");
				hasCondition = true;
			}
			url.append("searchName=" + searchName);
		}
		if (!"".equals(searchCate) && searchCate != null) {
			if (hasCondition) {
				url.append("&");
			} else {
				url.append("?");
			}
			url.append("category=" + searchCate);
		}
		view = url.toString();
		
		String imageUploadPath = getServletContext().getRealPath("resource/img/goods");
		new File(imageUploadPath).mkdirs();
		
		if ("insert".equals(action)) {
			GoodsDto goods = setGoodsDto(request);
			
		    for (Part part : request.getParts()) {
		    	if (part.getSubmittedFileName() != null && part.getSize() > 0) {
		    		String fileName = getFileName(goods.getGoods_category(), part);
		    		
		    		if (fileName != null) {
		    			String filePath = imageUploadPath + File.separator + fileName;
		    			saveFile(part.getInputStream(), filePath);
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
				response.sendRedirect(view);
			} catch (Exception e) {
				response.sendRedirect(view + "?action=register");
			}
		} else if ("update".equals(action)) {
			int goodsid = Integer.parseInt(request.getParameter("goodsid"));
			if (goodsid == 0) {
				throw new RuntimeException("상품이 존재하지 않습니다.");
			} else {
				GoodsDto goods = setGoodsDto(request);
				goods.setGoodsid(goodsid);
				
				//이전 이미지 경로
				String desc = request.getParameter("current_desc_path");
				String mainImage = request.getParameter("current_main_path");
				String subImage = request.getParameter("current_sub_path");
				
				for (Part part : request.getParts()) {
					String partName = part.getName();
			    	if (part.getSubmittedFileName() != null && part.getSize() > 0) {
			    		String newFileName = getFileName(goods.getGoods_category(), part);
			    		
			    		if ("goods_desc".equals(partName)) {
			    			deleteFile(imageUploadPath, desc);
				    		desc = newFileName;
				    	} else if("main_image".equals(partName)) {
				    		deleteFile(imageUploadPath, mainImage);
				    		mainImage = newFileName;
				    	} else {
				    		deleteFile(imageUploadPath, subImage);
				    		subImage = newFileName;
				    	}
			    		
		    			String filePath = imageUploadPath + File.separator + newFileName;
		    			saveFile(part.getInputStream(), filePath);
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
				response.sendRedirect(view);
			}
		} else if ("delete".equals(action)) {
			int goodsid = Integer.parseInt(request.getParameter("goodsid"));
			if (goodsid != 0) {
				dao.deleteGoods(goodsid);
				
				String desc = request.getParameter("current_desc_path");
				String mainImage = request.getParameter("current_main_path");
				String subImage = request.getParameter("current_sub_path");
    			deleteFile(imageUploadPath, desc);
	    		deleteFile(imageUploadPath, mainImage);
	    		deleteFile(imageUploadPath, subImage);
				
				response.sendRedirect(view);
			} else {
				throw new RuntimeException("상품이 존재하지 않습니다.");
			}
		}
	}
	
	private GoodsDto setGoodsDto(HttpServletRequest request) {
		int price = 0;
		int qty = 0;
		try {
			price = Integer.parseInt(request.getParameter("goods_price"));
			qty = Integer.parseInt(request.getParameter("goods_qty"));
		} catch (NumberFormatException e) {
			System.out.println(e.getMessage());
		}
		GoodsDto goods = new GoodsDto();
		
		goods.setGoods_name(request.getParameter("goods_name"));
		goods.setGoods_price(price);
		goods.setGoods_category(request.getParameter("goods_category"));
		goods.setGoods_qty(qty);
		return goods;
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
		String fileName = category + "_" + System.currentTimeMillis();
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
