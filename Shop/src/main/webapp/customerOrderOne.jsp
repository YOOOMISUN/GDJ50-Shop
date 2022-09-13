<%@page import="java.util.Map"%>
<%@page import="Service.OrdersService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
 	// 로그인 안되어 있거나 로그인한 사람이 주문한사람 아이디와 일치하지 않으면 로그인 폼으로 
	if(session.getAttribute("id") == null){
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
<title>Insert title here</title>
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

<h2 style="text-align: center;"><%=customerId%> 주문목록</h2>
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
		<a href="<%=request.getContextPath()%>/customerGoodsList.jsp" type="button" class="btn btn-dark"  style="float: right; margin-right :30px;">상품목록</a>
	<!-- 페이징 -->
	<%
		if (currentPage > 1) {
	%>
		<a href="<%=request.getContextPath()%>/customerOrderOne.jsp?currentPage=<%=currentPage-1%>&customerId=<%=customerId%>" type="button" class="btn btn-dark">이전</a>
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
	    <a href="<%=request.getContextPath()%>/customerOrderOne.jsp?currentPage=<%=i%>&customerId=<%=customerId%>"><%=i%></a>		    	
   <%	 
   			}
    	}
    
		if (currentPage < lastPage) {
	%>
		<a href="<%=request.getContextPath()%>/customerOrderOne.jsp?currentPage=<%=currentPage+1%>&customerId=<%=customerId%>" type="button" class="btn btn-dark">다음</a>
	<%
		  }
	%>				

<br>
</form>


</body>
</html>