package Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class CounterDao {
	
//	# 오늘 날짜의 데이터  SELECT * FROM counter WHERE counter_date = CURDATE();
//	# 없으면 (insert)
//	# 있으면 num + 1 (update)

	// 입력
	public int insertCounter(Connection conn) throws SQLException {
		
		String sql = "INSERT INTO counter(counter_date, counter_num) VALUES (CURDATE(),1)";
		PreparedStatement stmt = null;
		int insertCounter = 0;
		
		try {
			stmt = conn.prepareStatement(sql);
			insertCounter = stmt.executeUpdate();
			
			// 디버깅
			System.out.println("insertCounter : " + insertCounter);
			
		} finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		
		return insertCounter;
	}	// end insertCounter
	
	// select
	public String selectCounterToday(Connection conn) throws SQLException {
		
		String result = null;
		String sql =  "SELECT counter_date FROM counter WHERE counter_date = CURDATE()";
		// null 이면 날짜 리턴
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getString("counter_date");
			}
			
			} finally {
				if(rs!=null) {
					rs.close();
				}
				if(stmt!=null) {
					stmt.close();
				}
			}
		
		return result;
	}	// end selectCounterToday
	
	// update
	public void updateCounter(Connection conn) throws SQLException {
		
		String sql = "UPDATE counter SET counter_num = counter_num+1 WHERE counter_date = CURDATE()";
		PreparedStatement stmt = null;
		int updateCounter = 0;
		
		try {
			stmt = conn.prepareStatement(sql);
			updateCounter = stmt.executeUpdate();
			
			// 디버깅
			System.out.println("updateCounter : " + updateCounter);
			
		} finally {
			if(stmt != null) { 
				stmt.close(); 
				}
		}
	}	// end updateCounter
	
	// IndexController에서 호출
	// 전체접속자 수
	// SELECT SUM(counter_num) FROM counter; 
	public int selectTotalCount(Connection conn) throws SQLException {
		
		int total = 0;
		String sql = "SELECT sum(counter_num) FROM counter";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			// 디버깅
			System.out.println("rs : " + rs);
			
			if(rs.next()) {
				total = rs.getInt("sum(counter_num)");
			}
			
			// 디버깅
			System.out.println("total : " + total);
			
		} finally {
			if(rs != null) { 
				rs.close(); 
			}
			if(stmt != null) { 
				stmt.close(); 
			}
		}
		
		return total;
	}	// end selectTotalCount
	
	// 오늘 접속자 수
	// SELECT counter_num FROM counter WHERE counter_date = CURDATE();
	public int selectTodayCount(Connection conn) throws SQLException {
		
		String sql = "SELECT counter_num FROM counter WHERE counter_date = CURDATE()";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int today = 0;
		
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			// 디버깅
			System.out.println("rs : " + rs);
			
			if(rs.next()) {
				today = rs.getInt("counter_num");
			}	
		} finally {
			if(rs != null) { 
				rs.close(); 
			}
			if(stmt != null) { 
				stmt.close(); 
			}
		}
		return today;
	}	// end selectTodayCount
	
	
}
