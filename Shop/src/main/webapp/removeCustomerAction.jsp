<%@page import="Repository.CustomerDao"%>
<%@page import="vo.Customer"%>
<%@page import="Service.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	
	if(session.getAttribute("id") == null){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}

	boolean deleteCutomer = false;

	String id = (String)session.getAttribute("id");
	String pw = request.getParameter("pw");
	

	// 디버깅
	System.out.println("id : " + id);
	System.out.println("pw  :" + pw);

	
	Customer customer = new Customer();
	customer.setCustomerId(id);
	customer.setCustomerPass(pw);
	
	
	CustomerService customerService = new CustomerService();
	deleteCutomer = customerService.removeCustomer(customer);
	
	if(deleteCutomer != false){
		session.invalidate();	// 기존 세셩영역을 지우고 새로운 세션을 부여
		System.out.println("탈퇴 성공!");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	} else {
		
		System.out.println("탈퇴 실패!");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
	
	
	
	
	
%>