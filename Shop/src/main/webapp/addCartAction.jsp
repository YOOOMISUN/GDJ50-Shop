<%@page import="Service.CartService"%>
<%@page import="vo.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String customerId = (String)session.getAttribute("id");
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String goodsName = request.getParameter("goodsName");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));

	int insertCart = 0;
	
	// 디버깅
	System.out.println("customerId : " + customerId);
	System.out.println("goodsNo : " + goodsNo);
	System.out.println("goodsName : " + goodsName);
	System.out.println("goodsPrice : " + goodsPrice);
	
	Cart cart = new Cart();
	cart.setCustomerId(customerId);
	cart.setGoodsNo(goodsNo);
	cart.setGoodsName(goodsName);
	cart.setGooodsPrice(goodsPrice);
	
	// 디버깅
	System.out.println("cart : " + cart);
	
	CartService cartService = new CartService();
	insertCart = cartService.addCart(cart);
	
	// 디버깅
	System.out.println("insertCart : " + insertCart);
	System.out.println("cart >> " + cart);
	
	if(insertCart == 1){
		System.out.println("장바구니 추가 성공!");
		response.sendRedirect(request.getContextPath() + "/cart.jsp");
	} else {
		System.out.println("장바구니 추가 실패!");
		response.sendRedirect(request.getContextPath() + "/customerGoodsList.jsp");
	}
	
	
%>