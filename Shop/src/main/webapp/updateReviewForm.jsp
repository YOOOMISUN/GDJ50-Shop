<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo")); 
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo")); 
	String reviewContent = request.getParameter("reviewContent");
	String updateDate = request.getParameter("updateDate");
	
	// 디버깅
	System.out.println("goodsNo * " + goodsNo);
	System.out.println("reviewNo * " + reviewNo);
	System.out.println("reviewContent * " + reviewContent);
	System.out.println("updateDate * " + updateDate);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

	<!-- Header -->
	<%@ include file="/inc/Header.jsp" %>
	



		<!-- 리뷰 입력 폼 -->
	<div>
		<form action="<%=request.getContextPath()%>/updateReviewAction.jsp?reviewNo=<%=reviewNo%>&goodsNo=<%=goodsNo%>" method="post">
			<table>
				<tr>
					<td>리뷰번호</td>
					<td><input type="text" class="form-control" name="reviewNo" value="<%=reviewNo%>" class="form-control" readonly="readonly"></td>
				</tr>
				<tr>
					<td>리뷰내용</td>
					<td><textarea class="form-control" name="updateReviewContent" rows="3" cols="100" ><%=reviewContent%></textarea></td>
				</tr>
				<tr>
					<td>수정날짜</td>
					<td><input type="text" name="updateDate" value="<%=updateDate%>" class="form-control" readonly="readonly"></td>
				</tr>
			</table>
			<br>
				<button type="submit" class="btn btn-info">리뷰입력</button>
		</form>
	</div>
	
	
	<!-- Footer -->
	<%@ include file="/inc/Footer.jsp" %>
	
 
	
	
</body>
</html>