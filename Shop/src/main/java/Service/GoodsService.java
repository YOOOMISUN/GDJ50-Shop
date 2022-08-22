package Service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import Repository.GoodsDao;
import Repository.GoodsImgDao;
import vo.Goods;
import vo.GoodsImg;

// 트랜잭션 + action이나 dao가 해서는 안되는 일
public class GoodsService {
	private GoodsDao goodsDao; // 디커플링 되어서 더 느슨하게 사용가능
	private GoodsImgDao goodsImgDao;
	
	// 고객 상품 리스트 페이지에서 사용 (customerGoodsList.jsp)
	public List<Map<String,Object>> getCustomerGoodsListByPage(int rowPerPage, int currentPage){
		
		List<Map<String,Object>> list = null;
		
		Connection conn = null;
		this.goodsDao = new GoodsDao();
		this.goodsImgDao = new GoodsImgDao();
		
		int beginRow = (currentPage-1)*rowPerPage;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			list = goodsDao.selectCustomerGoodsListByPage(conn, rowPerPage, beginRow);
			
			// 디버깅
			System.out.println("list : " + list);
			
			if(list==null) {
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
		
	} 
	
	// customerGoodsList.jsp 페이징
	public int getCustomerGoodsListLastPage(int rowPerPage) {
		
		Connection conn = null;
		this.goodsDao = new GoodsDao();
		
		try {
			conn=new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			rowPerPage = goodsDao.CustomerGoodsListLastPage(conn, rowPerPage);
			
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
		
	}	// end getCustomerGoodsListLastPage
	
	
	// 상품 수정
	public int modifyGoodsUpdate(Goods goods, GoodsImg goodsImg) {
		Connection conn = null;
		this.goodsDao = new GoodsDao();
		this.goodsImgDao = new GoodsImgDao();
		int row = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);		
			
			row = goodsDao.updateGoods(conn, goods);
			
			// 디버깅
			System.out.println("modifyGoodsUpdateRow : " + row);
			
			if(row != 0) {
				row = goodsImgDao.updateGoodsImg(conn, goodsImg);
				
				if(row == 0) {
					throw new Exception();			// 이미지 추가 실패시 강제로 롤백(catch절로 이동)
				}
			}
			
			System.out.println("row ** " + row);
			
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
		
		
		return row;
	}
	
	
	// 상품추가
	public int addGoods(Goods goods, GoodsImg goodsImg) {
		Connection conn = null;
		int goodsNo = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);			// 자동 커밋 안되게
			
			goodsDao = new GoodsDao();
			goodsImgDao = new GoodsImgDao();
			
			goodsNo = goodsDao.insertGoods(conn, goods);		// goodsNo가 AI로 자동생성되어 DB입력
			
			if(goodsNo != 0) {
				goodsImg.setGoodsNo(goodsNo);		
			
				if(goodsImgDao.insertGoodsImg(conn, goodsImg) == 0) {
					throw new Exception();							// 이미지 입력 실패시 강제로 롤백(catch절로 이동)
			}
				
			}
			conn.commit();
			
			
		} catch(Exception e) {
			e.addSuppressed(e);
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
		
		return goodsNo;
		
	}	// end addGoods
	
	// 상품 상세페이지
	public Map<String,Object> getGoodsAndImgOne(int goodsNo) {
		
		Map<String,Object> map = null;
		Connection conn = null;
		this.goodsDao = new GoodsDao();
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);			// 자동 커밋 안되게
			
			
			map = goodsDao.selectGoodsAndImgOne(conn, goodsNo);
			
			if(map==null) {
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
		// 
		System.out.println("map : " + map);
		
		return map;
	
	}	// end getGoodsAndImgOne
	
	// 상품 리스트, 페이징
	public List<Goods> selectGoodsListByPage(int rowPerPage, int currentPage) {
		List<Goods> list = null;
		this.goodsDao = new GoodsDao();
		
		int beginRow = (currentPage-1)*rowPerPage;

		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);				// 자동 커밋 안되게
			
			list = goodsDao.selectGoodsListByPage(conn, rowPerPage, beginRow);
			
			
			// 디버깅
			System.out.println("list : " + list);
			
			if(list==null) {
				throw new Exception();
			}
			
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
		return list;
	}	// end selectGoodsListByPage
	
	
	// 상품 리스트 페이징
	public int getGoodsLastPage(int rowPerPage) {
		
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);			// 자동 커밋 안되게
			
			GoodsDao goodsDao = new GoodsDao();
			rowPerPage = goodsDao.goodsLastPage(conn, rowPerPage);
	
			// 디버깅
			System.out.println("rowPerPage : " + rowPerPage);
			
	     if(rowPerPage == 0) {	// 실패시 예외처리로..
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
	      return rowPerPage;
	}	// end getGoodsLastPage
	
	// 상품삭제
	public int removeGoods(Goods goods, GoodsImg goodsImg) {
	
		Connection conn = null;
		int removeGoods = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			goodsDao = new GoodsDao();
			goodsImgDao = new GoodsImgDao();
				
			// 이미지 먼저 삭제하고 상품 삭제
			if(goodsImgDao.deleteGoodsImg(conn, goodsImg) != 0) {
				removeGoods = goodsDao.deleteGoods(conn, goods);
			
				if(goodsDao.deleteGoods(conn, goods) == 0) {
					throw new Exception();					// 이미지 삭제 실패시 예외처리로
				}	
			}
			// 디버깅
			System.out.println("removeGoods : " + removeGoods);
			
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
		return removeGoods;
	}
	
}
