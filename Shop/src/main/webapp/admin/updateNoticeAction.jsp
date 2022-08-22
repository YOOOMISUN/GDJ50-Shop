<%@page import="vo.Notice"%>
<%@page import="Service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	// 디버깅
	System.out.println("noticeNo : " + noticeNo);
	System.out.println("noticeTitle : " + noticeTitle);
	System.out.println("noticeContent : " + noticeContent);
	
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
		
	NoticeService noticeService = new NoticeService();
	int row = noticeService.modifyupdateNotice(notice);
	
	if(row==1){
		System.out.println("공지사항 수정 성공!");
		response.sendRedirect(request.getContextPath() + "/admin/adminNoticeOne.jsp?noticeNo="+noticeNo);
	} else{
		System.out.println("공지사항 수정 실패!");
		response.sendRedirect(request.getContextPath() + "/admin/updateNoticeForm.jsp?noticeNo="+noticeNo);
	}
	
%>