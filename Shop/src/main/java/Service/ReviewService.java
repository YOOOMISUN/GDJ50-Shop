package Service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import Repository.ReviewDao;
import vo.Review;

public class ReviewService {
	private ReviewDao reviewDao;
	
	// 리뷰 추가
	public int addReview(Review review) {
		
		Connection conn = null;
		int addReview = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);			// 자동 커밋 X
			
			this.reviewDao = new ReviewDao();
			addReview = reviewDao.insertReview(conn, review);
			
			// 디버깅
			System.out.println("addReview : " + addReview);
			
			if(addReview == 0) {
				throw new Exception();
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
		return addReview;
	}	// end addReview
	
	// 리뷰 목록,페이징
	public List<Map<String,Object>> getReviewListByPage(int rowPerPage, int currentPage,int goodsNo){
		
		List<Map<String,Object>> list = null;
		Connection conn = null;
		int beginRow=(currentPage-1)*rowPerPage;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
				
			this.reviewDao = new ReviewDao();
			list = reviewDao.selectReviewListByPage(conn, rowPerPage, beginRow, goodsNo);
			
			// 디버깅
			System.out.println("list : " + list);
					
			if(list==null) {		// list가 null이면 예외처리로..
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
				return list;
				
		}	// end getReviewListByPage
	
	// 리뷰 목록 페이징
	public int ReviewListLastPage(int rowPerPage) {
		
		Connection conn = null;
		this.reviewDao = new ReviewDao();
		
		try {
			conn=new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			rowPerPage = reviewDao.reviewLastPage(conn, rowPerPage);
			
			// 디버깅
			System.out.println("rowPerPage" + rowPerPage);
			
			if(rowPerPage == 0) {			// 실패시 예외처리로..
				throw new Exception();
			}
			
		} catch(Exception e){
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
		
	}	// end ReviewListLastPage
	
	// 리뷰삭제
	public int removeReview(int reviewNo) {
		
		Connection conn = null;
		this.reviewDao = new ReviewDao();
		int removeReview = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			removeReview = reviewDao.deleteReview(conn, reviewNo);
			
			// 디버깅
			System.out.println("removeReview : " + removeReview);
			
			if(removeReview == 0) {			// 값이 0이면 예외처리로..
				throw new Exception();
			}
			
			conn.commit();
			
		} catch(Exception e){
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
		return removeReview;
		
	}
	
	// 리뷰 수정
	public int modifyReview(Review review) {
		
		Connection conn = null;
		this.reviewDao = new ReviewDao();
		int modifyReview = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			modifyReview = reviewDao.updateReview(conn, review);
			
			// 디버깅
			System.out.println("modifyReview : " + modifyReview);
			
			if(modifyReview == 0) {			
				throw new Exception();
			}
			
			conn.commit();
			
		} catch(Exception e){
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
		return modifyReview;
	}
	
}
