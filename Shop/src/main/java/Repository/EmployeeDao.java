package Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import vo.Employee;

public class EmployeeDao {
	
	// ID 중복체크
	public String selectIdCheck(Connection conn, String idck) throws SQLException {
		String id = null;
		
		/*
		 SELECT t.id
		 FROM (SELECT customer_id id FROM customer UNION  SELECT employee_id id FROM employee UNION ELECT out_id id FROM outid) t
		 WHERE t.id = ?
		 */
		
		String sql = "SELECT t.id FROM (SELECT customer_id id FROM customer UNION SELECT employee_id id FROM employee UNION SELECT out_id id FROM outid) t WHERE t.id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, idck);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			id = rs.getString("t.id");
		}
		
		if(rs!=null) {
			rs.close();
			
		}
		if(stmt!=null) {
			stmt.close();
		}
		
		return id;		// 사용가능한 아이디면 null 반환
		
	}
	
	
		// 탈퇴
		// CustomerService.removeCustomer(Customer paramCustomer)가 호출
		public int deleteEmployee(Connection conn, Employee paramEmployee) throws ClassNotFoundException, SQLException {

			// 동일한 conn
			// conn.close() X		
			
			String sql = "DELETE FROM employee WHERE employee_id=? And employee_pass=PASSWORD(?)";
			PreparedStatement stmt = null;
			int row = 0;
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramEmployee.getEmployeeId());
			stmt.setString(2, paramEmployee.getEmployeePass());
			
			row = stmt.executeUpdate();
			
			// 디버깅
			System.out.println("row : " + row);
			
			if(stmt!=null)   {
				stmt.close();
			}
				
			return row;
			
		}	// end deleteEmployee
		
		// Employee 로그인
		public Employee selectEmployeeByIdAdnPw(Connection conn, Employee employeeLogin) throws SQLException {
			
			String sql = "SELECT employee_id,employee_pass,employee_name,update_date,create_date,active FROM employee WHERE employee_id=? AND employee_pass=PASSWORD(?)";
			PreparedStatement stmt = null;
			ResultSet rs = null;
			Employee login = null;
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, employeeLogin.getEmployeeId());
			stmt.setString(2, employeeLogin.getEmployeePass());
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				login = new Employee();
				login.setEmployeeId(rs.getString("employee_id"));
				login.setEmployeePass(rs.getString("employee_pass"));
				login.setEmployeeName(rs.getString("employee_name"));
				login.setActive(rs.getString("active"));
				
			}
			
			if(rs!=null)   {
				rs.close();
			}
			if(stmt!=null) {
				stmt.close();
			}
			
			// 디버깅
			System.out.println("login : " + login);
			
			return login;
			
		}	// end selectEmployeeByIdAdnPw
		
		public int insertEmployee(Connection conn, Employee employeeadd) throws SQLException {
			
			String sql = "INSERT INTO employee (employee_id,employee_pass,employee_name,update_date, create_date,active ) VALUES (?,PASSWORD(?),?,NOW(),NOW(),'N')";
			PreparedStatement stmt = null;
			int row = 0;
			
	         stmt = conn.prepareStatement(sql);
	         stmt.setString(1, employeeadd.getEmployeeId());
	         stmt.setString(2, employeeadd.getEmployeePass());
	         stmt.setString(3, employeeadd.getEmployeeName());
			 
	         row = stmt.executeUpdate();
	         
	         // 디버깅
	         System.out.println("row : " + row);
	         
	         if(stmt!=null)   {
					stmt.close();
				}
	         
			return row;
			 
			
		}	// end insertCustomer
		
		// employeeList.jsp
		public ArrayList<Employee> selectEmployeeList(Connection conn, final int rowPerPage, int beginRow) throws SQLException{
	
			ArrayList<Employee> list = new ArrayList<Employee>();


			String sql = "SELECT employee_id, employee_pass, employee_name, update_date, create_date, active FROM employee LIMIT ?,?";
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			rs = stmt.executeQuery();
			
			System.out.println("rowPerPage >> "+ rowPerPage);
			System.out.println("beginRow >> "+ beginRow);
			
			while(rs.next()) {
				Employee employee = new Employee();
				employee.setEmployeeId(rs.getString("employee_id"));
				employee.setEmployeeName(rs.getString("employee_name"));
				employee.setEmployeePass(rs.getString("employee_pass"));
				employee.setUpdateDate(rs.getString("update_date"));
				employee.setCreateDate(rs.getString("create_date"));
				employee.setActive(rs.getString("active"));
				list.add(employee);
			}
			
			
			if(rs!=null)   {
				rs.close();
			}
			if(stmt!=null)   {
				stmt.close();
			}
			return list;
			
		}	// end selectEmployeeList
		
		public int lastPage(Connection conn, int rowPerPage) throws SQLException {
			
			String sql = "SELECT COUNT(*) FROM employee";
			PreparedStatement stmt = null;
			ResultSet rs = null;
			int totalRow = 0;
			int lastPage = 0;
			
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
		}
		
		
		// active 변경
		public int updateEmployeeActive (Connection conn,Employee employee) throws SQLException {
			
			String sql = "UPDATE employee SET active=? WHERE employee_id=?";
			PreparedStatement stmt = null;
			int row = 0;
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, employee.getActive());
			stmt.setString(2, employee.getEmployeeId());
			
			row = stmt.executeUpdate();
			
			// 디버깅
			System.out.println("row : " + row);
			
			if(stmt!=null)   {
				stmt.close();
			}
			
			return row;
			
			
		}	// end updateEmployeeActive
		
	}	// end class








