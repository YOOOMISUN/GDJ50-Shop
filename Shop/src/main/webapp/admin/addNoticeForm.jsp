<%@page import="vo.Notice"%>
<%@page import="Repository.NoticeDao"%>
<%@page import="Service.NoticeService"%>
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
<title>Add Notice Form</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>

	<!-- header -->
	<%@ include file="/inc/Header.jsp" %>
	


	<!-- 목록 -->
	<div>
		<br>
		<ul>
			<li><a href="<%=request.getContextPath()%>/admin/admincustomerList.jsp">고객관리</a></li><!-- 고객목록/강제탈퇴/비밀번호수정(수정된 비밀번호 전달 구현X) -->
			<li><a href="<%=request.getContextPath()%>/admin/employeeList.jsp">사원관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">상품	관리</a></li>	<!-- 상품목록/등록/수정/삭제(장바구니,주문이 없는 경우=> 품절처리) -->
			<li><a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">주문관리</a></li><!-- 주문목록/수정 -->
			<li><a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp">공지관리(게시판)</a></li><!-- 공지 CRUD -->
		</ul>
	
	</div>


	<div>
	<h2 style="text-align:center; font-weight :bold;">공지사항 추가</h2>
		<form action="<%=request.getContextPath()%>/admin/addNoticeAction.jsp" method="post" id="updateNoticeForm">
			<table style=" margin-left:auto; margin-right:auto; " class="table table-bordered" >
					<tr>
						<td>Title</td>
						<td><input type="text" class="form-control"  name="noticeTitle" id="noticeTitle"></td>
					</tr>
					<tr>
						<td>Content</td>
						<td><textarea rows="5" cols="80" class="form-control" name="noticeContent" id="noticeContent"></textarea></td>
					</tr>	
			</table>
		<%
			if(session.getAttribute("user").equals("Employee") && session.getAttribute("active").equals("Y") ){ %>
			<button type="submit" class="btn btn-info" style="color:white" id="addNoticeBtn">공지사항추가</button>		<!-- 관리자 'Y' 인 사람만 추가 가능하게... -->
		<%
			}
		%>
		</form>
	</div>
		
		<!-- Footer -->
	<%@ include file="/inc/Footer.jsp" %>
		
		
</body>
<script>	// 유효성 검사
	$('#addNoticeBtn').click(function(){			
		if($('#noticeTitle').val().length < 1){
			alert('제목을 입력해주세요');
		} else if($('#noticeContent').val().length < 1){
			alert('내용을 입력해주세요');
		} else{
			updateNoticeForm.submit();
		}
	});
</script>

</html>

