<%@page import="Service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// 로그인 되어 있으면 인덱스 폼으로 
	if(session.getAttribute("id") != null){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	Customer customerLogin = null;
	
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	
	// 디버깅
	System.out.println("customerId : " + customerId);
	System.out.println("customerPass : " + customerPass);
	
	// CustomerLogin 객체생성
	Customer customer = new Customer();
	
	// customerlogin 안에 불러온 값 넣어주기
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPass);
	
	// 디버깅
	System.out.println("customerId : " + customerId);
	System.out.println("customerPass : " + customerPass);

	CustomerService customerService = new CustomerService();
	customerLogin = customerService.getCustomerLogin(customer);


	if(customerLogin != null){
		session.setAttribute("user", "Customer");
		session.setAttribute("id", customerLogin.getCustomerId());
		session.setAttribute("name", customerLogin.getCustomerName());
		session.setAttribute("pw", customerLogin.getCustomerPass());
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		System.out.println("로그인성공");
	} else {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?errorMsg=Check Id or Pw");
		System.out.println("로그인실패");
	}
%>