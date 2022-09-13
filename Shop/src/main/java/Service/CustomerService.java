package Service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import Repository.CustomerDao;
import Repository.GoodsDao;
import Repository.OutIdDao;
import vo.Customer;
// 다른 메서드 호출
// dao가 해서는 안되는 내용   비긴 로우같은것

public class CustomerService {
	private CustomerDao customerDao;
	
	
	// id 중복체크
	public String getIdCheck(String idck) {
		Connection conn = null;
		String id = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			this.customerDao = new CustomerDao();
			id = customerDao.selectIdCheck(conn, idck);
			
			// 디버깅
			System.out.println("ID : " + id);
			
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
		return id;
	}	// end getIdCheck
	
	
	// 회원탈퇴 액션 페이지로
	public boolean removeCustomer(Customer paramCustomer) {
		
		Connection conn = null;

		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행시 자동 commit 안되게 잠그는것

			CustomerDao customerDao = new CustomerDao();
			if (customerDao.deleteCustomer(conn, paramCustomer) != 1) { // 삭제 실패하면 예외처리로
				throw new Exception();
			}

			OutIdDao OutIdDao = new OutIdDao();
			if (OutIdDao.insertOutId(conn, paramCustomer.getCustomerId()) != 1) { // 추가 실패하면 예외처리로
				throw new Exception();

			}
			conn.commit();

			// 두개 중 하나라도 예외가 걸리면 rollback이 걸림
			// 예외 안걸리면 커밋 실행
		} catch (Exception e) {
			e.printStackTrace(); // consol에 예외메세지 출력
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}

			return false; // 탈퇴 실패

		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true; // 탈퇴 성공

	} // end removeCustomer

	// customer로그인
	public Customer getCustomerLogin(Customer customerLogin) {

		Connection conn = null;
		Customer selectCustomer = new Customer();

		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행시 자동 commit 안되게 잠그는것

			CustomerDao customerDao = new CustomerDao();
			selectCustomer = customerDao.selectCustomerByIdAdnPw(conn, customerLogin);

			if(selectCustomer==null) {
				throw new Exception();
			}	// selectCustomer이 null일 경우 예외처리로..
			
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
		return selectCustomer;

	} // end getCustomerLogin
	
	
	// customer 회원가입
	public int addCustomerLogin(Customer customeradd) {
		
		Connection conn = null;
		int insertCustomer = 0;
		
		try {
			conn = new DBUtil().getConnection();
			
			this.customerDao = new CustomerDao();
			insertCustomer = customerDao.insertCustomer(conn, customeradd);
			
			// 디버깅
			System.out.println("insertCustomer : " + insertCustomer);
			
			if(insertCustomer==0) {
				throw new Exception();
			}	
			
			conn.commit();
			
		} catch (Exception e){
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
		return insertCustomer;
		
		
	}	// end addCustomerLogin 
	
	// 고객 리스트, 페이징
	public List<Customer> getCustomerList(int rowPerPage, int currentPage){
		
		Connection conn = null;
		List<Customer> customerList = null;
		
		try {
			conn = new DBUtil().getConnection();
			
			this.customerDao = new CustomerDao();
			customerList = customerDao.selectCustomerListByPage(conn, rowPerPage, currentPage);
			
			// 디버깅
			System.out.println("customerList : " + customerList);
			
			if(customerList==null) {
				throw new Exception();
			}
			
		} catch (Exception e){
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
		return customerList;
		
	}	// end getCustomerList
	
	// 고객리스트 페이징
	public int getCustomerLastPage(int rowPerPage) {
		
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);			// 자동 커밋 안되게
			
			this.customerDao = new CustomerDao();
			rowPerPage = customerDao.customerLastPage(conn, rowPerPage);
	
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
	}	// end getCustomerLastPage
	
	// updateCustomerAction.jsp (정보수정)
		public int modifyCustomer(Customer customer) {
			
			Connection conn = null;
			int updateCustomer = 0;
			
			try {
				conn = new DBUtil().getConnection();
				
				this.customerDao = new CustomerDao();
				updateCustomer = customerDao.updateCustomer(conn, customer);
				
				// 디버깅
				System.out.println("updateCustomer : " + updateCustomer);
				
				if(updateCustomer==0) {
					throw new Exception();
				}	
				
				conn.commit();
				
			} catch (Exception e){
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
			return updateCustomer;
			
			
		}	// end modifyCustomer 
		
	
	
	

}
