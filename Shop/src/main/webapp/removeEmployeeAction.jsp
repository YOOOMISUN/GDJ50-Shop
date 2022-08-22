
<%@page import="vo.Employee"%>
<%@page import="Service.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	
	if(session.getAttribute("id") == null){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}

	boolean deleteEmployee = false;

	String id = (String)session.getAttribute("id");
	String pw = request.getParameter("pw");
	

	// 디버깅
	System.out.println("id : " + id);
	System.out.println("pw  :" + pw);

	
	Employee employee = new Employee();
	employee.setEmployeeId(id);
	employee.setEmployeePass(pw);
	
	
	EmployeeService employeeService = new EmployeeService();
	deleteEmployee = employeeService.removeEmployee(employee);
	
	if(deleteEmployee != false){
		session.invalidate();	// 기존 세셩영역을 지우고 새로운 세션을 부여
		System.out.println("탈퇴 성공!");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	} else {
		
		System.out.println("탈퇴 실패!");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
	
	
%>