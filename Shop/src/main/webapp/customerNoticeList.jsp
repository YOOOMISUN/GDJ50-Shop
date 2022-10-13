<%@page import="java.util.ArrayList"%>
<%@page import="vo.Notice"%>
<%@page import="java.util.List"%>
<%@page import="Service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
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
<title>Customer Notice List</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<body>

	<!-- Header -->
	<%@ include file="/inc/Header.jsp" %>
	


	<div class="w3-container">
	<h2 style="text-align:center; font-weight :bold;">공지사항</h2>
	<br>
	<br>
			<table style=" margin-left:auto; margin-right:auto; text-align:center;" class="w3-table-all">
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
						<td><a href="<%=request.getContextPath()%>/customerNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></td>
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
			<a href="<%=request.getContextPath()%>/customerNoticeList.jsp?currentPage=<%=currentPage-1%>" type="button" class="btn btn-dark">이전</a>
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
		    <a href="<%=request.getContextPath()%>/customerNoticeList.jsp?currentPage=<%=i%>"><%=i%></a>		    	
	   <%	 
	   			}
	    	}
	    
		if (currentPage < lastPage) {
		%>
		<a href="<%=request.getContextPath()%>/customerNoticeList.jsp?currentPage=<%=currentPage+1%>" type="button" class="btn btn-dark">다음</a>

		<%
			  }
		%>
		
	</div>
	
	
	<!-- Footer -->
	<%@ include file="/inc/Footer.jsp" %>
	
	
	
</body>
</html>