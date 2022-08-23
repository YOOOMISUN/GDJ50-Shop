<%@page import="java.util.ArrayList"%>
<%@page import="vo.Notice"%>
<%@page import="java.util.List"%>
<%@page import="Service.NoticeService"%>
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
	
	NoticeService noticeService = new NoticeService();
	List<Notice> list = new ArrayList<Notice>();
	list = noticeService.getNoticeList(rowPerPage, currentPage);

	lastPage = noticeService.getNoticeListLastPage(rowPerPage);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Notice List</title>
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
	
	<div>
	<h2 style="text-align:center; font-weight :bold;">공지사항</h2>
	<br>
		<form action="<%=request.getContextPath()%>/admin/addNoticeForm.jsp" method="post" >
			<table style=" margin-left:auto; margin-right:auto; " class="table table-bordered" >
				<thead>
					<tr>
						<td>No</td>
						<td>Title</td>
						<td>Update Date</td>
						<td>Create Date</td>
					</tr>
				</thead>
				<tbody>
				<%  
					for(Notice n : list){
				%>
					<tr>
						<td><%=n.getNoticeNo()%></td>
						<td><a href="<%=request.getContextPath()%>/admin/adminNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></td>
						<td><%=n.getUpdateDate()%></td>
						<td><%=n.getCreateDate()%></td>
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
			<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp?currentPage=<%=currentPage-1%>" type="button" class="btn btn-dark">이전</a>
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
		    <a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp?currentPage=<%=i%>"><%=i%></a>		    	
	   <%	 
	   			}
	    	}
	    
		if (currentPage < lastPage) {
		%>
		<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp?currentPage=<%=currentPage+1%>" type="button" class="btn btn-dark">다음</a>

		<%
			  }
			if(session.getAttribute("user").equals("Employee") && session.getAttribute("active").equals("Y") ){ %>
			<button type="submit" class="btn btn-info" style="color:white">공지사항추가</button>	<!-- 관리자 'Y' 인 사람만 추가 가능하게... -->
		<%
			}
		%>
		</form>
	</div>
	
</body>
</html>