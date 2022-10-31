package Service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import Repository.OrdersDao;
import vo.Customer;
import vo.Orders;

public class OrdersService {
	private OrdersDao ordersDao;
	
	// 주문 상태값 변경(updateOrdersAction.jsp)
	public int modifyupdateOrdersState(Orders orders) {
		
		Connection conn = null;
		int row = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			this.ordersDao = new OrdersDao();
			row = ordersDao.updateOrdersState(conn, orders);
			
			if(row == 0) {
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
		
		return row;
		
	}	// end modifyupdateOrdersState
	
	
	// 5-2) 주문상세보기
	public Map<String, Object> getOrdersOne(int ordersNo){
		
		Connection conn = null;
		Map<String, Object> map = new HashMap<>();
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			OrdersDao ordersDao = new OrdersDao();
			map = ordersDao.selectOrdersOne(conn, ordersNo);
			
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
		return map;
		
	}	// end getOrdersOne
	
	// 5-1) 전체 주문 목록(관리자)
	public List<Map<String, Object>> getOrdersList(int rowPerPage, int currentPage){
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		Connection conn = null;
		int beginRow = (currentPage-1)*rowPerPage;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			OrdersDao orderDao = new OrdersDao();
			list = orderDao.selectOrdersList(conn, rowPerPage, beginRow);
			
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
	
	}	// end getOrdersList
	
	// 5-1) 전체 주문 목록(관리자) 페이징
	public int getOrdersLastPage(int rowPerPage) {
		
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			OrdersDao orderDao = new OrdersDao();
			rowPerPage = orderDao.ordersLastPage(conn, rowPerPage);
			
			if(rowPerPage==0) {
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
		
	}	// end getOrdersLastPage
	
	// 2-1) 고객 한명의 주문 목록(관리자, 고객)
	public List<Map<String, Object>> getOrdersListByCustomer(String customerId,int rowPerPage, int currentPage){
		 
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;
		int beginRow = (currentPage-1)*rowPerPage;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			OrdersDao orderDao = new OrdersDao();
			list = orderDao.selectOrdersListByCustomer(conn, customerId, rowPerPage, beginRow);
			
			if(list==null) {
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
		
		return list;
		
	}	// end getOrdersListByCustomer
	
	// 2-1) 고객 한명의 주문 목록(관리자, 고객) 페이징
		public int getordersCustomerLastPage(int rowPerPage,String customerId) {
			
			Connection conn = null;
			
			try {
				conn = new DBUtil().getConnection();
				conn.setAutoCommit(false);
				
				OrdersDao orderDao = new OrdersDao();
				rowPerPage = orderDao.ordersCustomerLastPage(conn, customerId, rowPerPage);
				
				
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
			
		}	// end ordersCustomerLastPage
		
	
	// 주문하기 (ordersAction.jsp)	
	public int addOrders(Orders orders) {
		
		Connection conn = null;
		int addorders = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			OrdersDao orderDao = new OrdersDao();
			addorders = orderDao.insertOrders(conn, orders);
			
			// 디버깅
			System.out.println("addorders : " + addorders);
			
			if(addorders == 0) {
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
		
		return addorders;
	}
	
	
	
	
	
	
	
}
