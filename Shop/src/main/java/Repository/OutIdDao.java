package Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class OutIdDao {
	// 탈퇴 회원의 아이디를 입력
	// CustomerService.removeCustomer(Customer paramCustomer)가 호출
	public int insertOutId(Connection conn, String outId) throws ClassNotFoundException, SQLException {
		// 동일한 conn
		// conn.close() X
		
		String sql = "INSERT INTO outid (out_id, out_date) VALUES (?,NOW())";
		PreparedStatement stmt = null;
		int row = 0;

		stmt = conn.prepareStatement(sql);
		stmt.setString(1, outId);
		
		row = stmt.executeUpdate();
		
		stmt.close();
		
		return row;
		
		
	}
	
}
