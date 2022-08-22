package Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class IdKeyService {
	
	// 아이디(key) 중복검사
	public String selectMemberId(String id) throws Exception {
		
		String returnId = null;
		String sql = "SELECT t.id From (SELECT customer_id id FROM customer UNION SELECT employee_id id FROM employee UNION SELECT out_id id FROM outid) t WHERE t.id = ?";
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		
		     conn = dbUtil.getConnection();
	         stmt = conn.prepareStatement(sql);
	         stmt.setString(1, id);
	        
	         rs = stmt.executeQuery();
			
	         if(rs.next()) {
	        	 returnId = rs.getString("id");
	         
	     }
	   
	      return returnId;		// null => 아이디 사용가능, !null 사용불가
	}     
}
