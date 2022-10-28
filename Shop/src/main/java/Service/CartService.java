package Service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.el.ELException;

import Repository.CartDao;
import vo.Cart;

public class CartService {
	private CartDao cartDao;
	
	// 장바구니 리스트
	public List<Cart> getCartList(int rowPerPage, int currentPage){
		
		List<Cart> list = new ArrayList<>();
		
		Connection conn = null;
		this.cartDao = new CartDao();
		int beginRow = (currentPage-1)*rowPerPage;

		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			list = cartDao.selectCart(conn, rowPerPage, beginRow);
			
			if(list==null) {
				throw new ELException();
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			
			try {
				conn.rollback();
			} catch(SQLException e1) {
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
	
	// 장바구니 리스트 페이징
	public int getCartListLastPage(int rowPerPage) {
		
		Connection conn = null;
		this.cartDao = new CartDao();
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			rowPerPage = cartDao.cartListLastPage(conn, rowPerPage);
		
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

	}	// end getCartListLastPage
	
	
	
	// 장바구니 추가
	public int addCart(Cart cart) {
		Connection conn = null;
		int addCart = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			this.cartDao = new CartDao();
			addCart = cartDao.insertCart(conn, cart);
			
			// 디버깅
			System.out.println("addCart : " + addCart);
			
			if(addCart == 0) {
				throw new ELException();
			}
			
			conn.commit();
			
		} catch(Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch(SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close(); 
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return addCart;
	}	// end addCart
	
	
	// 장바구니 삭제
	public int removeCart(int cartNo) {
		Connection conn = null;
		int removeCart = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			this.cartDao = new CartDao();
			removeCart = cartDao.deleteCart(conn, cartNo);
			
			// 디버깅
			System.out.println("removeCart : " + removeCart);
			
			if(removeCart == 0) {
				throw new ELException();
			}
			
			conn.commit();
			
		} catch(Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch(SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close(); 
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return removeCart;
		
	}	// end removeCart
	
	
	
	
	
}
