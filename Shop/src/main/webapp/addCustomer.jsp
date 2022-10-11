<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// id가 있으면 로그인 폼으로
	if(session.getAttribute("id") != null){
		response.sendRedirect(request.getContextPath() + "/logout.jsp");
		return;
	}  
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>


  
	<!-- Header -->
	<%@ include file="/inc/Header.jsp" %>
	

	<div style="position: relative; top: 100px;">
	<!-- id 체크 폼 -->
	
		<div style=" margin-left:auto; margin-right:auto; text-align: center;" >
			ID Check&nbsp;&nbsp;&nbsp;
			<input type="text" name="ckid" id="ckid" style="border-radius: 30px;">&nbsp;&nbsp;
			<button type="button" id="ckidBtn" class="btn btn-primary">아이디 중복검사</button>
			<input type="hidden" name="type" value="Customer" >
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
	
	
	<!-- 고객 회원가입 폼 -->
	<%
		String ckId = "";
		if(request.getParameter("ckId") != null) {
			ckId = request.getParameter("ckId");			
		}
	%>
	<form action="<%=request.getContextPath()%>/addCustomerAction.jsp " method="post" id="addCustomerForm">
		<table style=" margin-left:auto; margin-right:auto; text-align: center; " class="table table-bordered" >
			<tr>
				<td>Customer Id</td>
				<td><input type="text" name="customerId" id="customerId"  class="form-control" readonly="readonly" value="<%=ckId%>"></td>
			</tr>
			<tr>
				<td>Customer Pw</td>
				<td><input type="text" name="customerPw" id="customerPw" class="form-control"></td>
			</tr>
			<tr>
				<td>Customer Name</td>
				<td><input type="text" name="customerName" id="customerName" class="form-control"></td>
			</tr>
			<tr>
				<td>Customer Address</td>
				<td><input type="text" name="customerAddress" id="customerAddress" readonly="readonly" class="form-control"></td>
				<td><button type="button" id="addrBtn" onclick="sample2_execDaumPostcode()" class="btn btn-info">주소검색</button></td>
				<td>DetailAddr</td>
				<td><input type="text" name="customerDetailAddr" id="customerDetailAddr" class="form-control"></td>
			</tr>
			<tr>
				<td>Customer Telephone</td>
				<td><input type="text" name="customerTelephone" id="customerTelephone" class="form-control"></td>
			</tr>
		</table>
			<a href="javascript:history.go(-1)" class="btn btn-info" title="뒤로" style="float: right; ">BACK</a>
			<a><input type="reset" class="btn btn-dark" style="float: right; margin-right :30px;"></a>
			<button type="button" id="addCustomerBtn" class="btn btn-info" style="float: right; margin-right :30px;">회원가입</button>
			<%
				if(request.getParameter("errorMsg") != null) {
			%>
				<span style="color:red;"><%=request.getParameter("errorMsg")%></span>	
			<%		
				}
			%>
	</form>
	
	
	<!-- Footer -->
	<%@ include file="/inc/Footer.jsp" %>
	
	
	
	
	
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>
</div>
<script>
	#('#addrBtn').click(function(){
		sample2_execDaumPostcode();
	});

</script>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer'); 

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
            
                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    // document.getElementById("sample2_extraAddress").value = extraAddr;
                
                } else {
                    // document.getElementById("sample2_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                // document.getElementById('sample2_postcode').value = data.zonecode;
                // document.getElementById("sample2_address").value = addr;
                
                // $('#addr').val(data.zonecode + ' ' + addr);
                document.getElementById('customerAddress').value = data.zonecode + ' ' + addr;
                
                
                // 커서를 상세주소 필드로 이동한다.
                // document.getElementById("sample2_detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>

	
	
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
						$('#customerId').val($('#ckid').val());
					} else {
						alert('이미 사용중인 아이디 입니다.');
						$('#customerId').val('');
					}
				}
			});
		}
	});
	
	$('#addCustomerBtn').click(function(){
		if($('#ckid').val() == '') {
			alert('아이디를 입력하고 중복검사를 진행해주세요!');
			$("#ckid").focus();
		} else if ($('#customerPw').val() == '') {
			alert('비밀번호를 입력하세요!');
			$("#customerPw").focus();
		} else if ($('#customerName').val() == '') {
			window.alert('이름을 입력하세요!');
			$("#customerName").focus();
		} else if ($('#customerAddress').val() == '') {
			window.alert('주소를 입력하세요!');
			$("#customerAddress").focus();
		} else if ($('#customerDetailAddr').val() == '') {
			window.alert('상세주소를 입력하세요!');
			$("#customerDetailAddr").focus();
		} else if ($('#customerTelephone').val() == '') {
			window.alert('핸드폰번호를 입력하세요!');
			$("#customerTelephone").focus();
		} else {
			addCustomerForm.submit();
		}
	});
	
	</script>
</html>

<% 
/* addCustomer(addEmployee)

1) 아이디 중복 체크 : addCustomer > idCheckAcion > SignService > SignDao
2) 회원가입 : addCustomer > addCustomerAction > CustomerService > CustomerDao */

%>