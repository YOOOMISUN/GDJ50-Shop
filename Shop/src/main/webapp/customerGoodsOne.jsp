<%@page import="Service.ReviewService"%>
<%@page import="vo.Review"%>
<%@page import="vo.Goods"%>
<%@page import="java.util.*"%>
<%@page import="Service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%


	int rowPerPage = 5;
	int currentPage = 1;
	int lastPage = 0;
	
	if(request.getParameter("currentPage") !=(null)){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo")); 
	
	GoodsService goodsService = new GoodsService();
	Map<String, Object> map = goodsService.getGoodsAndImgOne(goodsNo);				// 상품 상세페이지
	
	ReviewService reviewService = new ReviewService();
	List<Map<String,Object>> list = new ArrayList<>(); 
	list = reviewService.getReviewListByPage(rowPerPage, currentPage, goodsNo);		// 리뷰 목록
	lastPage = reviewService.ReviewListLastPage(rowPerPage);						// 리뷰 목록 페이징
	
	// 디버깅
	System.out.println("map # " + map);
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>

	<!-- Header -->
	<%@ include file="/inc/Header.jsp" %>
	
	<br>
	<br>
<div class="container" style="text-align:center;">
	<h2 style="font-weight :bold;">상품 상세페이지</h2>
	<br>
	<br>
	<br>
		<div class="row">
			<div class="col-sm-6">
			<img src="<%=request.getContextPath()%>/upload/<%=map.get("fileName")%>" width="300" height="300">
			</div>
			<div class="col-sm-6">
				<form action="<%=request.getContextPath()%>/customerOrderForm.jsp?goodsNo=<%=goodsNo%>" method="post" id="goodsOneForm">
				<table style=" margin-left:auto; margin-right:auto; text-align:center;" class="table table-bordered" >	
					<tr>	
						<td>번호</td>
						<td><%=map.get("goodsNo")%></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><%=map.get("goodsName")%></td>
					</tr>
					<tr>
						<td>가격</td>
						<td><%=map.get("goodsPrice")%></td>
					</tr>
					<tr>
						<td>수정일</td>
						<td><%=map.get("updateDate")%></td>
					</tr>
					<tr>
						<td>생성일</td>
						<td><%=map.get("createDate")%></td>
					</tr>
					<tr>
						<td>품절여부</td>
						<td><%=map.get("soldOut")%></td>
					</tr>	
				</table>	
				<br>
				<!-- soldOut이 Y인 상태로 주문하기 버튼 누르면 "품절입니다" 알림창 뜨기 -->
				<%
					// id가 없으면 로그인 폼으로
					if(session.getAttribute("id") != null){
				%>	
					<button type="submit" class="btn btn-info" id="orderBtn">주문하기</button>
				<%
					}
				%>
					<a href="<%=request.getContextPath()%>/customerGoodsList.jsp" type="button" class="btn btn-dark"  style="float: right; margin-right :10px;">상품목록</a>
					<a href="<%=request.getContextPath()%>/addCartAction.jsp?goodsNo=<%=map.get("goodsNo")%>&goodsPrice=<%=map.get("goodsPrice")%>&goodsName=<%=map.get("goodsName")%>" type="button" class="btn btn-info" style="float: right; margin-right :20px;">Cart</a>
				</form>
			</div>
		</div>

	<br>
	<br>
	
	
	<%
		for (Map<String,Object> re : list) {
	%>
	<!-- 리뷰 목록 -->
	<div>
		<table style=" margin-left:auto; margin-right:auto; text-align:center;" class="table table-bordered" >
			<thead>
				<tr>
					<td>리뷰 번호</td>
					<td>아이디</td>
					<td>리뷰 내용</td>
					<td>생성날짜</td>
					<td>수정날짜</td>
				<% 
				if(session.getAttribute("id") != null){		// 로그인이 되어있고
					if( session.getAttribute("id").equals(re.get("customerId"))){		// 로그인한 아이디와 리뷰 등록한 아이디가 같으면 수정과 삭제 보이게..
				%> 
					<td>수정</td>
					<td>삭제</td>
				<%
						}
				 	} 
				%>
				</tr>
			</thead>
			<tbody>
			
			<tr>
				<td><%=re.get("reviewNo")%></td>
				<td><%=re.get("customerId")%></td>
				<td><%=re.get("reviewContent")%></td>
				<td><%=re.get("createDate")%></td>
				<td><%=re.get("updateDate")%></td>
			<% 
				if(session.getAttribute("id") != null){		// 로그인이 되어있고
					if( session.getAttribute("id").equals(re.get("customerId"))){		// 로그인한 아이디와 리뷰 등록한 아이디가 같으면 수정과 삭제 보이게..
			%> 
				<td><a href="<%=request.getContextPath()%>/updateReviewForm.jsp?reviewNo=<%=re.get("reviewNo")%>&goodsNo=<%=goodsNo%>&updateDate=<%=re.get("updateDate")%>&reviewContent=<%=re.get("reviewContent")%>&customerId=<%=re.get("customerId")%>" class="btn btn-dark">리뷰수정</a></td>
				<td><a href="<%=request.getContextPath()%>/admin/deleteReviewAction.jsp?reviewNo=<%=re.get("reviewNo")%>&goodsNo=<%=goodsNo%>" class="btn btn-dark">리뷰삭제</a></td>
			<%
					}
			 	} 
			%>
			</tr>
			<%
					}
			%>
			</tbody>
		</table>
		
		<br>
		
		<div class="container" style="text-align:center;">
			<!-- 리뷰 페이징 -->
			<%
			if (currentPage > 1) {
			%>
			<a href="<%=request.getContextPath()%>/customerGoodsOne.jsp?currentPage=<%=currentPage-1%>&goodsNo=<%=goodsNo%>" type="button" class="btn btn-dark">이전</a>
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
			 &nbsp;			
			    <a href="<%=request.getContextPath()%>/customerGoodsOne.jsp?currentPage=<%=i%>&goodsNo=<%=goodsNo%>"><%=i%></a>	    	
		    &nbsp;
		   <%	 
		   			}
		    	}
		    
			if (currentPage < lastPage) {
			%>
			<a href="<%=request.getContextPath()%>/customerGoodsOne.jsp?currentPage=<%=currentPage+1%>&goodsNo=<%=goodsNo%>" type="button" class="btn btn-dark">다음</a>
	
			<%
			  }	
			%>
		 </div>
	</div>	
	<br>
	<br>
	
		<!-- 리뷰 입력 폼 -->
		<div class="container">
			<form action="<%=request.getContextPath()%>/addGoodsReviewAction.jsp?goodsNo=<%=map.get("goodsNo")%>" method="post">
				<fieldset style="font-weight :bold; margin-left :20px;">★ 리뷰 ★</fieldset>
				<br>
				<table>
					<tr>
						<td><textarea class = "form-control" name="reviewContent" rows="3" cols="100"  class="form-control" ></textarea>
						<input type="hidden" name="customerId" value="<%=session.getAttribute("id")%>"></td>
					</tr>
				</table>
				<br>
					<button type="submit" class="btn btn-info" style="float:right; margin-right :150px;" >리뷰입력</button>
			</form>
		</div>
	</div>
	
	
	
 	<%
		if(map.get("soldOut").equals("Y")){
	%>
	<script>
		$("#orderBtn").on("click", function(){ // 버튼을 클릭하면 처리
			alert("품절입니다!");  });
		});
	</script>
	
	<%
		}
	%> 

	
	<!-- Footer -->
	<%@ include file="/inc/Footer.jsp" %>
	
 



</body>
</html>


