<%@page import="java.util.ArrayList"%>
<%@page import="vo.Customer"%>
<%@page import="java.util.List"%>
<%@page import="Service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인 안되어 있거나 id가 memberId와 같지 않으면 로그인 폼으로
	if(session.getAttribute("id") == null || !(session.getAttribute("id").equals("memberId")) ){
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
	<h2 style="text-align:center; font-weight :bold;">고객 리스트</h2>		
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
		    <a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp?currentPage=<%=i%>"><%=i%></a>		    	
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
		
	
	<!-- Footer -->
	<%@ include file="/inc/Footer.jsp" %>
	
	
			
</body>
</html>