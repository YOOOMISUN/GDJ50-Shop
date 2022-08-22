<%@page import="java.io.File"%>
<%@page import="vo.GoodsImg"%>
<%@page import="vo.Goods"%>
<%@page import="Service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	String dir = request.getServletContext().getRealPath("/upload");
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo")); 
	String fileName = request.getParameter("fileName");
	int row = 0;	

	// 디버깅
	System.out.println("goodsNo >> " + goodsNo);
	System.out.println("fileName >> " + fileName);
	
	Goods goods = new Goods();
	goods.setGoodsNo(goodsNo);
	
	GoodsImg goodsImg = new GoodsImg();
	goodsImg.setGoodsNo(goodsNo);
	goodsImg.setFileName(fileName);
	
	//  이미 업로드 된 파일을 삭제
	File f = new File(dir + "\\" + fileName);
	if(f.exists()){ f.delete(); }
	
	GoodsService goodsService = new GoodsService();
	row = goodsService.removeGoods(goods, goodsImg);
	
	
	if(row==1){
		System.out.println("상품 삭제 성공 ");
		response.sendRedirect(request.getContextPath() + "/admin/adminGoodsList.jsp");
	} else{
		System.out.println("상품 삭제 실패 ");
		response.sendRedirect(request.getContextPath() + "/admin/adminGoodsList.jsp");
	}
	
	
%>


