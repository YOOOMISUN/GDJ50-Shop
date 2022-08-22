<%@page import="Service.NoticeService"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));

	// 디버깅
	System.out.println("removeNoticeNo >> " + noticeNo);
	
	NoticeService noticeService = new NoticeService();
	noticeService.reomoveNotice(noticeNo);
	
	response.sendRedirect(request.getContextPath() + "/admin/adminNoticeList.jsp");
%>
