<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	
	<!-- ID 중복검사 폼 -->

		<div>
			ID Check
			<input type="text" name="ckid" id="ckid">
			<button type="button" id="ckidBtn">아이디 중복검사</button>
			<input type="hidden" name="type" value="Employee">
	<%
			if(request.getParameter("errorMsg") != null) {
	%>
			<span style="color:red;"><%=request.getParameter("errorMsg")%></span>	
	<%		
		}
	%>
		</div>	
	
	<br>
	<br>
	
	<!-- 고객가입 폼 -->
	<div>
	<%
		String ckId = "";
		if(request.getParameter("ckId") != null) {
			ckId = request.getParameter("ckId");			
		}
	%>
	<form action="<%=request.getContextPath()%>/admin/addEmployeeAction.jsp " method="post" id="addEmployeeForm">
		<table border="1">
			<tr>
				<td>Employee Id</td>
				<td><input type="text" name="employeeId" class="form-control" id="employeeId" readonly="readonly" value="<%=ckId%>"></td>
			</tr>
			<tr>
				<td>Employee Pw</td>
				<td><input type="text" name="employeePw" class="form-control" id="employeePw" ></td>
			</tr>
			<tr>
				<td>Employee Name</td>
				<td><input type="text" name="employeeName" class="form-control" id="employeeName" ></td>
			</tr>
		</table>
		<br>
			<button type="button" id="addEmployeeBtn" class="btn btn-info">회원가입</button>
			<a href="javascript:history.go(-1)" class="btn btn-danger" title="뒤로">BACK</a>
			<a><input type="reset" class="btn btn-success"></a>
			<%
				if(request.getParameter("errorMsg") != null) {
			%>
				<span style="color:red;"><%=request.getParameter("errorMsg")%></span>	
			<%		
				}
			%>
	</form>
	</div>
	
</body>
	<script>
	// ID 중복검사
	$('#ckidBtn').click(function(){
		if($('#ckid').val().length < 4) {
			window.alert('아이디는 4자 이상 입력해주세요!');
		}else {
			$.ajax({
				url : '/Shop/IdCkController',
				type : 'post',
				data : {ckid : $('#ckid').val()},
				success : function(json) {
					if(json == 'y') {
						$('#employeeId').val($('#ckid').val());
					} else {
						alert('이미 사용중인 아이디 입니다.');
						$('#employeeId').val('');
					}
				}
			});
		}
	});
	
	$('#addEmployeeBtn').click(function(){
		if($('#employeeId').val() == '') {
			window.alert('아이디를 입력하세요!');
		} else if ($('#employeePw').val() == '') {
			window.alert('비밀번호를 입력하세요!');
		} else if ($('#employeeName').val() == '') {
			window.alert('이름을 입력하세요!');
		} else {
			employeeForm.submit();
		}
	});
	
	</script>
</html>

<% 
/* addCustomer(addEmployee)

1) 아이디 중복 체크 : addCustomer > idCheckAcion > SignService > SignDao
2) 회원가입 : addCustomer > addCustomerAction > CustomerService > CustomerDao */

%>