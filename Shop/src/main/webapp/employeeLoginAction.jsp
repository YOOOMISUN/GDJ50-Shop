
<%@page import="Service.EmployeeService"%>
<%@page import="vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%

 
	// 로그인 되어 있으면 인덱스 폼으로 
	if(session.getAttribute("id") != null){
		response.sendRedirect(request.getContextPath() + "/adminIndex.jsp");
		return;
	}

	
	Employee employee = null;
	String employeeId = request.getParameter("employeeId");
	String employeePass = request.getParameter("employeePass");
	
	// 디버깅
	System.out.println("employeeId : " + employeeId);
	System.out.println("employeePass : " + employeePass);
	
	// CustomerLogin 객체생성
	Employee employeelogin = new Employee();
	
	// customerlogin 안에 불러온 값 넣어주기
	employeelogin.setEmployeeId(employeeId);
	employeelogin.setEmployeePass(employeePass);

	EmployeeService employeeService = new EmployeeService();
	employee = employeeService.getEmployeeLogin(employeelogin);
	
	// 세션에 값 넣어주기
	if(employee != null && employee.getActive().equals("Y")){
		session.setAttribute("user", "Employee");
		session.setAttribute("id", employee.getEmployeeId());
		session.setAttribute("name", employee.getEmployeeName());
		session.setAttribute("pw", employee.getEmployeePass());
		response.sendRedirect(request.getContextPath() + "/adminIndex.jsp");
		System.out.println("로그인성공");
	} else {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?");
		System.out.println("로그인실패");
	}
%>