
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	// 로그인 안되어 있으면 로그인 폼으로 
	if(session.getAttribute("id") == null){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}

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

	<!-- header -->
	<%@ include file="/inc/Header.jsp" %>
	
	<div style="position: relative; top: 200px; text-align:center; font-weight :bold;"> <!-- 로그인 하면 -->
		<p style="font-size:30px;"><%=session.getAttribute("name")%>님 반갑습니다!   (<%=session.getAttribute("user")%>) </p> 	<!-- customer / employee -->
		<br>
		<p style="font-size:20px;"><%=session.getAttribute("id")%></p>		<!-- 로그인 아이디 -->
		<br>
		<p style="font-size:20px;"><%=session.getAttribute("name")%></p>	<!-- 로그인 이름 -->
		<br>
		<br>
		<br>
		<a href="<%=request.getContextPath()%>/customerGoodsList.jsp" class="btn btn-info">상품리스트</a>	
		<a href="<%=request.getContextPath()%>/customerOrderList.jsp?customerId=<%=session.getAttribute("id")%>" class="btn btn-info">주문목록</a>	
		<a href="<%=request.getContextPath()%>/cart.jsp?customerId=<%=session.getAttribute("id")%>" class="btn btn-info">장바구니</a>	
		<a href="<%=request.getContextPath()%>/logout.jsp" class="btn btn-info">로그아웃</a>	
		<a href="<%=request.getContextPath()%>/removeForm.jsp" class="btn btn-danger">회원탈퇴</a>	
		
	</div>
	<br>
	<br>
	<br>
	
		<!-- Footer -->
	<%@ include file="/inc/Footer.jsp" %>
	
	
	
	
</body>
</html>