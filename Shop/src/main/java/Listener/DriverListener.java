package Listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;


@WebListener
public class DriverListener implements ServletContextListener {

    // 톰캣이 실행될때 같이 실행
    public void contextInitialized(ServletContextEvent sce)  { 
    	// application.setAttribute에 (currentCount)
    	// 톰캣이 실행 될때마다 현재 카운트가 0으로 셋팅
    	sce.getServletContext().setAttribute("currentCount", 0);
    	
    	
    	// 톰캣 부팅시 드라이버 로딩
         try {
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공!");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		
		}
    }
	
    
    
    
}
