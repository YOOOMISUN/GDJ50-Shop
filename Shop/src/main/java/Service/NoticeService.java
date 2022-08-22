package Service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import Repository.NoticeDao;
import vo.Notice;

public class NoticeService {
	private NoticeDao noticeDao;
	
	// 공지사항 삭제 (deleteNoticeAction.jsp)
	public boolean reomoveNotice(int noticeNo) {
		
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			this.noticeDao = new NoticeDao();
			if(noticeDao.deleteNotice(conn, noticeNo) == 0){
				throw new Exception();		// 실패시 예외처리로
			}
			
			// 디버깅
			System.out.println("deleteNotice : " + noticeDao.deleteNotice(conn, noticeNo));
			
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
		return false;
	}
	
	// 공지사항 수정 (updateNoticeAction.jsp)
	public int modifyupdateNotice(Notice notice) {
		
		Connection conn = null;
		int updateNotice = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			this.noticeDao = new NoticeDao();
			updateNotice = noticeDao.updateNotice(conn, notice);
			
			if(updateNotice == 0) {
				throw new Exception();
			}
			
			// 디버깅
			System.out.println("updateNotice : " + updateNotice);
			
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
		return updateNotice;
	}
	
	
	// 공지사항 상세페이지 (adminNoticeOne.jsp)
	public Map<String,Object> getNoticeOne(int noticeNo){
		Map<String,Object> map = new HashMap<>();
		Connection conn = null;
		this.noticeDao = new NoticeDao();
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			map = noticeDao.selectNoticeOne(conn, noticeNo);
			
			if(map==null) {
				throw new Exception(); 	// 실패시 예외처리로..
			}
			
			// 디버깅
			System.out.println("map >> " + map);
			
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
		
		return map;
		
	}	// end getNoticeOne
	
	
	// 공지사항 추가
	public int addNotice(Notice notice) {
		
		Connection conn = null;
		int addNotice = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			this.noticeDao = new NoticeDao();
			
			addNotice = noticeDao.insertNotice(conn, notice);
			
			if(addNotice==0) {
				throw new Exception();	// 실패시 예외처리로 ..
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
		
		return addNotice;
		
	}
	
	
	// 공지사항 리스트, 페이징 (adminNoticeList.jsp)
	public ArrayList<Notice> getNoticeList(int rowPerPage, int currentPage){
		
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		Connection conn = null;
		this.noticeDao = new NoticeDao();
		int beginRow = (currentPage-1)*rowPerPage;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			list = noticeDao.selectNoticeList(conn, rowPerPage, beginRow);
			
			if(list==null) {
				throw new Exception();	// 값이 없으면 예외처리
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
		
		return list;
		
	}	// end getNoticeList
	
	// adminNoticeList.jsp 페이징
	public int getNoticeListLastPage(int rowPerPage) {
		
		Connection conn = null;
		this.noticeDao = new NoticeDao();
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			rowPerPage = noticeDao.NoticeListLastPage(conn, rowPerPage);
		
			if(rowPerPage == 0) {
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
      return rowPerPage;

	}	// end getNoticeListLastPage
	
}
