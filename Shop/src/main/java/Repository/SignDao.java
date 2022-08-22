package Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class SignDao {
	public String idCheck(Connection conn, String id) throws SQLException {
		String ckId = null;
		
		// SELECT t.id From (SELECT customer_id id FROM customer UNION SELECT employee_id id FROM employee UNION SELECT out_id id FROM outid) t WHERE t.id=?;
		// NULL일때 사용 가능한 아이디
		
		String sql = "SELECT t.id From (SELECT customer_id id FROM customer UNION SELECT employee_id id FROM employee UNION SELECT out_id id FROM outid) t WHERE t.id=?";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;

		stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);

		rs = stmt.executeQuery();

		if (rs.next()) {
			ckId = rs.getString("id");
		}
		
		return ckId;
	}
}
