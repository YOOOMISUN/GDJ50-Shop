<%@page import="Service.CartService"%>
<%@page import="vo.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	int cartNo = Integer.parseInt(request.getParameter("cartNo"));
	
	// 값 제대로 넘어 왔는지 확인
	System.out.println("cartNo : " + cartNo);
	
	
	int removeCart = 0;
	CartService cartService = new CartService();
	removeCart = cartService.removeCart(cartNo);

	System.out.println("removeCart : " + removeCart);
	
	if(removeCart == 1){
		System.out.println("장바구니 삭제 성공!");
		response.sendRedirect(request.getContextPath() + "/cart.jsp");
	} else {
		System.out.println("장바구니 삭제 실패!");
		response.sendRedirect(request.getContextPath() + "/cart.jsp");
	}

%>