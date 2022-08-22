<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.File"%>
<%@page import="vo.GoodsImg"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="vo.Goods"%>
<%@page import="Service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 한번에 업로드 될 최대 용량 => 10MB
	int max = 10*1024*1024;			
	
	// 업로드 폴더 지정(동적)
	String dir = request.getServletContext().getRealPath("/upload");
	
	MultipartRequest multiRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());

	// updateGoodsForm에서 값 불러오기
	int goodsNo = Integer.parseInt(multiRequest.getParameter("goodsNo"));
	String goodsName = multiRequest.getParameter("name");
	int goodsPrice = Integer.parseInt(multiRequest.getParameter("price"));
	String soldOut = multiRequest.getParameter("soldOut");
	
	// 디버깅
	System.out.println("goodsNo : " + goodsNo);
	System.out.println("goodsName : " + goodsName);
	System.out.println("goodsPrice : " + goodsPrice);
	System.out.println("soldOut : " + soldOut);
	System.out.println("dir : " + dir);
	
	// fileuploadForm 이미지파일 name값(imgFile)을 넘겨받음
	String contentType = multiRequest.getContentType("file"); 				// 이 파일 타입 (업로드된 파일의 타입을 반환 )
	String originFileName = multiRequest.getOriginalFileName("file"); 	// 원래 이 파일을 업로드 할때 이름 (사용자가 업로드한 파일명을 반환)
	String fileName = multiRequest.getFilesystemName("file");		

	// 이미지 파일이 아닐 경우
	if(!(contentType.equals("image/gif") || contentType.equals("image/png") || contentType.equals("image/jpeg"))){
		
		// 이미 업로드 된 파일 삭제
		File f = new File(dir + "\\" + fileName);
		if(f.exists()){f.delete();}
		
		String errorMsg = URLEncoder.encode("이미지 파일만 업로드 가능","utf-8");
		response.sendRedirect(request.getContextPath() + "/admin/adminGoodsOne.jsp?errorMsg=Image file available");
		return;
	}
	
	// Goods 객체 만들기
	Goods goods = new Goods();
	
	// goods에 값 넣어주기
	goods.setGoodsNo(goodsNo);
	goods.setGoodsName(goodsName);
	goods.setGoodsPrice(goodsPrice);
	goods.setSoldOut(soldOut);
	
	// GoodsImg 객체 만들기
	GoodsImg goodsImg = new GoodsImg();
	
	// goodsImg에 값 넣어주기
	goodsImg.setGoodsNo(goodsNo);
	goodsImg.setContentType(contentType);
	goodsImg.setOriginFileName(originFileName);
	goodsImg.setFileName(fileName);
	
	// GoodsService 객체 만들기
	GoodsService goodsService = new GoodsService();
	
	// Goods랑 GoodsImg 값 넣기
	int row = goodsService.modifyGoodsUpdate(goods, goodsImg);
	
	// 디버깅
	System.out.println("row ::: " + row);
	
	if(row == 0){	// 상품 수정 실패
		System.out.println("상품 수정 실패!");
		// 상품 수정 실패하면 상품 상세페이지로..
		response.sendRedirect(request.getContextPath() + "/admin/adminGoodsOne.jsp?goodsNo="+goodsNo);
	} else {
		System.out.println("상품 수정 성공!");
		// 상품 수정 성공하면 상품 상세페이지로..
		response.sendRedirect(request.getContextPath() + "/admin/adminGoodsOne.jsp?goodsNo="+goodsNo);
	}
	
	
%>