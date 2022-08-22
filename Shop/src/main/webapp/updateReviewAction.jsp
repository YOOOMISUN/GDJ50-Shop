<%@page import="Service.ReviewService"%>
<%@page import="vo.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	int goodsNo = Integer.parseInt(request.getParameter("goodsNo")); 
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo")); 
	String updateReviewContent = request.getParameter("updateReviewContent");
	String updateDate = request.getParameter("updateDate");
	
	// 디버깅
	System.out.println("goodsNo % " + goodsNo);
	System.out.println("reviewNo % " + reviewNo);
	System.out.println("updateReviewContent % " + updateReviewContent);
	System.out.println("updateDate % " + updateDate);
	
	Review review = new Review();
	review.setGoodsNo(goodsNo);
	review.setReviewNo(reviewNo);
	review.setReviewContent(updateReviewContent);
	review.setUpdateDate(updateDate);
	
	ReviewService reviewService = new ReviewService();
	int row = reviewService.modifyReview(review);
	
	if(row==1){
		System.out.println("수정 성공");
		response.sendRedirect(request.getContextPath()+"/customerGoodsOne.jsp?goodsNo="+goodsNo);
	} else{
		System.out.println("수정 실패");
		response.sendRedirect(request.getContextPath()+"/customerGoodsOne.jsp?goodsNo="+goodsNo);
	}
%>