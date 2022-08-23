package Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Review;

public class ReviewDao {
	// 리뷰 추가
	public int insertReview(Connection conn, Review review) throws SQLException {
		
		String sql = "INSERT INTO review (review_no, goods_no, customer_id ,review_content, create_date, update_date) VALUES (?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = null;
		int insertReview = 0;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, review.getReviewNo());
			stmt.setInt(2, review.getGoodsNo());
			stmt.setString(3, review.getCustomerId());
			stmt.setString(4, review.getReviewContent());
			
			insertReview = stmt.executeUpdate();
			
			// 디버깅
			System.out.println("insertReview : " + insertReview);

		} finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		
		return insertReview;
		
	}	// end insertComment
	
	// 리뷰 목록, 페이징
	public List<Map<String,Object>> selectReviewListByPage(Connection conn, int rowPerPage, int beginRow, int goodsNo) throws Exception {
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String,Object> map = null;
		
		String sql = "SELECT review_no, goods_no, customer_id, review_content, create_date, update_date FROM review WHERE goods_no=? ORDER BY review_no ASC LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			rs = stmt.executeQuery();
			
			
			// 디버깅
			System.out.println("rs ++ " + rs);
			
			
			while(rs.next()) {
				map = new HashMap<String,Object>();
				map.put("reviewNo", rs.getInt("review_no"));
				map.put("goodsNo", rs.getInt("goods_no"));
				map.put("customerId", rs.getString("customer_id"));
				map.put("reviewContent", rs.getString("review_content"));
				map.put("createDate", rs.getString("create_date"));
				map.put("updateDate", rs.getString("update_date"));
				
				// 디버깅
				System.out.println("map ++ " + map);
				
				list.add(map);
			}
			
		} finally {
			if(rs!=null) {
				rs.close();
			}
			if(stmt!=null) {
				stmt.close();
			}
		}
		
		return list;
		
	}	// end selectReviewListByList
	
	
	// 리뷰 페이징
	public int reviewLastPage(Connection conn, int rowPerPage) throws SQLException{
		
		String sql = "SELECT COUNT(*) FROM review";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int lastPage = 0;
		int totalRow = 0;
		
		stmt = conn.prepareStatement(sql);
	    rs = stmt.executeQuery();
		
		 if(rs.next()) {
			 totalRow = rs.getInt("COUNT(*)");
	         }
		
		lastPage = totalRow / rowPerPage;
		if(totalRow % rowPerPage != 0) {
				lastPage += 1;
			}
		 
		 // 디버깅
		 System.out.println("lastPage : " + lastPage);
		 
		 if(rs!=null)   {
				rs.close();
			}
		 if(stmt!=null)   {
				stmt.close();
			}
		 
		return lastPage;
		
	} // end reviewLastPage
	
	// 리뷰 삭제
	public int deleteReview(Connection conn, int reviewNo) throws SQLException {
		
		String sql="DELETE FROM review WHERE review_no=?";
		PreparedStatement stmt = null;
		int deleteReview = 0;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, reviewNo);
			
			deleteReview = stmt.executeUpdate();
			
			// 디버깅
			System.out.println("deleteReview : " + deleteReview);
			
		} finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		return deleteReview;
		
	}
	
	// 리뷰 수정
	public int updateReview(Connection conn, Review review) throws SQLException {
		
		String sql = "UPDATE review SET review_content=?, update_date=NOW() WHERE review_no=? ";
		PreparedStatement stmt = null;
		int updateReview = 0;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, review.getReviewContent());
			stmt.setInt(2, review.getReviewNo());
			
			updateReview = stmt.executeUpdate();
			
			// 디버깅
			System.out.println("updateReview >> " + updateReview);
			
		}	finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		
		return updateReview;
		
	}	// end updateReview
	
	
}
