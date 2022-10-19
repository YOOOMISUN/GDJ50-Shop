<%@page import="java.util.ArrayList"%>
<%@page import="vo.Customer"%>
<%@page import="java.util.List"%>
<%@page import="Service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인 안되어 있거나 user가 Employee가 아니면 로그인 폼으로...
	if(session.getAttribute("id") == null || (!(session.getAttribute("user").equals("Employee"))) ){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	} 


	int rowPerPage = 5;
	int currentPage = 1;
	int lastPage = 0;
	
	if(request.getParameter("currentPage") !=(null)){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	CustomerService customerService = new CustomerService();
	List<Customer> list = new ArrayList<Customer>();
	list = customerService.getCustomerList(rowPerPage, currentPage);	// 고객 리스트
	lastPage = customerService.getCustomerLastPage(rowPerPage);
	
	// 디버깅
	System.out.println("list >> " + list);
	System.out.println("lastPage >> " + lastPage);	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>customer List</title>
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
		<h2 style="font-weight :bold;">고객 리스트</h2>		
		<br>
		<br>
		<table style=" margin-left:auto; margin-right:auto; text-align:center; vertical-align:middle;" class="table table-bordered" >
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
						for(Customer customer : list) {
					%>
					<tr>
						<td>
							<a href="<%=request.getContextPath()%>/admin/adminCustomerOrderOne.jsp?customerId=<%=customer.getCustomerId()%>">
							<%=customer.getCustomerId()%></a></td>
						<td><%=customer.getCustomerName()%></td>
						<td><%=customer.getCustomerTelephone()%></td>
						<td><%=customer.getCustomerAddress()%><%=customer.getCustomerDetailAddr()%></td>
						<td><%=customer.getCreateDate()%></td>
						<td><a href="<%=request.getContextPath()%>/admin/updateCustomer.jsp?customerId=<%=customer.getCustomerId()%>&updateDate=<%=customer.getUpdateDate()%>">정보수정</a></td>
					</tr>
						<%	
						System.out.println("updateDate @@ " + customer.getUpdateDate());
							}
						%>	
			</table>
			
			<br>
			<br>
			<br>
			
			
			<!-- 페이징 -->
			<%
			if (currentPage > 1) {
			%>
			<a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp?currentPage=<%=currentPage-1%>" type="button" class="btn btn-dark">이전</a>
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
		    &nbsp;			
			    <a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp?currentPage=<%=i%>"><%=i%></a>
			&nbsp;		    	
		   <%	 
		   			}
		    	}
		    
			if (currentPage < lastPage) {
			%>
				<a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp?currentPage=<%=currentPage+1%>" type="button" class="btn btn-dark">다음</a>
			<%
				  }
			%>				
	</div>
</div>	
	
	<!-- Footer -->
	<%@ include file="/inc/Footer.jsp" %>
	
	
			
</body>
</html>