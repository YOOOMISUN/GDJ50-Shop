<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%


	String deleteAction = "";
	if(session.getAttribute("user").equals("Employee")){
		deleteAction="/admin/removeEmployeeAction";
	} else if (session.getAttribute("user").equals("Customer")){
		deleteAction="/removeCustomerAction";
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>

	<!-- Header -->
	<%@ include file="/inc/Header.jsp" %>
	



	<form action="<%=request.getContextPath()%><%=deleteAction%>.jsp" method="post" id="removeForm">
		비밀번호 : 
		<input type="password" name="pw" id="pw">
		<button type="button" id="removebtn">탈퇴하기</button>
		<p><a href="javascript:history.go(-1)" class="btn btn-danger" title="뒤로">뒤로가기</a></p>
	</form>
	
	<!-- Footer -->
	<%@ include file="/inc/Footer.jsp" %>
	
	
	
</body>
<script>	// 유효성 검사
	$('#removebtn').click(function(){
		if($('#pw').val() == '') {
			window.alert('비밀번호를 입력해주세요');
		} else {
			removeForm.submit();
		}
	});
</script>

</html>