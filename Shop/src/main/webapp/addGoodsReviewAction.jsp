<%@page import="Service.ReviewService"%>
<%@page import="Service.GoodsService"%>
<%@page import="vo.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
	request.setCharacterEncoding("utf-8");
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String customerId = request.getParameter("customerId");
	String reviewContent = request.getParameter("reviewContent");
	int insertReview = 0;
	
	// 디버깅
	System.out.println("goodsNo : " + goodsNo);
	System.out.println("customerId : " + customerId);
	System.out.println("reviewContent : " + reviewContent);
	
	Review review= new Review();
	review.setGoodsNo(goodsNo);
	review.setCustomerId(customerId);
	review.setReviewContent(reviewContent);
	
	ReviewService reviewService = new ReviewService();
	insertReview = reviewService.addReview(review);
	
	if(insertReview == 1){
		System.out.println("리뷰 추가 성공!");
		response.sendRedirect(request.getContextPath() + "/admin/adminGoodsOne.jsp?goodsNo="+goodsNo);
	} else {
		System.out.println("리뷰 추가 실패!");
		response.sendRedirect(request.getContextPath() + "/admin/adminGoodsList.jsp?goodsNo="+goodsNo);
	}
%>