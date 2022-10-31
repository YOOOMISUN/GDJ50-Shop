<%@page import="java.util.Map"%>
<%@page import="Service.OrdersService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인 안되어 있거나 user가 Employee가 아니면 로그인 폼으로...
	if(session.getAttribute("id") == null || (!(session.getAttribute("user").equals("Employee"))) ){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	} 
	
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	Map<String, Object> map = null;
	OrdersService orderService = new OrdersService();
	
	map = orderService.getOrdersOne(ordersNo);
	
	// 디버깅
	System.out.println("map :: " + map);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>▶관리자◀ Orders One</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

	<!-- Header -->
	<%@ include file="/inc/Header.jsp" %>
	

<div class="container">
	<!-- 목록 -->
	<div>
		<br>
		<table style="margin-left:auto; margin-right:auto; text-align:center;" class="table table-bordered" >
			<tr>
				<td><a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">고객관리</a></td>
				<td><a href="<%=request.getContextPath()%>/admin/employeeList.jsp">사원관리</a></td>
				<td><a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">상품	관리</a></td>	<!-- 상품목록/등록/수정/삭제(장바구니,주문이 없는 경우=> 품절처리) -->
				<td><a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">주문관리</a></td><!-- 주문목록/수정 -->
				<td><a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp">공지관리(게시판)</a></td><!-- 공지 CRUD -->
			</tr>
		</table>
	</div>
	
	<br>
	<br>

	<div style="text-align:center;">
		<h2 style="font-weight :bold;">주문 상세페이지</h2>
			<br>
			<br>
			<table style=" margin-left:auto; margin-right:auto; text-align:center;" class="table table-bordered" >
				<thead>
					<tr>
						<th>Order No</th>
						<th>Customer Id</th>
						<th>Goods Name</th>
						<th>Goods Price</th>
						<th>Order Quantity</th>
						<th>Order Price</th>
						<th>Customer Name</th>
						<th>Customer Address</th>
						<th>Customer Telephone</th>
						<th>Order Address</th>
						<th>Order State</th>
						<th>Create Date</th>
						<th>Update Date</th>
					</tr>	
				</thead>
				<tbody>
					<tr>
						<td><%=map.get("orderNo")%></td>
						<td><%=map.get("customerId")%></td>
						<td><%=map.get("goodsName")%></td>
						<td><%=map.get("goodsPrice")%></td>
						<td><%=map.get("orderQuantity")%></td>
						<td><%=map.get("orderPrice") %></td>
						<td><%=map.get("customerName")%></td>
						<td><%=map.get("customerAddress")%> <%=map.get("orderDetailAddr") %></td>
						<td><%=map.get("customerTelephone")%></td>
						<td><%=map.get("orderAddr")%> <%=map.get("orderDetailAddr")%></td>
						<td><%=map.get("orderState")%></td>
						<td><%=map.get("createDate")%></td>
						<td><%=map.get("updateDate")%></td>
					</tr>
				</tbody>
			</table>
			
			<br>
			<br>

			<a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp" type="button" class="btn btn-dark">주문목록</a>
		</div>
	</div>	
	

	<!-- Footer -->
	<%@ include file="/inc/Footer.jsp" %>
	
 
</body>
</html>