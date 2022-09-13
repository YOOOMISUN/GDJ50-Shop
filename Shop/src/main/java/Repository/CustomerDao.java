package Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Customer;

public class CustomerDao {
	
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
	public int deleteCustomer(Connection conn, Customer paramCustomer) throws ClassNotFoundException, SQLException {

		// 동일한 conn
		// conn.close() X		
		
		String sql = "DELETE FROM customer WHERE customer_id=? And customer_pass=PASSWORD(?)";
		PreparedStatement stmt = null;
		int row = 0;
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramCustomer.getCustomerId());
		stmt.setString(2, paramCustomer.getCustomerPass());
		
		row = stmt.executeUpdate();
		
		// 디버깅
		System.out.println("row : " + row);
		
		stmt.close();
			
		return row;
		
	}
	
	
	// 로그인
	public Customer selectCustomerByIdAdnPw(Connection conn, Customer customerLogin) throws SQLException  {
		
		String sql = "SELECT customer_id,customer_pass,customer_name,customer_address,customer_detailAddr, customer_telephone,update_date,create_date FROM customer WHERE customer_id=? AND customer_pass=PASSWORD(?)";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Customer login = null;
		
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerLogin.getCustomerId());
		stmt.setString(2, customerLogin.getCustomerPass());
		rs = stmt.executeQuery();

		if(rs.next()) {
			login = new Customer();
			login.setCustomerId(rs.getString("customer_id"));
			login.setCustomerPass(rs.getString("customer_pass"));
			login.setCustomerName(rs.getString("customer_name"));
			login.setCustomerAddress(rs.getString("customer_address"));
			login.setCustomerDetailAddr(rs.getString("customer_detailAddr"));
			login.setCustomerTelephone(rs.getString("customer_telephone"));
			}
		
		stmt.close();
		
		return login;
		}
	
	
	// 회원가입
	public int insertCustomer(Connection conn, Customer customeradd) throws SQLException {
		
		String sql = "INSERT INTO customer (customer_id,customer_pass,customer_name,customer_address,customer_detailAddr,customer_telephone,update_date,create_date ) VALUES (?,PASSWORD(?),?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = null;
		int row = 0;
		
		try {
	         stmt = conn.prepareStatement(sql);
	         stmt.setString(1, customeradd.getCustomerId());
	         stmt.setString(2, customeradd.getCustomerPass());
	         stmt.setString(3, customeradd.getCustomerName());
	         stmt.setString(4, customeradd.getCustomerAddress());
	         stmt.setString(5, customeradd.getCustomerDetailAddr());
	         stmt.setString(6, customeradd.getCustomerTelephone());
			 
	         row = stmt.executeUpdate();
         
	         // 디버깅
	         System.out.println("row : " + row);
         
		} finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
			return row;
		 
	
	}	// end insertCustomer
	
	
	// 고객 리스트, 페이징
	public List<Customer> selectCustomerListByPage(Connection conn, int rowPerPage, int beginRow) throws SQLException{
		List<Customer> list = new ArrayList<>();
		
		String sql = "SELECT customer_id, customer_pass, customer_name, customer_address, customer_detailAddr, customer_telephone, update_date, create_date FROM customer LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			
			// 디버깅
			System.out.println("rs : " + rs);
			
			while(rs.next()) {
				Customer customer = new Customer();
				customer.setCustomerId(rs.getString("customer_id"));
				customer.setCustomerPass(rs.getString("customer_pass"));
				customer.setCustomerName(rs.getString("customer_name"));
				customer.setCustomerAddress(rs.getString("customer_address"));
				customer.setCustomerDetailAddr(rs.getString("customer_detailAddr"));
				customer.setCustomerTelephone(rs.getString("customer_telephone"));
				customer.setUpdateDate(rs.getString("update_date"));
				customer.setCreateDate(rs.getString("create_date"));
				
				list.add(customer);
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
		
	}	// end selectCustomerListByPage
	
	// 고객리스트 페이징
	public int customerLastPage(Connection conn, int rowPerPage) throws SQLException {
		
		String sql = "SELECT COUNT(*) FROM customer";
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
		
	} // end goodsLastPage
	
	// updateCustomerAction.jsp (정보수정)
	public int updateCustomer(Connection conn, Customer customer) throws SQLException {
		
		String sql = "UPDATE customer SET customer_pass = PASSWORD(?), customer_name=?, customer_address=?, customer_detailAddr=?, customer_telephone=?, update_date=NOW() WHERE customer_id=?";
		PreparedStatement stmt = null;
		int row = 0;
		
		try {
			stmt = conn.prepareStatement(sql);
	         stmt.setString(1, customer.getCustomerPass());
	         stmt.setString(2, customer.getCustomerName());
	         stmt.setString(3, customer.getCustomerAddress());
	         stmt.setString(4, customer.getCustomerDetailAddr());
	         stmt.setString(5, customer.getCustomerTelephone());
	         stmt.setString(6, customer.getUpdateDate());
	         stmt.setString(7, customer.getCustomerId());
			row = stmt.executeUpdate();
		
		} finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		return row;
	}
	
	
}
