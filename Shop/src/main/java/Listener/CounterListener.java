package Listener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import Service.CounterService;



@WebListener
public class CounterListener implements HttpSessionListener {
	// HttpSessionListener : 세션이 생성 될때마다 실행
	
	private CounterService counterService;
	
	// 세션이 생성 될때마다 DB카운터를 1씩 증가
	// 세션이 생성 될때마다 application attribute에 현재 접속 카운터를 1씩 증가
    public void sessionCreated(HttpSessionEvent se)  { 
    	counterService = new CounterService();
    	counterService.count();
    	
    	int n = (Integer)(se.getSession().getServletContext().getAttribute("currentCounter"));
    	
    	se.getSession().getServletContext().setAttribute("currentCounter",n+1);
    
    	
//    	request.setAttribute();		 요청객체안에 map 형태로 저장 -> 응답하고 나면 삭제
//    	session.setAttribute();		 세션객체안에 map 형태로 저장 -> 세션이 사라지면(invalidate) 삭제
//    	application.setAttribute();	 톰캣이 살아있을때까지만 -> 톰캣이 꺼지면 끝
    }
    
    // 세션이 소멸되면 application attribute에 현재 접속 카운터를 1씩 감소
    public void sessionDestroyed(HttpSessionEvent se)  { 
    	// 현재 접속한 접속자들..
    	int n = (Integer)(se.getSession().getServletContext().getAttribute("currentCounter"));
    	
    	se.getSession().getServletContext().setAttribute("currentCounter",n-1);
    }
	
}
