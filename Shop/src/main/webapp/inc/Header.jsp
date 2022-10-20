<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

    <title>iCREAM - Ice Cream Shop</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Free HTML Templates" name="keywords">
    <meta content="Free HTML Templates" name="description">

    <!-- Favicon -->
    <link href="<%=request.getContextPath()%>/inc/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="<%=request.getContextPath()%>/inc/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/inc/lib/lightbox/css/lightbox.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="<%=request.getContextPath()%>/inc/css/style.css" rel="stylesheet">
</head>


<body>
    <!-- Topbar Start -->
    <div class="container-fluid bg-primary py-3 d-none d-md-block">
        <div class="container">
            <div class="row">
                <div class="col-md-6 text-center text-lg-left mb-2 mb-lg-0">
                    <div class="d-inline-flex align-items-center">
                        <a class="text-white pr-3" href="<%=request.getContextPath()%>/cart.jsp">Cart</a>
                        <span class="text-white">|</span>
                        <a class="text-white px-3" href="<%=request.getContextPath()%>/">My Order List</a>
                    </div>
                </div>
                <div class="col-md-6 text-center text-lg-right">
                    <div class="d-inline-flex align-items-center">
                    	<!-- 고객 회원가입 -->
                       <a href="<%=request.getContextPath()%>/addCustomer.jsp" class="text-white pr-3" style="float:right; margin-right:50px;">
				     	<span class="glyphicon glyphicon-user"></span>Sign Up</a> 

				      <!-- 아이디가 없으면 로그인 -->
						<% if(session.getAttribute("id") == null)
				          {
				        %>
				     	<!-- 로그인 -->
				     	<a href="<%=request.getContextPath()%>/loginForm.jsp" class="text-white pr-3" style="float:right; margin-right:30px;"> Login</a> 
				       <%
				          } 
				       %>
				         <% 
				      	if(session.getAttribute("id") != null)
				      		{
				          %>
				             <a href="<%=request.getContextPath()%>/logout.jsp" class="text-white pr-3"  style="float:right; margin-right:30px;">Logout</a>
				         <%
				        		 } 
				           %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Topbar End -->


    <!-- Navbar Start -->
    <div class="container-fluid position-relative nav-bar p-0">
        <div class="container-lg position-relative p-0 px-lg-3" style="z-index: 9;">
            <nav class="navbar navbar-expand-lg bg-white navbar-light shadow p-lg-0">
                <a href="<%=request.getContextPath()%>/Index.jsp" class="navbar-brand d-block d-lg-none">
                    <h1 class="m-0 display-4 text-primary"><span class="text-secondary">i</span>CREAM</h1>
                </a>
                <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                    <div class="navbar-nav ml-auto py-0">
                        <a href="<%=request.getContextPath()%>/customerGoodsList.jsp" class="nav-item nav-link">Product</a>
                         <a href="<%=request.getContextPath()%>/gallery.jsp" class="nav-item nav-link">Gallery</a>
                    </div>
                    <a href="<%=request.getContextPath()%>/Index.jsp" class="navbar-brand mx-5 d-none d-lg-block">
                        <h1 class="m-0 display-4 text-primary"><span class="text-secondary">i</span>CREAM</h1>
                    </a>
                    <div class="navbar-nav mr-auto py-0">
                        <a href="<%=request.getContextPath()%>/customerNoticeList.jsp" class="nav-item nav-link">Notice</a>
                    <% if(session.getAttribute("id") != null)
						{
					%>
                        <a href="<%=request.getContextPath()%>/myPage.jsp" class="nav-item nav-link">My Page</a>
                    <%
						} 
					%>
                        <!--  로그인이 되어있고 user가 employee로 로그인되어있으면 Admin 탭 보이게 -->
					<% if(session.getAttribute("id") != null && session.getAttribute("user").equals("Employee") )
						{
					%>
                        <a href="<%=request.getContextPath()%>/admin/adminIndex.jsp" class="nav-item nav-link">Admin</a>
                    <%
						} 
					%>
                    </div>
                </div>
            </nav>
        </div>
    </div>
    <!-- Navbar End -->





     
	<br>
	<br>


