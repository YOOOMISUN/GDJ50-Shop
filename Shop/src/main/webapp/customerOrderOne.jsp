<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="Service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
 	// 로그인 안되어 있거나 로그인한 사람이 주문한사람 아이디와 일치하지 않으면 로그인 폼으로 
	if(session.getAttribute("id") == null ){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
		} 
	
	int rowPerPage = 1;
	int currentPage = 1;
	int lastPage = 0;
	
	if(request.getParameter("currentPage") != null ){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	String customerId = request.getParameter("customerId");
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	
	System.out.println("customerId >> " + customerId);
	
	OrdersService ordersService = new OrdersService();
	Map<String, Object> map = new HashMap<String, Object>();
	map = ordersService.getOrdersOne(ordersNo);
	
	lastPage = ordersService.getordersCustomerLastPage(rowPerPage, customerId);
			
	// 디버깅
	System.out.println("map >> " + map);
	System.out.println("lastPage >> " + lastPage);	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Order One</title>
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
	
	<br>
	
	<div class="container" >
		<div style="position: relative; top: 100px;">
			<h2 style="font-weight :bold; text-align:center;">주문 상세</h2>
			<br>
			<br>
			
			<label style="font-weight :bold;">[ 주문정보 ]</label>
			<table style="margin-left:auto; margin-right:auto; text-align:center;"  class="table table-bordered" >
				<tr>
					<td>주문번호</td>
					<td><%=map.get("orderNo")%></td>
				</tr>
 				<tr>	
					<td>주문일자</td>
					<td><%=map.get("createDate")%></td>
				</tr>
 				<tr>	
					<td>주문수량</td>
					<td><%=map.get("orderQuantity")%></td>
				</tr>
 				<tr>	
					<td>주문가격</td>
					<td><%=map.get("orderPrice")%></td>
				</tr>
				<tr>	
					<td>주문자</td>
					<td><%=map.get("customerId")%></td>
				</tr>
				<tr>	
					<td>주문처리상태</td>
					<td><%=map.get("orderState")%></td>
				</tr>
				<tr>
					<td>결제수단</td>
					<td><%=map.get("payment")%></td>
				</tr>
			</table>
			
			<br>
			<br>
			
			<label style="font-weight :bold;">[ 상품정보 ]</label>
			<table style="margin-left:auto; margin-right:auto; text-align:center;"  class="table table-bordered" >
				<tr>	
					<td>상품번호</td>
					<td><%=map.get("goodsNo")%></td>
				</tr>
				<tr>	
					<td>상품이름</td>
					<td><%=map.get("goodsName")%></td>
				</tr>
				<tr>
					<td>상품가격</td>
					<td><%=map.get("goodsPrice")%></td>
				</tr>
			</table>	
			
			<br>
			<br>
			
			<label style="font-weight :bold;">[ 배송지정보 ]</label>
			<table style="margin-left:auto; margin-right:auto; text-align:center;"  class="table table-bordered" >
				<tr>	
					<td>받으시는 분</td>
					<td><%=map.get("customerName")%></td>
				</tr>
				<tr>	
					<td>주소</td>
					<td><%=map.get("orderAddr")%><%=map.get("orderDetailAddr")%></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><%=map.get("customerTelephone")%></td>
				</tr>
			</table>	
			
			<br>
			<br>
			
			<a href="<%=request.getContextPath()%>/customerOrderList.jsp?customerId=<%=session.getAttribute("id")%>" type="button" class="btn btn-dark"  style="float: right; margin-right :30px;">주문목록</a>
			<a href="<%=request.getContextPath()%>/customerGoodsList.jsp" type="button" class="btn btn-dark"  style="float: right; margin-right :30px;">상품목록</a>
		</div>
	</div>

<br>
<br>

	<!-- Footer -->
	<%@ include file="/inc/Footer.jsp" %>
	
 

</body>
</html>