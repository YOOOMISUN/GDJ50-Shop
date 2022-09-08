<%@page import="Service.CounterService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<% 
		// 로그인 안되어 있거나 user가 Employee가 아니면 로그인 폼으로...
		if(session.getAttribute("id") == null || (!(session.getAttribute("user").equals("Employee"))) ){
			response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
			return;
		} 
	
	%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Index</title>
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
	<div>
		<ul>
			<li><a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">고객관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/employeeList.jsp">사원관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">상품	관리</a></li>	<!-- 상품목록/등록/수정/삭제(장바구니,주문이 없는 경우=> 품절처리) -->
			<li><a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">주문관리</a></li><!-- 주문목록/수정 -->
			<li><a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp">공지관리(게시판)</a></li><!-- 공지 CRUD -->
		</ul>
	
	</div>

	<div style="position: relative; top: 200px; text-align:center; font-weight :bold;"> <!-- 로그인 화면 -->
		<p style="font-size:30px;"><%=session.getAttribute("name")%>님 반갑습니다!   (<%=session.getAttribute("user")%>) </p> 	<!-- customer / employee -->
		<br>
		<p style="font-size:20px;"><%=session.getAttribute("id")%></p>		<!-- 로그인 아이디 -->
		<br>
		<p style="font-size:20px;"><%=session.getAttribute("name")%></p>	<!-- 로그인 이름 -->
		<br>
		<a href="<%=request.getContextPath()%>/logout.jsp" class="btn btn-info">로그아웃</a>	
		<a href="<%=request.getContextPath()%>/removeForm.jsp" class="btn btn-danger">회원탈퇴</a>	
		
	</div>
	

</body>
</html>
