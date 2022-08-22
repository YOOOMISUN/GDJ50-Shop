<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.invalidate();		// 로그아웃
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Form</title>
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
	<div class="container" >
	<div class="row">
		<div class="col-sm-6" style="position: relative; top: 200px;">
		<form method="post" action="<%=request.getContextPath()%>/customerLoginAction.jsp" id="customerForm" >
			<fieldset>
				<legend style="text-align:center; font-weight :bold;">쇼핑몰 고객 로그인</legend>	<!-- customer  -->
				<br>
				<table style=" margin-left:auto; margin-right:auto; text-align:center;" class="table table-bordered" >
					<tr>
						<td>ID</td>
						<td><input type="text" name="customerId" id="customerId"></td>
					</tr>
					<tr>
						<td>PASSWORD</td>
						<td><input type="password" name="customerPass" id="customerPass"></td>
					</tr>
				</table>
				<br>
				<button type="button" id="customerBtn" class="btn btn-info" style="width:150px; margin:auto; display:block;">고객 로그인</button>
				<a href="<%=request.getContextPath()%>/addCustomer.jsp" class="btn btn-dark" style="float: right;">고객 회원가입</a>
			</fieldset>
		</form>
		</div>
		
		<div class="col-sm-6"  style="position: relative; top: 200px;">
		<form method="post" action="<%=request.getContextPath()%>/admin/employeeLoginAction.jsp" id="employeeForm">
			<fieldset>
				<legend style="text-align:center; font-weight :bold;">쇼핑몰 관리자 로그인</legend>	<!-- Employee  -->
				<br>
				<table style=" margin-left:auto; margin-right:auto; text-align:center;" class="table table-bordered" >
					<tr>
						<td>ID</td>
						<td><input type="text" name="employeeId" id="employeeId"></td>
					</tr>
					<tr>
						<td>PASSWORD</td>
						<td><input type="password" name="employeePass" id="employeePass"></td>
					</tr>
				</table>
				<br>
				<button type="button" id="employeeBtn" class="btn btn-info" style="width:150px; margin:auto; display:block;">관리자 로그인</button>
				<a href="<%=request.getContextPath()%>/admin/addEmployee.jsp" class="btn btn-dark" style="float: right;">관리자 회원가입</a>
			</fieldset>
		</form>
		</div>
	</div>
	</div>
</body>
	<script>
	$('#customerBtn').click(function(){
		if($('#customerId').val() == '') {
			window.alert('고객아이디를 입력하세요');
		} else if ($('#customerPass').val() == '') {
			window.alert('고객비밀번호를 입력하세요');
		} else {
			customerForm.submit();
		}
	});
	
	$('#employeeBtn').click(function(){
		if($('#employeeId').val() == '') {
			window.alert('관리자 아이디를 입력하세요');
		} else if ($('#employeePass').val() == '') {
			window.alert('관리자 비밀번호를 입력하세요');
		} else {
			employeeForm.submit();
		}
	});
	
	</script>

</html>