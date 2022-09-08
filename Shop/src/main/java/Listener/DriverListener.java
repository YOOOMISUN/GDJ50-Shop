package Listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class DriverListener implements ServletContextListener {

    public void contextInitialized(ServletContextEvent sce)  { 
    	
         try {
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println(" 드라이버 로딩 성공!");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
    }
}