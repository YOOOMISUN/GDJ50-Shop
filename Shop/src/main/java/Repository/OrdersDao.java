package Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Orders;

public class OrdersDao {

	// 주문상태값변경(updateOrdersAction.jsp)
	public int updateOrdersState(Connection conn, Orders orders) throws SQLException {
		
		int row = 0;
		String sql = "UPDATE orders SET order_state=? WHERE order_no=?";
		PreparedStatement stmt = null;
		stmt=conn.prepareStatement(sql);
		stmt.setString(1, orders.getOrderState());
		stmt.setInt(2, orders.getOrderNo());
		
		row = stmt.executeUpdate();
		
		// 디버깅
		System.out.println("row >> " + row);
		
		
		if(stmt != null) {
			stmt.close();
		}
		
		return row;
		
	}	// end updateOrdersState
	
	// 5-2) 주문상세보기
	public Map<String, Object> selectOrdersOne(Connection conn, int ordersNo) throws SQLException {
		Map<String, Object> map = null;

		/*
			SELECT o.order_no, o.goods_no, o.order_quantity, o.order_price, o.order_addr, o.order_state,g.goods_name,g.goods_price,
			c.customer_id,c.customer_name, c.customer_address, c.customer_telephone
			FROM orders o OUTER JOIN goods g ON o.goods_no = g.goods_no OUT JOIN customer c  ON o.customer_id = c.customer_id WHERE o.order_no = ?"; 
		 */

		String sql = "SELECT o.order_no, o.goods_no, o.order_quantity, o.order_price, o.order_addr, o.order_detailAddr,o.order_state,o.update_date, o.create_date,g.goods_name,g.goods_price,\r\n"
				+ "	  c.customer_id,c.customer_name, c.customer_address,c.customer_detailAddr, c.customer_telephone\r\n"
				+ "	  FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no INNER JOIN customer c ON o.customer_id = c.customer_id WHERE o.order_no = ?";
		
		// INNER JOIN 쓰면 탈퇴할때 조회가 안되므로 OUTER JOIN을 씀
		
		PreparedStatement stmt = null;
		ResultSet rs = null;

		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		rs = stmt.executeQuery();

		while (rs.next()) {
			map = new HashMap<String, Object>();
			map.put("orderNo", rs.getInt("order_no"));
			map.put("goodsNo", rs.getInt("goods_no"));
			map.put("orderQuantity", rs.getString("order_quantity"));
			map.put("orderPrice", rs.getInt("goods_price")*rs.getInt("order_quantity"));
			map.put("orderAddr", rs.getString("order_addr"));
			map.put("orderDetailAddr", rs.getString("order_detailAddr"));
			map.put("orderState", rs.getString("order_state"));
			map.put("updateDate", rs.getString("update_date"));
			map.put("createDate", rs.getString("create_date"));
			map.put("goodsName", rs.getString("goods_name"));
			map.put("goodsPrice", rs.getInt("goods_price"));
			map.put("customerId", rs.getString("customer_id"));
			map.put("customerName", rs.getString("customer_name"));
			map.put("customerAddress", rs.getString("customer_address"));
			map.put("customerDetailAddr", rs.getString("customer_detailAddr"));
			map.put("customerTelephone", rs.getString("customer_telephone"));

		}

		if (rs != null) {
			rs.close();
		}
		if (stmt != null) {
			stmt.close();
		}

		return map;
	}

	// 5-1) 전체 주문 목록(관리자)
	public List<Map<String, Object>> selectOrdersList(Connection conn, int rowPerPage, int beginRow) throws SQLException {
		List<Map<String, Object>> list = new ArrayList<>(); // 다형성
		Map<String, Object> map = null;
		/*
		SELECT o.order_no, o.goods_no, o.order_quantity, o.order_price, o.order_state ,o.order_addr,o.update_date,o.create_date, g.goods_name,g.goods_price, g.sold_out
		FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no ORDER BY create_date DESC LIMIT ?, ?";
		 */

		String sql = "SELECT o.order_no, o.goods_no, o.customer_id, o.order_quantity, o.order_price, o.order_state ,o.order_addr, o.order_detailAddr ,o.update_date,o.create_date, g.goods_name,g.goods_price, g.sold_out \r\n"
				+ "	  FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);

		rs = stmt.executeQuery();

		while (rs.next()) {
			map = new HashMap<String, Object>();
			map.put("orderNo", rs.getInt("order_no"));
			map.put("goodsNo", rs.getInt("goods_no"));
			map.put("customerId", rs.getString("customer_id"));
			map.put("orderQuantity", rs.getString("order_quantity"));
			map.put("orderPrice",  rs.getInt("goods_price")*rs.getInt("order_quantity"));
			map.put("orderAddr", rs.getString("order_addr"));
			map.put("orderDetailAddr", rs.getString("order_detailAddr"));
			map.put("orderState", rs.getString("order_state"));
			map.put("createDate", rs.getString("create_date"));
			map.put("goodsName", rs.getString("goods_name"));
			map.put("goodsPrice", rs.getString("goods_price"));
			map.put("soldOut", rs.getString("sold_out"));

			list.add(map);

		}
		if (rs != null) {
			rs.close();
		}
		if (stmt != null) {
			stmt.close();
		}

		return list;
	}

