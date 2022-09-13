<%@page import="Service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");	
	
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	String customerName = request.getParameter("customerName");
	String customerAddress = request.getParameter("customerAddress");
	String customerDetailAddr = request.getParameter("customerDetailAddr");
	String customerTelephone = request.getParameter("customerTelephone");
	
	// 디버깅
	System.out.println("customerId : " + customerId);
	System.out.println("customerPw : " + customerPw);
	System.out.println("customerName : " + customerName);
	System.out.println("customerAddress : " + customerAddress);
	System.out.println("customerDetailAddr : " + customerDetailAddr);
	System.out.println("customerTelephone :" + customerTelephone);
	
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPw);
	customer.setCustomerName(customerName);
	customer.setCustomerAddress(customerAddress);
	customer.setCustomerDetailAddr(customerDetailAddr);
	customer.setCustomerTelephone(customerTelephone);
	
	// 디버깅
	System.out.println("customerId $$ " + customerId);
	System.out.println("customerPw $$ " + customerPw);
	System.out.println("customerName $$ " + customerName);
	System.out.println("customerAddress $$ " + customerAddress);
	System.out.println("customerDetailAddr $$ " + customerDetailAddr);
	System.out.println("customerTelephone $$ " + customerTelephone);
	
	int row = 0;
	
	CustomerService customerService = new CustomerService();
	row = customerService.modifyCustomer(customer);
	
	// 디버깅
	System.out.println("row : " + row);
	
	
	if(row == 1){				
		System.out.println("정보수정 성공!");
		response.sendRedirect(request.getContextPath()+"/admin/adminCustomerList.jsp");
	} else  {					
		System.out.println("정보수정 실패!");
		response.sendRedirect(request.getContextPath()+"/admin/adminCustomerList.jsp?errorMsg=Check Id or Pw");
		}
	
	
	
%>
