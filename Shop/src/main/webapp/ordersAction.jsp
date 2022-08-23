<%@page import="vo.Orders"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo")); 
	String customerId = request.getParameter("customerId");
	String orderQuantity = request.getParameter("orderQuantity");
	String ordersAddress = request.getParameter("ordersAddress");
	String ordersDetailAddr = request.getParameter("ordersDetailAddr");
	
	Orders orders = new Orders();
	orders.setGoodsNo(goodsNo);
	orders.setCustomerId(customerId);
	
	
	
%>
