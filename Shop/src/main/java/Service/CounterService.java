package Service;

import java.sql.Connection;
import java.sql.SQLException;

import Repository.CounterDao;

public class CounterService {
	private CounterDao counterDao;
	
	public void count() {
		counterDao = new CounterDao();
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			if(counterDao.selectCounterToday(conn) == null) {	// 오늘 날짜 카운터가 없으면 1 입력
				counterDao.insertCounter(conn);
			} else {											// 오늘 날짜의 카운터가 있으면 +1 업데이트
				counterDao.updateCounter(conn);
				}
			
			conn.commit();
			
		} catch(Exception e) {
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
		
	}	// end count
	
	// 전체접속자 수 
	public int getTotalCount() {
		counterDao = new CounterDao();
		Connection conn = null;
		int totalCount = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			totalCount = counterDao.selectTotalCount(conn);
			
			// 디버깅
			System.out.println("totalCount : " + totalCount);
			
			if(totalCount==0) {		// 0일경우 예외처리로..
				throw new Exception();
			}
			
		} catch(Exception e) {
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
		
		return totalCount;
	}

	// 오늘 접속자 수
	public int getTodayCount() {
		counterDao = new CounterDao();
		Connection conn = null;
		int todayCount = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			todayCount = counterDao.selectTodayCount(conn);
			
			// 디버깅
			System.out.println("todayCount : " + todayCount);
			
			if(todayCount==0) {		// 0일경우 예외처리로..
				throw new Exception();
			}
			
		} catch(Exception e) {
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
		
		return todayCount;
	}
	
	
	
}
