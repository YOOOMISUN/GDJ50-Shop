<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.Employee"%>
<%@page import="Repository.EmployeeDao"%>
<%@page import="Service.EmployeeService"%>

<%
	// 로그인 안되어 있거나 user가 Employee가 아니면 로그인 폼으로...
	if(session.getAttribute("id") == null || (!(session.getAttribute("user").equals("Employee"))) ){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	} 

	int rowPerPage = 5; // 페이지에 보여줄 행의 갯수
	int lastPage = 0;
	int currentPage = 1;
	
	if(request.getParameter("currentPage") !=(null)){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	EmployeeService employeeService = new EmployeeService();
	ArrayList<Employee> list = new ArrayList<Employee>();
	list = employeeService.getEmployeeList(rowPerPage, currentPage);	// list
	
	
	lastPage = employeeService.getlastPage(rowPerPage);		// 페이징
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee List</title>
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
		<h2 style="font-weight :bold;">사원관리</h2>
		<br>
		<br>
		
		<table style="margin-left:auto; margin-right:auto; text-align:center; vertical-align:middle;" class="table table-bordered" >
			<thead>
				<tr>
					<th>Id</th>
					<th>Name</th>
					<th>Update Date</th>
					<th>Create Date</th>
					<th>Active</th>
					<th>Active Update</th>
				</tr>
			</thead>
			<tbody>
				<%
					for (Employee e : list) {
				%>
				<tr>
					<td><%=e.getEmployeeId()%></td>
					<td><%=e.getEmployeeName()%></td>
					<td><%=e.getUpdateDate()%></td>
					<td><%=e.getCreateDate()%></td>
					<td><%=e.getActive()%></td>
					<td>
						<form action="<%=request.getContextPath()%>/admin/updateEmployeeAction.jsp" method="post">
							<input type="hidden" name="employeeId" value="<%=e.getEmployeeId()%>"> 
							<select name="active">
								<%
								if (e.getActive().equals("Y")) {
								%>
								<option>Y</option>
								<option selected="selected">N</option>
								<%
								} else {
								%>
								<option selected="selected">Y</option>
								<option>N</option>
								<%
								}
								%>
							</select>
							&nbsp;&nbsp;&nbsp;&nbsp;
						<%
							if(session.getAttribute("user").equals("Employee") && session.getAttribute("active").equals("Y") ){ %>
							<button type="submit" class="btn btn-warning">수정하기</button>	<!-- 관리자 'Y' 인 사람만 수정 가능하게... -->
						<%
							}
						%>
					</form>
					</td>
					<%
						}
					%>
				</tr>
			</tbody>
		</table>
		
		<br>
		<br>
		<br>
		
		<!-- 페이징 -->
		<%
		if (currentPage > 1) {
		%>
		<a
			href="<%=request.getContextPath()%>/admin/employeeList.jsp?currentPage=<%=currentPage-1%>" type="button" class="btn btn-dark" style="">이전</a>
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
			<a href="<%=request.getContextPath()%>/admin/mployeeList.jsp?currentPage=<%=i%>"><%=i%></a>
		&nbsp; 	
	   <%	 
	    		}
	    	}
		if (currentPage < lastPage) {
		%>
		<a
			href="<%=request.getContextPath()%>/admin/employeeList.jsp?currentPage=<%=currentPage+1%>" type="button" class="btn btn-dark">다음</a>

		<%
		}
		%>

	</div>
</div>		
	

	<!-- Footer -->
	<%@ include file="/inc/Footer.jsp" %>
	
 
</body>
</html>