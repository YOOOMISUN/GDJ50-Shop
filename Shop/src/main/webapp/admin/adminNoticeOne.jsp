<%@page import="java.util.Map"%>
<%@page import="Service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인 안되어 있거나 user가 Employee가 아니면 로그인 폼으로...
	if(session.getAttribute("id") == null || (!(session.getAttribute("user").equals("Employee"))) ){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	} 
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	NoticeService noticeService = new NoticeService();
	Map<String,Object> map = noticeService.getNoticeOne(noticeNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Notice One</title>
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


	<h2 style="text-align: center;">공지사항 상세페이지</h2>
	<div>
		<form action="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=map.get("noticeNo")%>" method="post">
			<table style=" margin-left:auto; margin-right:auto; " class="table table-bordered">
			<thead>
				<tr>
					<th>No</th>
					<th>Title</th>
					<th>Content</th>
					<th>Update Date</th>
					<th>Create Date</th>
				</tr>	
			</thead>
			<tbody>
				<tr>
					<td><%=map.get("noticeNo")%></td>
					<td><%=map.get("noticeTitle")%></td>
					<td><%=map.get("noticeContent")%></td>
					<td><%=map.get("updateDate")%></td>
					<td><%=map.get("createDate")%></td>
				</tr>
			</tbody>
			</table>
			<%
				if(session.getAttribute("user").equals("Employee") && session.getAttribute("active").equals("Y") ){ %>
				<button type="submit" class="btn btn-warning">수정하기</button>	<!-- 관리자 'Y' 인 사람만 수정 가능하게... -->
				<a href="<%=request.getContextPath()%>/admin/removeNoticeAction.jsp?noticeNo=<%=map.get("noticeNo")%>" class="btn btn-dark">삭제하기</a>
			<%
				}
			%>
			<a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp" type="button" class="btn btn-dark">공지사항목록</a>
		</form>
	</div>
	
	
	
	<!-- Footer -->
	<%@ include file="/inc/Footer.jsp" %>
	
 
	
	
</body>
</html>