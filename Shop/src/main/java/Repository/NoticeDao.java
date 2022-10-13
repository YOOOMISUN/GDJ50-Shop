package Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import vo.Notice;

public class NoticeDao {
	
	// 공지사항 삭제 (deleteNoticeAction.jsp)
	public int deleteNotice(Connection conn, int noticeNo) throws SQLException {
		
		int row = 0;
		String sql = "DELETE FROM notice WHERE notice_no=?";
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		
		row = stmt.executeUpdate();
		
		if(stmt!=null) {
			stmt.close();
		}
		
		return row;
	}
	
	
	// 공지사항 수정 (updateNoticeAction.jsp)
	public int updateNotice(Connection conn, Notice notice) throws SQLException {
		
		int row = 0;
		String sql = "UPDATE notice SET notice_title=?, notice_content=?,update_date=NOW() WHERE notice_no=?";
		PreparedStatement stmt = null;
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getNoticeNo());
		
		row = stmt.executeUpdate();
		
		if(stmt!=null) {
			stmt.close();
		}
		
		return row;
		
	}	// end updateNotice
	
	
	// 공지사항 상세페이지 (adminNoticeOne.jsp)
	public Map<String,Object> selectNoticeOne(Connection conn, int noticeNo ) throws SQLException{
		Map<String,Object> map = new HashMap<String,Object>();
		
		String sql = "SELECT notice_no, notice_title, notice_content, update_date, create_date FROM notice WHERE notice_no=?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			map.put("noticeNo", rs.getInt("notice_no"));
			map.put("noticeTitle", rs.getNString("notice_title"));
			map.put("noticeContent", rs.getNString("notice_content"));
			map.put("updateDate", rs.getNString("update_date"));
			map.put("createDate", rs.getNString("create_date"));
		}
		
		// 디버깅
		System.out.println("map : " + map);
		
		if(rs!=null) {
			rs.close();
		}
		if(stmt!=null) {
			stmt.close();
		}
		
		return map;
		
	}	// end selectNoticeOne
	
	
	
	// 공지사항 추가 (addNoticeAction.jsp)
	public int insertNotice(Connection conn, Notice notice) throws SQLException {
		
		String sql = "INSERT INTO notice (notice_no, notice_title, notice_content, update_date, create_date) VALUES (?,?,?,NOW(),NOW())";
		PreparedStatement stmt = null;
		int row = 0;
		
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, notice.getNoticeNo());
		stmt.setString(2, notice.getNoticeTitle());
		stmt.setString(3, notice.getNoticeContent());
		
		row = stmt.executeUpdate();
		
		if(stmt!=null) {
			stmt.close();
		}
		
		return row;
	}
	
	// 공지사항 리스트, 페이징 (adminNoticeList.jsp) 
	public ArrayList<Notice> selectNoticeList(Connection conn, int rowPerPage, int beginRow) throws SQLException {
		ArrayList<Notice> list = new ArrayList<Notice>();

		String sql = "SELECT notice_no, notice_title, notice_content, DATE_FORMAT(create_date,'%Y-%m-%d %T') update_date, DATE_FORMAT(create_date,'%Y-%m-%d %T') create_date FROM notice LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);

		rs = stmt.executeQuery();

		// 디버깅
		System.out.println("rs : " + rs);

		while (rs.next()) {
			Notice notice = new Notice();
			notice.setNoticeNo(rs.getInt("notice_no"));
			notice.setNoticeTitle(rs.getString("notice_title"));
			notice.setNoticeContent(rs.getString("notice_content"));
			notice.setUpdateDate(rs.getString("update_date"));
			notice.setCreateDate(rs.getString("create_date"));

			list.add(notice); // list에 담기
		}

		if (rs != null) {
			rs.close();
		}
		if (stmt != null) {
			stmt.close();
		}

		return list;

	} // end selectNoticeList

	// 공지사항 페이징 (adminNoticeList.jsp) 
	public int NoticeListLastPage(Connection conn, int rowPerPage) throws SQLException {
	
	String sql = "SELECT COUNT(*) FROM notice";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	int lastPage=0;
	int totalRow = 0;
	
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	
	if(rs.next()) {
		totalRow = rs.getInt("COUNT(*)");
	}
	
	lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage +=1;
	}
	
	 if(rs!=null)   {
			rs.close();
		}
	 if(stmt!=null)   {
			stmt.close();
		}
	 
	return lastPage;
	
	} // end NoticeListLastPage

}