<%@page import="java.util.Map"%>
<%@page import="Service.OrdersService"%>
<%@page import="vo.Orders"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo")); 
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	String customerId = request.getParameter("customerId");
	int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
	int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
	String ordersAddress = request.getParameter("ordersAddress");
	String ordersDetailAddr = request.getParameter("ordersDetailAddr");
	String ordersState = request.getParameter("ordersState");
	
	// form에서 받아온 값 디버깅
	System.out.println("goodsNo : " + goodsNo);
	System.out.println("goodsPrice : " + goodsPrice);
	System.out.println("customerId : " + customerId);
	System.out.println("orderQuantity : " + orderQuantity);
	System.out.println("orderPrice : " + orderPrice);
	System.out.println("ordersAddress : " + ordersAddress);
	System.out.println("ordersDetailAddr : " + ordersDetailAddr);
	System.out.println("ordersState : " + ordersState);
	
	Orders orders = new Orders();
	orders.setGoodsNo(goodsNo);
	orders.setCustomerId(customerId);
	orders.setOrderQuantity(orderQuantity); 
	orders.setOrderPrice(orderQuantity*goodsPrice); 
	orders.setOrderAddr(ordersAddress);
	orders.setOrderDetailAddr(ordersDetailAddr);
	orders.setOrderState(ordersState);
	
	// orders에 넣은 값 디버깅
	System.out.println("goodsNo ++ " + goodsNo);
	System.out.println("goodsPrice ++ " + goodsPrice);
	System.out.println("customerId ++ " + customerId);
	System.out.println("orderQuantity ++ " + orderQuantity);
	System.out.println("orderPrice ++ " + orderPrice);
	System.out.println("ordersAddress ++ " + ordersAddress);
	System.out.println("ordersDetailAddr ++ " + ordersDetailAddr);
	System.out.println("ordersState ++ " + ordersState);
	
	
	OrdersService ordersService = new OrdersService();
	int order = ordersService.addOrders(orders);
	
	if(order==1){
		System.out.println("주문 성공!");
		response.sendRedirect(request.getContextPath()+"/customerOrderOne.jsp?customerId="+customerId);
	} else{
		System.out.println("주문 실패!");
		response.sendRedirect(request.getContextPath()+"/customerOrderOne.jsp?customerId="+customerId);
	}
	
	
%>
