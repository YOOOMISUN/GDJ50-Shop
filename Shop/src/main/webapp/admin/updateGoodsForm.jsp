<%@page import="vo.Employee"%>
<%@page import="java.util.Map"%>
<%@page import="Repository.GoodsDao"%>
<%@page import="vo.GoodsImg"%>
<%@page import="vo.Goods"%>
<%@page import="Service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인 안되어 있거나 user가 Employee가 아니면 로그인 폼으로...
	if(session.getAttribute("id") == null || (!(session.getAttribute("user").equals("Employee"))) ){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	} 

	// 인코딩
	request.setCharacterEncoding("utf-8");

	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	GoodsService goodsService = new GoodsService();
	Map<String,Object> map = goodsService.getGoodsAndImgOne(goodsNo);
	
	// 디버깅
	System.out.println("goodsUpdate : " + map);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Goods Form</title>
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


	<h2 style="text-align: center;">상품 수정하기</h2>
	<br>
	<form action="<%=request.getContextPath()%>/admin/updateGoodsAction.jsp?goodsNo=<%=map.get("goodsNo")%>" method="post" enctype="multipart/form-data" id="updateGoods">
		<table style=" margin-left:auto; margin-right:auto; " class="table table-bordered" >
				<tr>
					<td>No</td>
					<td><%=map.get("goodsNo")%></td>
					<!-- <td><input type="hidden" name="goodsNo"></td> -->
				</tr>
				<tr>
					<td>Name</td>
					<td><input type="text"  class="form-control" name="name" id="name"></td>
				</tr>
				<tr>
					<td>Price</td>
					<td><input type="text"  class="form-control" name="price" id="price"></td>
				</tr>
				<tr>
					<td>Img</td>
					<td><input type="file"  id="file" name="file"></td>
				</tr>
				<tr>
					<td>Update Date</td>
					<td><%=map.get("updateDate")%></td>
				</tr>
				<tr>
					<td>Sold Out</td>
				<td>
					<select name="soldOut">
						<%
							if(map.get("soldOut").equals("Y")) {
						%>
							<option>Y</option>
							<option selected="selected">N</option>
						<%
							} else {
						%>
							<option selected="selected">Y</option>
							<option>N</option>
						<%
							}
						%>
					</select> 
					<%
						if(request.getParameter("errorMsg") != null){
					%>
						<span style="color:red;"><%=request.getParameter("errorMsg")%></span>	
					<%
						}
					
					%>
					
					</td>
				</tr>
			</tbody>
		</table>
		<%
			if(session.getAttribute("user").equals("Employee") && session.getAttribute("active").equals("Y") ){ 
		%>
			<button type="button" class="btn btn-info" id="updateBtn">수정하기</button>
		<%
			}
		%>
	</form>
</body>
<script>	// 유효성 검사
	$('#updateBtn').click(function(){			
		if($('#name').val().length < 1){
			alert('이름을 입력해주세요');
		} else if($('#price').val().length < 1){
			alert('가격을 입력해주세요');
		} else if($('#file').val().length < 1){
			alert('파일을 첨부해주세요');
		} else if($('#file').val().length < 1){
				alert('파일을 첨부해주세요');
		} else{
			updateGoods.submit();
		}
	});
</script>
</html>