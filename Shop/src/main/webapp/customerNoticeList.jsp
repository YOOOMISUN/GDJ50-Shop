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
</head>
<body>

	<!-- Header -->
	<%@ include file="/inc/Header.jsp" %>
	

	<div class="container">
		<div style="text-align:center;">
			<h2 style="font-weight :bold;">공지사항</h2>
			<br>
			<br>
				<table style=" margin-left:auto; margin-right:auto; text-align:center;" class="table table-bordered">
					<thead>
						<tr style="font-weight :bold;">
							<td>번호</td>
							<td>제목</td>
							<td>수정날짜</td>
							<td>생성날짜</td>
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
			
				<br>
				<br>
	
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
			    &nbsp;				
				    <a href="<%=request.getContextPath()%>/customerNoticeList.jsp?currentPage=<%=i%>"><%=i%></a>		    	
			    &nbsp;	
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
	</div>
	
	
	<!-- Footer -->
	<%@ include file="/inc/Footer.jsp" %>
	
	
	
</body>
</html>