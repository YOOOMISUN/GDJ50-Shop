<%@page import="vo.Notice"%>
<%@page import="Service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	System.out.println("noticeTitle : " + noticeTitle);
	System.out.println("noticeContent : " + noticeContent);
	
	
	Notice notice = new Notice();
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	System.out.println("notice : " + notice);

	
	int row = 0;
	NoticeService noticeService = new NoticeService();
	row = noticeService.addNotice(notice);
	
	System.out.println("row : " + row);
	System.out.println("notice >> " + notice);
	
	if(row == 1){
		System.out.println("공지사항 추가 성공!");
		response.sendRedirect(request.getContextPath() + "/admin/adminNoticeList.jsp");
	} else {
		System.out.println("공지사항 추가 실패!");
		response.sendRedirect(request.getContextPath() + "/admin/adminNoticeList.jsp");
	}
	
%>