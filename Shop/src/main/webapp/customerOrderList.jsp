<%@page import="vo.Orders"%>
<%@page import="Service.OrdersService"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
/* 	// 로그인 안되어 있거나 id가 memberId와 같지 않으면 로그인 폼으로
	if(session.getAttribute("id") == null || (!(session.getAttribute("id").equals("customerId"))) ){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}  */

	int rowPerPage = 5;
	int currentPage = 1;
	int lastPage = 0;
	
	if(request.getParameter("currentPage") !=(null)){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	String customerId = request.getParameter("customerId");
	
	// customerId 값 받아오기
	System.out.println("customerId");
	
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
<title>Customer Order List</title>
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
	


	<div class="container" style="text-align:center; ">
	<h2 style="font-weight :bold;"><%=session.getAttribute("name")%>님의 주문 리스트</h2>		
	<table style=" margin-left:auto; margin-right:auto; " class="table table-bordered" >
			<thead>
				<tr>
					<th>Customer Id</th>
					<th>Customer Name</th>
					<th>Customer Telephone</th>
					<th>Customer Address</th>
					<th>Create Date</th>
					<th>Information Update</th>
				</tr>
			</thead>
			<tbody>
			<%
				for(Map<String,Object> m : list) {
			%>
	<%-- 			<tr>
					<td>
						<a href="<%=request.getContextPath()%>/admin/adminCustomerOrderOne.jsp?customerId=<%=m.getCustomerId()%>">
						<%=m.getCustomerId()%></a></td>
					<td><%=m.getCustomerName()%></td>
					<td><%=m.getCustomerTelephone()%></td>
					<td><%=m.getCustomerAddress()%><%=m.getCustomerDetailAddr()%></td>
					<td><%=m.getCreateDate()%></td>
					<td><a href="<%=request.getContextPath()%>/admin/updateCustomer.jsp?customerId=<%=m.getCustomerId()%>&updateDate=<%=m.getUpdateDate()%>">정보수정</a></td>
				</tr> --%>
					<%	
					
						}	
					%>	 
		</table>
	
		
		
	
	
		<!-- 페이징 -->
		<%
		if (currentPage > 1) {
		%>
		<a href="<%=request.getContextPath()%>/customerOrderList.jsp?currentPage=<%=currentPage-1%>" type="button" class="btn btn-dark">이전</a>
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
		    <a href="<%=request.getContextPath()%>/customerOrderList.jsp?currentPage=<%=i%>"><%=i%></a>		    	
	   <%	 
	   			}
	    	}
	    
		if (currentPage < lastPage) {
		%>
			<a href="<%=request.getContextPath()%>/customerOrderList.jsp?currentPage=<%=currentPage+1%>" type="button" class="btn btn-dark">다음</a>
		<%
			  }
		%>				
	</div>
		
	
	<!-- Footer -->
	<%@ include file="/inc/Footer.jsp" %>
	
	
			
</body>
</html>