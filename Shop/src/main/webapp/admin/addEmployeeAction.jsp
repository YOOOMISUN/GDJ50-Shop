<%@page import="Service.EmployeeService"%>
<%@page import="vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String employeeId = request.getParameter("employeeId");
	String employeePw = request.getParameter("employeePw");
	String employeeName = request.getParameter("employeeName");
	
	int row = 0;
	
	Employee employee = new Employee();
	employee.setEmployeeId(employeeId);
	employee.setEmployeePass(employeePw);
	employee.setEmployeeName(employeeName);
	
	// 디버깅
	System.out.println("employeeId : " + employeeId);
	System.out.println("employeePw : " + employeePw);
	System.out.println("employeeName : " + employeeName);
	
	
	EmployeeService employeeService = new EmployeeService();
	row = employeeService.addEmployeeLogin(employee);
	
	// 디버깅
	System.out.println("row : " + row);
	
	if(row == 1){				// 회원가입 성공 
		System.out.println("회원가입 성공!");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	} else  {					// 회원가입 실패
		System.out.println("회원가입 실패!");
		// service -> true 사용가능
		response.sendRedirect(request.getContextPath()+"/admin/addEmployee.jsp?errorMsg=Check Id or Pw");
		}
	
%>
