<%@page import="Service.GoodsService"%>
<%@page import="vo.GoodsImg"%>
<%@page import="vo.Goods"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.*" %>
<%@ page import = "com.oreilly.servlet.multipart.*" %>
<%
	String dir = request.getServletContext().getRealPath("/upload");
	
	// 디버깅
	System.out.println(dir);
	
	int max = 30*1024*1024;		// 30MB
	
	MultipartRequest mRequest = new MultipartRequest(request,dir,max,"utf-8", new DefaultFileRenamePolicy());
	
	String name = mRequest.getParameter("name");
	int price = Integer.parseInt(mRequest.getParameter("price"));
	
	String type = mRequest.getContentType("file");
	String originalName = mRequest.getOriginalFileName("file");
	String fileName = mRequest.getFilesystemName("file");		
	
	// 디버깅
	System.out.println(type + "<= type");
	System.out.println(originalName + "<= originalName");
	System.out.println(fileName + "<= fileName"); 
	
	// 이미지 파일이 아닐 경우
	if(!(type.equals("image/gif") || type.equals("image/png") || type.equals("image/jpeg"))){
		
		// 이미 업로드 된 파일 삭제
		File f = new File(dir + "\\" + fileName);
		if(f.exists()){f.delete();}
		
		String errorMsg = URLEncoder.encode("이미지 파일만 업로드 가능","utf-8");
		response.sendRedirect(request.getContextPath() + "/admin/addGoodsForm.jsp?errorMsg=Image file available");
		return;
	}
	
	Goods goods = new Goods();
	GoodsImg goodsImg = new GoodsImg();
	
	GoodsService goodsService = new GoodsService();
	
	goods.setGoodsName(name);
	goods.setGoodsPrice(price);
	
	// 디버깅
	System.out.println(goods + "<= goods");
	
	goodsImg.setContentType(type);	
	goodsImg.setOriginFileName(originalName);
	goodsImg.setFileName(fileName);
	
	// 디버깅
	System.out.println(goodsImg + "<= goodsImg");
	
	int row = goodsService.addGoods(goods, goodsImg);
	
	// 디버깅
	System.out.println(row + "<= row");
	
	if(row==0){		// 상품 추가 실패
		System.out.println("상품 추가 실패");
		response.sendRedirect(request.getContextPath() + "/admin/addGoodsForm.jsp");
	} else {		// 상품 추가 성공
		System.out.println("상품 추가 성공");
		response.sendRedirect(request.getContextPath() + "/admin/adminGoodsList.jsp");
	}
%>








