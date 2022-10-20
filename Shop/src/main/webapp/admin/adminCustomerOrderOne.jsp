<%@page import="java.util.*"%>
<%@page import="Service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인 안되어 있거나 user가 Employee가 아니면 로그인 폼으로...
	if(session.getAttribute("id") == null || (!(session.getAttribute("user").equals("Employee"))) ){
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
	OrdersService ordersService = new OrdersService();
	List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
	list = ordersService.getOrdersListByCustomer(customerId, rowPerPage, currentPage);
	
	lastPage = ordersService.getordersCustomerLastPage(rowPerPage, customerId);
			
	// 디버깅
	System.out.println("list >> " + list);
	System.out.println("lastPage >> " + lastPage);	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>▶관리자◀ Customer OrderOne</title>
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
		<ul>
			<li><a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">고객관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/employeeList.jsp">사원관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">상품	관리</a></li>	<!-- 상품목록/등록/수정/삭제(장바구니,주문이 없는 경우=> 품절처리) -->
			<li><a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">주문관리</a></li><!-- 주문목록/수정 -->
			<li><a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp">공지관리(게시판)</a></li><!-- 공지 CRUD -->
		</ul>
	</div>


	<div style="text-align:center;">
		<h2 style="font-weight :bold;"><%=customerId%> 주문목록</h2>
	<br>
		<form>
		<table style=" margin-left:auto; margin-right:auto; " class="table table-bordered" >
			<% 
				for(Map<String, Object> m : list){
			%>	
			<tr>	
				<td>Order No</td>
				<td><%=m.get("ordersNo")%></td>
			</tr>
			<tr>	
				<td>Customer Id</td>
				<td><%=m.get("customerId")%></td>
			</tr>
			<tr>	
				<td>Order Quantity</td>
				<td><%=m.get("ordersQuantity")%></td>
			</tr>
			<tr>	
				<td>Orders Price</td>
				<td><%=m.get("ordersPrice")%></td>
			</tr>
			<tr>	
				<td>Orders Address</td>
				<td><%=m.get("ordersAddr")%> <%=m.get("orderDetailAddr")%></td>
			</tr>
			<tr>
				<td>Customer Name</td>
				<td><%=m.get("customerName")%></td>
			</tr>
			<tr>
				<td>Goods Price</td>
				<td><%=m.get("goodsPrice")%></td>
			</tr>
			<tr>
				<td>CreateDate</td>
				<td><%=m.get("createDate")%></td>
			</tr>
			
			<tr>
				<td>
					<br>
					<br>
				</td>
			</tr>
			<%
				}
			%>
			
		</table>

		<br>
			<a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp" type="button" class="btn btn-dark" style="text-align: center;">고객목록</a>
		</form>
		
		<br>
		<br>
						
		<!-- 페이징 -->
		<%
			if (currentPage > 1) {
		%>
			<a href="<%=request.getContextPath()%>/admin/adminCustomerOrderOne.jsp?currentPage=<%=currentPage-1%>&customerId=<%=customerId%>" type="button" class="btn btn-dark">이전</a>
		<%
			}
			
			// 페이지 번호
		 	int pageCount = 10;
			int startPage = ((currentPage - 1) / pageCount) * pageCount + 1;
		   	int endPage = (((currentPage - 1) / pageCount) + 1) * pageCount;
		   	if (lastPage < endPage) { endPage = lastPage; }
		    	
		   	for (int i = startPage; i <= endPage; i++) {
		   		if (i <= lastPage) {
	    %>			
		    <a href="<%=request.getContextPath()%>/admin/adminCustomerOrderOne.jsp?currentPage=<%=i%>&customerId=<%=customerId%>"><%=i%></a>		    	
	   <%	 
	   			}
	    	}
	    
			if (currentPage < lastPage) {
		%>
		&nbsp;	
			<a href="<%=request.getContextPath()%>/admin/adminCustomerOrderOne.jsp?currentPage=<%=currentPage+1%>&customerId=<%=customerId%>" type="button" class="btn btn-dark">다음</a>
		&nbsp;	
		<%
			  }
		%>				

	</div>
</div>	
	
	<!-- Footer -->
	<%@ include file="/inc/Footer.jsp" %>
	
		
	
</body>
</html>