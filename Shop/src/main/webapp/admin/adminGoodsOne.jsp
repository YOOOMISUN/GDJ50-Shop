<%@page import="Service.ReviewService"%>
<%@page import="vo.Review"%>
<%@page import="vo.Goods"%>
<%@page import="java.util.*"%>
<%@page import="Service.GoodsService"%>
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
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo")); 
	
	GoodsService goodsService = new GoodsService();
	Map<String, Object> map = goodsService.getGoodsAndImgOne(goodsNo);		// 상품 상세페이지
	
	ReviewService reviewService = new ReviewService();
	List<Map<String,Object>> list = new ArrayList<>(); 
	list = reviewService.getReviewListByPage(rowPerPage, currentPage, goodsNo);// 리뷰 목록
	lastPage = reviewService.ReviewListLastPage(rowPerPage);				// 리뷰 목록 페이징
	
	// 디버깅
	System.out.println("map # " + map);
	System.out.println("goodsNo # " + goodsNo);
	System.out.println("lastPage # " + lastPage);
	System.out.println("list # " + list);
	
	
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Goods One</title>
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
<div style="position: relative; top: 200px;">
	<h2 style="text-align: center;">상품 상세페이지</h2>
	<br>
	<form action="<%=request.getContextPath()%>/admin/updateGoodsForm.jsp?goodsNo=<%=map.get("goodsNo")%>" method="post" >
	<div class="container">
		<div class="row">
			<div class="col-sm-6">
			<img src="<%=request.getContextPath()%>/upload/<%=map.get("fileName")%>" width="300" height="300">
			</div>
			<div class="col-sm-6">
		<table style=" margin-left:auto; margin-right:auto; " class="table table-bordered" >	
			<tr>	
				<td>No</td>
				<td><%=map.get("goodsNo")%></td>
			</tr>
			<tr>
				<td>Name</td>
				<td><%=map.get("goodsName")%></td>
			</tr>
			<tr>
				<td>Price</td>
				<td><%=map.get("goodsPrice")%></td>
			</tr>
			<tr>
				<td>Update Date</td>
				<td><%=map.get("updateDate")%></td>
			</tr>
			<tr>
				<td>Create Date</td>
				<td><%=map.get("createDate")%></td>
			</tr>
			<tr>
				<td>Sold Out</td>
				<td><%=map.get("soldOut")%></td>
			</tr>	
		</table>
			</div>
		</div>
	</div>
	<br>
	
	<button type="submit" class="btn btn-info" >수정하기</button>
	<a href="<%=request.getContextPath()%>/admin/removeGoodsAction.jsp?goodsNo=<%=map.get("goodsNo")%>&fileName=<%=map.get("fileName")%>" type="button" class="btn btn-info" >삭제하기</a>
	<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp" type="button" class="btn btn-dark" style="text-align: center;">상품목록</a>
	</form>
	
	<br>
	
	<!-- 리뷰 목록 -->
	<div>
	<form action="<%=request.getContextPath()%>/admin/deleteReviewAction.jsp" method="post">
	<%
		for (Map<String,Object> re : list) {
	%>
	<input type="hidden" name="reviewNo" value="<%=re.get("reviewNo")%>">
	<input type="hidden" name="goodsNo" value="<%=goodsNo%>">
	<table style=" margin-left:auto; text-align: center; margin-right:auto; " class="table table-bordered" >
			<thead>
				<tr>
					<td>번호</td>
					<td>아이디</td>
					<td>리뷰 내용</td>
					<td>생성날짜</td>
					<td>수정날짜</td>
					<td>삭제</td>
				</tr>
			</thead>
			<tbody>
			
			<tr>
				<td><%=re.get("reviewNo")%></td>
				<td><%=re.get("customerId")%></td>
				<td><%=re.get("reviewContent")%></td>
				<td><%=re.get("createDate")%></td>
				<td><%=re.get("updateDate")%></td>
				<td><button type="submit" class="btn btn-dark">리뷰삭제</button></td>
			</tr>
			<%
				}
			%>
			</tbody>
		</table>
	</form>
	
		<!-- 리뷰 페이징 -->
		<%
		if (currentPage > 1) {
		%>
		<a href="<%=request.getContextPath()%>/admin/adminGoodsOne.jsp?currentPage=<%=currentPage-1%>" type="button" class="btn btn-dark">이전</a>
		<%
				}
			// 페이지 번호
		 	int pageCount = 5;
			int startPage = ((currentPage - 1) / pageCount) * pageCount + 1;
		   	int endPage = (((currentPage - 1) / pageCount) + 1) * pageCount;
		   	if (lastPage < endPage) { endPage = lastPage; }
		    	
		   	for (int i = startPage; i <= endPage; i++) {
		   		if (i <= lastPage) {
		%>			
		    <a href="<%=request.getContextPath()%>/admin/adminGoodsOne.jsp?currentPage=<%=i%>"><%=i%></a>		    	
	   <%	 
	   			}
	    	}
	    
		if (currentPage < lastPage) {
		%>
		<a href="<%=request.getContextPath()%>/admin/adminGoodsOne.jsp?currentPage=<%=currentPage+1%>" type="button" class="btn btn-dark">다음</a>

		<%
		  }	
		%>
	</div>	
	</div>	

</body>
</html>


