<%@page import="java.util.ArrayList"%>
<%@page import="vo.Cart"%>
<%@page import="java.util.List"%>
<%@page import="Service.CartService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	// 로그인 안되어 있으면 로그인폼으로
	if(session.getAttribute("id") == null ){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}  
	
	// 페이지네이션
	int lastPage = 0;
	
	// Controller : java class <- Serlvet
	int rowPerPage = 10;
	if(request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	CartService cartService = new CartService();
	
	List<Cart> list = cartService.getCartList(rowPerPage, currentPage);
	lastPage = cartService.getCartListLastPage(rowPerPage);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart</title>
</head>
<body>

  
	<!-- Header -->
	<%@ include file="/inc/Header.jsp" %>
	

	<!-- 장바구니 리스트 -->
	<div class="container">
		<h2 style="text-align: center; font-weight :bold;"> <%=session.getAttribute("name")%>님의 장바구니</h2>
		<br>
		<hr>
		<br>
	<form method="post" action="<%=request.getContextPath()%>/customerOrderForm.jsp" id="cartList">
		<table class="table" style="text-align: center;">
			<thead>
				<tr>
					<th>선택</th>
					<th>상품 번호</th>
					<th>상품 이름</th>
					<th>수량</th>
					<th>가격</th>
					<th>날짜</th>
				</tr>
			</thead>
			
			<tbody>
			 	<% 
					for(Cart l : list){
						if(session.getAttribute("id").equals(l.getCustomerId()) ){		// 로그인한 id와 같은 id의 장바구니만 보여주기
				%> 
					<tr>
						<td><input type="checkbox" id="cartCheck" name="cartCheck" value="<%=l.getCartNo()%>" checked></td>
						<td><%=l.getGoodsNo()%></td>
						<td><%=l.getGoodsName()%></td>
						<td><%=l.getGoodsQuantity()%></td>
						<td><%=l.getGooodsPrice()%></td>
						<td><%=l.getCreateDate()%></td>
						<td><a class="btn btn-primary" href="<%=request.getContextPath()%>/removeCart.jsp?cartNo=<%=l.getCartNo()%>">삭제</a></td>
					</tr>
				<%
						}
				}
			%> 
			</tbody>
		</table>
			<button class="btn btn-primary" id="order" type="button" style="float:right;" value="cntCheck">주문</button>
			<a href="<%=request.getContextPath()%>/customerGoodsList.jsp" class="btn btn-primary" style="float:right; margin-right:10px;">상품목록</a>
	</form>

	<!-- 장바구니 리스트 END -->



		<!-- 페이징 -->
		<%
			if (currentPage > 1) {
		%>
			<a href="<%=request.getContextPath()%>/cart.jsp?currentPage=<%=currentPage-1%>" type="button" class="btn btn-dark">이전</a>
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
	    &nbsp;
		    <a href="<%=request.getContextPath()%>/cart.jsp?currentPage=<%=j%>"><%=j%></a>	
		&nbsp;	    	
	   <%	 
	   			}
	    	}
	    
			if (currentPage < lastPage) {
		%>
			<a href="<%=request.getContextPath()%>/cart.jsp?currentPage=<%=currentPage+1%>" type="button" class="btn btn-dark">다음</a>
		<%
			  }
		%>
	
	</div>
	
	<!-- Footer -->
	<%@ include file="/inc/Footer.jsp" %>
	
	


</body>
</html>