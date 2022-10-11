<%@page import="Service.GoodsService"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "Service.CustomerService" %>
<%
	int lastPage = 0;

	// Controller : java class <- Serlvet
	int rowPerPage = 20;
	if(request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	GoodsService goodsService = new GoodsService();
	
	List<Map<String,Object>> list = goodsService.getCustomerGoodsListByPage(rowPerPage, currentPage);
	
	lastPage = goodsService.getCustomerGoodsListLastPage(rowPerPage);
%>

<!-- View : 태그 -->

<!-- 분리하면 servlet / 연결기술(forword - request,response) / jsp -->

<!DOCTYPE html>
<html>
<head>

<title>Index</title>
</head>
<body>

	<!-- Header  -->
	<%@ include file="/inc/Header.jsp" %>
	
	<div class="container" style="background-color:light;">
	<!-- for / if 대체기술 : 커스텀태그(JSTL & EL) JSP -->
	<!-- JSP를 쓸수 밖에 없음. HTML은 자바코드랑 커스텀태그를 쓸수 없음 -->
	<div>
		<a href="">최신순</a>
		<a href="">리뷰순</a>
		<a href="">판매량순</a>			<!-- 기본 디폴트값 -->
		<a href="">낮은가격 수</a>
		<a href="">높은가격 수</a>
	</div>
	<br>
	<table border="1">
		<tr>
			<%
				int i = 1;
				for(Map<String,Object> m : list){
			%>
					<td>
						<div>
							<a href ="<%=request.getContextPath()%>/customerGoodsOne.jsp?goodsNo=<%=m.get("goodsNo")%>" >		<!-- 이미지 누르면 상세페이지로 -->
							<img src="<%=request.getContextPath()%>/upload/<%=m.get("fileName")%>" width="200" height="200">
							</a>
						</div>
						<div><%=m.get("goodsName")%></div>
						<div><%=m.get("goodsPrice")%></div>
						<!-- 리뷰개수 -->
					</td>	
			<%	
				if(i%4==0){
			%>
					</tr><tr>
			<%		
					} else {
						
					}
					i++;
				}
				
				int tdCount = 4 - (list.size() % 4);			// 필요 td의 개수
				if(tdCount == 4) {
					tdCount = 0;
				}
				
				for(int j=0; j<tdCount; j++){
			%>
				<td>&nbsp;</td>				
			<%		
				}
			%>
		</tr>
	</table>
	
	<!-- 페이징 -->
		<%
		if (currentPage > 1) {
		%>
		<a href="<%=request.getContextPath()%>/Index.jsp?currentPage=<%=currentPage-1%>" type="button" class="btn btn-dark">이전</a>
		<%
		}
		// 페이지 번호
		
		 	int pageCount = 10;
			int startPage = ((currentPage - 1) / pageCount) * pageCount + 1;
	    	int endPage = (((currentPage - 1) / pageCount) + 1) * pageCount;
	    	if (lastPage < endPage) { endPage = lastPage; }
	    	
	    	for (int j = startPage; j <= endPage; j++) {
	    		if (j <= lastPage) {
	    %>			
		    <a href="<%=request.getContextPath()%>/Index.jsp?currentPage=<%=j%>"><%=j%></a>		    	
	   <%	 
	   			}
	    	}
	    
		if (currentPage < lastPage) {
		%>
		<a href="<%=request.getContextPath()%>/Index.jsp?currentPage=<%=currentPage+1%>" type="button" class="btn btn-dark">다음</a>

	<%
		  }
	%>
	
	</div>
	
	
	<!-- Footer  -->
	<%@ include file="/inc/Footer.jsp" %>
	
</body>
</html>



