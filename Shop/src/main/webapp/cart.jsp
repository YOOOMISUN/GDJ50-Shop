<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	// 로그인 안되어 있으면 로그인폼으로
	if(session.getAttribute("id") == null ){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}  
	
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
					<th>장바구니번호</th>
					<th>상품 번호</th>
					<th>상품 이름</th>
					<th>수량</th>
					<th>가격</th>
					<th>날짜</th>
				</tr>
			</thead>
			
			<tbody>
			<%-- 	<% 
				for(Map<String,Object> m : list){
				%> --%>	
					<tr>
						<td><input type="checkbox" id="cartCheck" name="cartCheck" value="<%-- ${uc.lectureNo} --%>" checked></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><a class="btn btn-primary" href="<%=request.getContextPath()%>/removeCart?goodsNo=">삭제</a></td>
					</tr>
				<%-- <%
					}
				%> --%>
			</tbody>
		</table>
		<button class="btn btn-primary" id="order" type="button" style="float:right;" value="cntCheck">주문</button>
		<a href="<%=request.getContextPath()%>/customerGoodsList" class="btn btn-primary" style="float:right; margin-right:10px;">상품목록</a>
	</form>
	</div>
	<!-- 장바구니 리스트 END -->

		
	
	<!-- Footer -->
	<%@ include file="/inc/Footer.jsp" %>
	
	


</body>
</html>