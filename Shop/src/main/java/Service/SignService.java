package Service;

import java.sql.Connection;
import java.sql.SQLException;

import Repository.SignDao;

public class SignService {
		private SignDao signDao;
	
	// 아이디(key) 중복검사
	// return
	// true : 사용가능한 아이디 / false : 사용불가능한 아이디
	public boolean idCheck(String id) throws Exception {
		// SignDao signDao = new SignDao();		=> idCheck 안에서만 사용가능한 지역변수 
		this.signDao = new SignDao();		// null 포인트 인셉션 
		boolean result = false;
		Connection conn = null;
		
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);			// 자동으로 커밋 안되게..
			
			if(signDao.idCheck(conn, id) == null) {
				result = true;
			}
			
			// 디버깅
			System.out.println("result" + result);
			
			conn.commit();
			
		 } catch (Exception e) {
	         e.printStackTrace();
	         try {
	            conn.rollback();
	         } catch (SQLException e1) {
	            e1.printStackTrace();
	         }
	      } finally {
	    	  try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
	      }
		
		// 디버깅
		System.out.println("result" + result);
					
	      return result;
	   }
	}