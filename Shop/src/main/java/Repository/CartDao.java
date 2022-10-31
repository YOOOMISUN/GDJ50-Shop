package Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Cart;

public class CartDao {
	
	// 장바구니 리스트, 페이징
	public List<Cart> selectCart(Connection conn, int rowPerPage, int beginRow) throws SQLException{
		
		List<Cart> list = new ArrayList<>();
		
		String sql = "SELECT cart_no cartNo, customer_id customerId, goods_no goodsNo, goods_name goodsName, goods_price goodsPrice, goods_quantity goodsQuantity, DATE_FORMAT(create_date,'%Y-%m-%d %T') create_date FROM cart ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		
		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Cart cart = new Cart();
			cart.setCartNo(rs.getInt("cart_no"));
			cart.setCustomerId(rs.getString("customer_id"));
			cart.setGoodsNo(rs.getInt("goods_no"));
			cart.setGoodsName(rs.getString("goods_name"));
			cart.setGooodsPrice(rs.getInt("goods_price"));
			cart.setGoodsQuantity(rs.getInt("goods_quantity"));
			cart.setCreateDate(rs.getString("create_date"));
			
			System.out.println("cart : " + cart);
			
			list.add(cart);
			
			System.out.println("list : " + list);
		}
		
		if(rs!=null) {
			rs.close();
		}
		if(stmt!=null) {
			stmt.close();
		}
		
		return list;
	}
	
	// 장바구니 페이징 (cart.jsp) 
	public int cartListLastPage(Connection conn, int rowPerPage) throws SQLException {
	
	String sql = "SELECT COUNT(*) FROM cart";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	int lastPage=0;
	int totalRow = 0;
	
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	
	if(rs.next()) {
		totalRow = rs.getInt("COUNT(*)");
	}
	
	lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage +=1;
	}
	
	 if(rs!=null)   {
			rs.close();
		}
	 if(stmt!=null)   {
			stmt.close();
		}
	 
	return lastPage;
	
	} // end cartListLastPage
	
	
	// 장바구니 추가
	public int insertCart(Connection conn, Cart addCart) throws SQLException {
		
		String sql = "INSERT INTO cart (cart_no, customer_id, goods_no, goods_name, goods_price, goods_quantity, create_date) VALUES (?,?,?,?,?,1,NOW())";
		PreparedStatement stmt = null;
		int insertCart = 0;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, addCart.getCartNo());
			stmt.setString(2, addCart.getCustomerId());
			stmt.setInt(3, addCart.getGoodsNo());
			stmt.setString(4, addCart.getGoodsName());
			stmt.setInt(5, addCart.getGooodsPrice());
			
			insertCart = stmt.executeUpdate();
			
			System.out.println("insertCart : " + insertCart);
			
		} finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		
		return insertCart;
		
	}	//	end insertCart
	
	
	// 장바구니 삭제
	public int deleteCart(Connection conn, int deleteCart) throws SQLException {
		
		String sql = "DELETE FROM cart WHERE cart_no=?";
		PreparedStatement stmt = null;
		int cart = 0;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, deleteCart);
			
			cart = stmt.executeUpdate();
			
			// 디버깅
			System.out.println("cart : " + cart);
			
		} finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		return cart;
		
	}	// end deleteCart
	
	
	
	
	
	
	
}