	public int ordersLastPage(Connection conn, int rowPerPage) throws SQLException {
		
		String sql = "SELECT COUNT(*) FROM orders";
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
		System.out.println("lastPage >> " + lastPage);
		
		return lastPage;
		
		
	}
	
	// 2-1) 고객 한명의 주문 목록(관리자, 고객)
	public List<Map<String, Object>> selectOrdersListByCustomer(Connection conn, String customerId, int rowPerPage, int beginRow) throws SQLException{
	      List<Map<String, Object>> list = null; 
	      Map<String, Object> map = null;
	      
	      String sql = "SELECT o.order_no ordersNo, o.order_quantity ordersQuantity"
	            + ", o.order_price ordersPrice, o.order_addr ordersAddr, o.order_detailAddr orderDetailAddr, o.order_state ordersState"
	            + ", o.create_date createDate"
	            + ", g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice"
	            + ", c.customer_id customerId, c.customer_name customerName"
	            + " FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no"
	            + " INNER JOIN customer c ON o.customer_id = c.customer_id"
	            + " WHERE c.customer_id = ?"
	            + " ORDER BY o.create_date DESC LIMIT ?, ?";

	      PreparedStatement stmt = null;
	      ResultSet rs = null;
	      
	      try {
	         list = new ArrayList<>();
	          
	         stmt = conn.prepareStatement(sql);
	         stmt.setString(1, customerId);
	         stmt.setInt(2, beginRow);
	         stmt.setInt(3, rowPerPage);
	         
	         rs = stmt.executeQuery();
	         
	         while(rs.next()) {
	            map = new HashMap<String, Object>();
	            map.put("ordersNo", rs.getInt("ordersNo"));
	            map.put("ordersQuantity", rs.getInt("ordersQuantity"));
	            map.put("ordersPrice", rs.getInt("goodsPrice")*rs.getInt("ordersQuantity"));
	            map.put("ordersAddr", rs.getString("ordersAddr"));
	            map.put("orderDetailAddr", rs.getString("orderDetailAddr"));
	            map.put("ordersState", rs.getString("ordersState"));
	            map.put("createDate", rs.getString("createDate"));
	            map.put("goodsNo", rs.getInt("goodsNo"));
	            map.put("goodsName", rs.getString("goodsName"));
	            map.put("goodsPrice", rs.getInt("goodsPrice"));
	            map.put("customerId", rs.getString("customerId"));
	            map.put("customerName", rs.getString("customerName"));
	            
	            list.add(map);
	         }
	      } finally {
	         if(rs != null) {
	            rs.close();
	         }
	         if(stmt != null) {
	            stmt.close();
	         }
	      }
	      return list;
	   }
	
	// 2-1) 고객 한명의 주문 목록 (마지막페이지)
	public int ordersCustomerLastPage(Connection conn,String customerId, int rowPerPage) throws SQLException {
		
		String sql = "SELECT COUNT(*) FROM orders WHERE customer_id = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int lastPage = 0;
		int totalRow = 0;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			rs = stmt.executeQuery();

			if(rs.next()) {
				totalRow = rs.getInt("COUNT(*)");
			}
			
			lastPage = totalRow / rowPerPage;
			if(totalRow % rowPerPage != 0) {
				lastPage += 1;
			}
			
		} finally {
			  if(rs != null) {
		            rs.close();
		         }
		         if(stmt != null) {
		            stmt.close();
		         }
		}
		
		// 디버깅
		System.out.println("lastPage >> " + lastPage);
		
		return lastPage;
		
	}	// end ordersCustomerLastPage
	
	// 주문하기 (ordersAction.jsp)	
	public int insertOrders(Connection conn, Orders orders) throws SQLException {
		
		String sql = "INSERT INTO orders (order_no, goods_no, customer_id, order_quantity, order_price, order_addr, order_detailAddr,order_state, create_date,update_date) VALUES (?,?,?,?,?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = null;
		int insertOrders = 0;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orders.getOrderNo());
			stmt.setInt(2, orders.getGoodsNo());
			stmt.setString(3, orders.getCustomerId());
			stmt.setInt(4, orders.getOrderQuantity());
			stmt.setInt(5, orders.getOrderPrice());
			stmt.setString(6, orders.getOrderAddr());
			stmt.setString(7, orders.getOrderDetailAddr());
			stmt.setString(8, orders.getOrderState());
			
			insertOrders = stmt.executeUpdate();
			
			// 디버깅
			System.out.println("insertOrders : " + insertOrders);
			
		} finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		return insertOrders;
		
	}	//	end insertOrders
	
	

}
