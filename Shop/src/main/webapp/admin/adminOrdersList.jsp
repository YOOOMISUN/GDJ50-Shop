<%@page import="java.util.HashMap"%>
<%@page import="vo.Orders"%>
<%@page import="Service.OrdersService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// 로그인 안되어 있거나 user가 Employee가 아니면 로그인 폼으로...
	if(session.getAttribute("id") == null || (!(session.getAttribute("user").equals("Employee"))) ){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	} 

	int rowPerPage = 10;
	int currentPage = 1;
	int lastPage = 0;
	
	if(request.getParameter("currentPage") !=(null)){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	List<Map<String, Object>> list = new ArrayList<>();
	OrdersService orderService = new OrdersService();
	
	list = orderService.getOrdersList(rowPerPage, currentPage);
	
	lastPage = orderService.getOrdersLastPage(rowPerPage);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orders List</title>
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
	<!-- 목록 -->
	<div>
		<br>
		
		<ul>
			<li><a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">고객관리</a></li><!-- 고객목록/강제탈퇴/비밀번호수정(수정된 비밀번호 전달 구현X) -->
			<li><a href="<%=request.getContextPath()%>/admin/employeeList.jsp">사원관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">상품	관리</a></li>	<!-- 상품목록/등록/수정/삭제(장바구니,주문이 없는 경우=> 품절처리) -->
			<li><a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">주문관리</a></li><!-- 주문목록/수정 -->
			<li><a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp">공지관리(게시판)</a></li><!-- 공지 CRUD -->
		</ul>
		
	</div>
	
	<!-- 주문목록 -->
	<div>
		<h2 style="text-align:center; font-weight :bold;">주문 관리</h2>
		<br>
		<table style=" margin-left:auto; text-align: center; margin-right:auto; " class="table table-bordered" >
		<thead>
			<tr>
				<td>Order No</td>
				<td>Customer Id</td>
				<td>Goods Name</td>
				<td>Goods Price</td>
				<td>Order Quantity</td>
				<td>Order Price</td>
				<td>Order Address</td>
				<td>Create Date</td>
				<td>Order State</td>
			</tr>
		</thead>
		<tbody>
			<% 
			for(Map<String, Object> m : list){
			%>
				<tr>
					<td><%=m.get("orderNo")%></td>
					<td>
						<a href="<%=request.getContextPath()%>/admin/adminOrdersOne.jsp?ordersNo=<%=m.get("orderNo")%>"><%=m.get("customerId")%></a></td>
					<td><%=m.get("goodsName")%></td>
					<td><%=m.get("goodsPrice")%></td>
					<td><%=m.get("orderQuantity")%></td>
					<td><%=m.get("orderPrice")%></td>
					<td><%=m.get("orderAddr")%> <%=m.get("orderDetailAddr")%></td>
					<td><%=m.get("createDate")%></td>
					<td><%=m.get("orderState")%>
						<form action="<%=request.getContextPath()%>/admin/updateOrdersAction.jsp?ordersNo=<%=m.get("orderNo")%>" method="post">
							<select name="State">
								<option>결제완료</option>
								<option>상품준비중</option>
								<option>배송중</option>
								<option>배송완료</option>
							</select>
						<%
							if(session.getAttribute("user").equals("Employee") && session.getAttribute("active").equals("Y") ){ %>
							<button type="submit" class="btn btn-warning">수정하기</button>	<!-- 관리자 'Y' 인 사람만 수정 가능하게... -->
						<%
							}
						%>
					</form>
					</td>
				</tr>
			<%
			    }
			%>
			</tbody>
		</table>
				<!-- 페이징 -->
		<%
		if (currentPage > 1) {
		%>
		<a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp?currentPage=<%=currentPage-1%>" type="button" class="btn btn-dark">이전</a>
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
		    <a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp?currentPage=<%=i%>"><%=i%></a>		    	
	   <%	 
	   			}
	    	}
	    
		if (currentPage < lastPage) {
		%>
		<a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp?currentPage=<%=currentPage+1%>" type="button" class="btn btn-dark">다음</a>

	<%
		  }
	%>
	</div>

</body>
</html>