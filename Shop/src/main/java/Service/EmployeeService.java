package Service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import Repository.EmployeeDao;
import Repository.OutIdDao;
import vo.Employee;

public class EmployeeService {
	private EmployeeDao employeeDao;
	
	
	// id 중복체크
	public String getIdCheck(String idck) {
		Connection conn = null;
		String id = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			this.employeeDao = new EmployeeDao();
			id = employeeDao.selectIdCheck(conn, idck);
			
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
	public boolean removeEmployee(Employee paramEmployee) {
		Connection conn = null;

		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행시 자동 commit 안되게 잠그는것

			EmployeeDao employeeDao = new EmployeeDao();
			if (employeeDao.deleteEmployee(conn, paramEmployee) != 1) { // 삭제 실패하면 예외처리로
				throw new Exception();
			}

			OutIdDao OutIdDao = new OutIdDao();
			if (OutIdDao.insertOutId(conn, paramEmployee.getEmployeeId()) != 1) { // 추가 실패하면 예외처리로
				throw new Exception();

			}
			conn.commit();

			// 두 개 중 하나라도 예외가 걸리면 rollback이 걸림
			// 예외 안걸리면 커밋 실행
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
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

	}	// end removeEmployee

	// 관리자 로그인
	public Employee getEmployeeLogin(Employee employeeLogin) {

		Connection conn = null;
		Employee selectEmployee = null;

		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);

			EmployeeDao employeeDao = new EmployeeDao();
			selectEmployee = employeeDao.selectEmployeeByIdAdnPw(conn, employeeLogin);

			// 디버깅
			System.out.println("selectEmployee : " + selectEmployee);
			conn.commit();

		} catch (Exception e) {
			e.printStackTrace();	 // console에 예외메세지 출력
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

		return selectEmployee;

	}	// end getEmployeeLogin
	
	// 관리자 회원가입
	public int addEmployeeLogin(Employee employee) {
		
		Connection conn = null;
		int addEmployee = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			EmployeeDao employeeDao = new EmployeeDao();
			addEmployee = employeeDao.insertEmployee(conn, employee);
			
			if(addEmployee==0) {
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
		
		return addEmployee;
	}
	

	// employeeList.jsp 페이징 처리
	public ArrayList<Employee> getEmployeeList(int rowPerPage, int currentPage){
		
		ArrayList<Employee> list = new ArrayList<Employee>();
		
		Connection conn = null;
		int beginRow = (currentPage-1)*rowPerPage;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);			// 자동 커밋 막아줌
		
			EmployeeDao employeeDao = new EmployeeDao();
			list = employeeDao.selectEmployeeList(conn, rowPerPage, beginRow);
			
			// 디버깅
			System.out.println("list : " + list);
			
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
	}	// end getEmployeeList
	
	
	public int getlastPage(int rowPerPage) {
		
		Connection conn = null;
		int page = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			EmployeeDao employeeDao = new EmployeeDao();
			page = employeeDao.lastPage(conn, rowPerPage);
	
			if(rowPerPage==0) {
				throw new Exception();
			}
			
			// 디버깅
			System.out.println("rowPerPage : " + page);
			
			
	     if(page == 0) {	// 실패시 예외처리로..
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
	      return page;
	}
	
	
	// active 변경
	public int modifyEmployeeActive(Employee employeeActive) {
		
		Connection conn = null;
		int active = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
		
			EmployeeDao employeeDao = new EmployeeDao();
			active = employeeDao.updateEmployeeActive(conn, employeeActive);
			
			// 디버깅
			System.out.println("active : " + active);
			
			if(active == 0) {	// 실패시 예외처리로..
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
		return active;
		
	}
	
	
	
}
