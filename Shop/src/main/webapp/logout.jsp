<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<%	
	
		// 로그아웃 : 기존의 세션을 지우고 새로운 세션을 줌 
		session.invalidate();			// 기존 세셩영역을 지우고 새로운 세션을 부여
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		
	%>
