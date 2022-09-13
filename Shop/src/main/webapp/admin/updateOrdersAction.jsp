<%@page import="vo.Orders"%>
<%@page import="Service.OrdersService"%>
<%@page import="Repository.OrdersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 주문 상태 변경
	request.setCharacterEncoding("utf-8");
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String State = request.getParameter("State");
	
	OrdersService ordersService = new OrdersService();
	Orders orders = new Orders();
	orders.setOrderNo(ordersNo);
	orders.setOrderState(State);
	
	int row = ordersService.modifyupdateOrdersState(orders);
	
	if(row==1){
		System.out.println("수정 성공!");
		response.sendRedirect(request.getContextPath() + "/admin/adminOrdersList.jsp");
	} else {
		System.out.println("수정 실패!");
		response.sendRedirect(request.getContextPath() + "/admin/adminOrdersList.jsp");
	}
	
%>