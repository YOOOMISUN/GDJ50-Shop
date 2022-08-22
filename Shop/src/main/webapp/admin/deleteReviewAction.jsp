<%@page import="Service.ReviewService"%>
<%@page import="vo.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int row = 0;
	
	// 디버깅
	System.out.println("reviewNo" + reviewNo);
	System.out.println("goodsNo" + goodsNo);
	
	ReviewService reviewService = new ReviewService();
	row = reviewService.removeReview(reviewNo);

	if(row==1){
		System.out.println("삭제 성공!");
		response.sendRedirect(request.getContextPath() + "/admin/adminGoodsOne.jsp?goodsNo="+goodsNo);
	} else {
		System.out.println("삭제 실패!");
		response.sendRedirect(request.getContextPath() + "/admin/adminGoodsOne.jsp?goodsNO="+goodsNo);
	}
	
%>