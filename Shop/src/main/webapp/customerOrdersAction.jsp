<%@page import="Service.OrdersService"%>
<%@page import="vo.Orders"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo")); 
	String ordersId = request.getParameter("ordersId");
	int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
	String ordersAddress = request.getParameter("ordersAddress");
	String ordersDetailAddr = request.getParameter("ordersDetailAddr");
	
	// 디버깅
	System.out.println("goodsNo : " + goodsNo);
	System.out.println("ordersId : " + ordersId);
	System.out.println("orderQuantity : " + orderQuantity);
	System.out.println("ordersAddress : " + ordersAddress);
	System.out.println("ordersDetailAddr : " + ordersDetailAddr);
	
	Orders orders = new Orders();
	orders.setGoodsNo(goodsNo);
	orders.setCustomerId(ordersId);
	orders.setOrderQuantity(orderQuantity); 
	orders.setOrderAddr(ordersAddress);
	orders.setOrderDetailAddr(ordersDetailAddr);
	
	OrdersService ordersService = new OrdersService();
	int order = ordersService.addOrders(orders);
	
	if(order==1){
		System.out.println("주문 성공!");
		response.sendRedirect(request.getContextPath()+"/customerOrdersOne.jsp?goodsNo="+goodsNo);
	} else{
		System.out.println("주문 실패!");
		response.sendRedirect(request.getContextPath()+"/customerOrdersOne.jsp?goodsNo="+goodsNo);
	}
	
	
%>
