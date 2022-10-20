package Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Goods;

public class GoodsDao {

	// 고객 상품 리스트 페이지에서 사용 (Index.jsp)
	public List<Map<String,Object>> selectCustomerGoodsListByPage (Connection conn, int rowPerPage, int beginRow) throws SQLException{
		
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String,Object> map = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		/* 고객의 판매량수 많은 것부터
		        SELECT g.goods_no goodsNo
             , g.goods_name goodsName
             , g.goods_price goodsPrice
             , gi.filename filename
       FROM
       goods g LEFT JOIN (SELECT goods_no, SUM(order_quantity) sumNum
                      FROM orders
                      GROUP BY goods_no) t
                      ON g.goods_no = t.goods_no
                         INNER JOIN goods_img gi
                         ON g.goods_no = gi.goods_no
       ORDER BY IFNULL(t.sumNUm, 0) DESC
		*/ 
		
		String sql = "  SELECT g.goods_no goodsNo\r\n"
				+ "             , g.goods_name goodsName\r\n"
				+ "             , g.goods_price goodsPrice\r\n"
				+ "             , gi.filename filename\r\n"
				+ "       FROM\r\n"
				+ "       goods g LEFT JOIN (SELECT goods_no, SUM(order_quantity) sumNum\r\n"
				+ "                      FROM orders\r\n"
				+ "                      GROUP BY goods_no) t\r\n"
				+ "                      ON g.goods_no = t.goods_no\r\n"
				+ "                         INNER JOIN goods_img gi\r\n"
				+ "                         ON g.goods_no = gi.goods_no\r\n"
				+ "       ORDER BY IFNULL(t.sumNUm, 0) DESC";
		
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			map = new HashMap<String,Object>();
			map.put("goodsNo", rs.getInt("goods_no"));
			map.put("goodsName", rs.getString("goods_name"));
			map.put("goodsPrice", rs.getString("goods_price"));
			map.put("fileName", rs.getString("filename"));
			
			list.add(map);
			
			System.out.println("list >> "+ list);
		}
		
		if(rs!=null) {
			rs.close();
		}
		
		if(stmt!=null) {
			stmt.close();
		}
		
		return list;
		
	}
	
	// Index.jsp 페이징
	public int CustomerGoodsListLastPage (Connection conn, int rowPerPage) throws SQLException {
		
		String sql = "SELECT COUNT(*) FROM goods";
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
		
	}	// end IndexLastPage
	
	
	// 상품 수정(updateGoodsAction.jsp)
	public int updateGoods(Connection conn, Goods goods) throws SQLException {
		int row = 0;
		String sql = "UPDATE goods SET goods_name=? ,goods_price=?, update_date=NOW(), sold_out=? WHERE goods_no=?";
		PreparedStatement stmt = null;
		
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, goods.getGoodsName());
		stmt.setInt(2, goods.getGoodsPrice());
		stmt.setString(3, goods.getSoldOut());
		stmt.setInt(4, goods.getGoodsNo());
		
		row = stmt.executeUpdate();

		// 디버깅
		System.out.println("row >> " + row);

		if(stmt!=null) {
			stmt.close();
		}
		
		// 디버깅
		System.out.println("row : " + row);
		
		return row;
		
	}	// end updateGoods
	
	
	
	// 반환값 : key값 (jdbc api)
	public int insertGoods(Connection conn, Goods goods) throws SQLException {
		
		int keyId = 0;
		String sql = "INSERT INTO goods (goods_no, goods_name,goods_price, update_date, create_date,sold_out) VALUES (?,?,?,NOW(),NOW(),'Y')";									
		PreparedStatement stmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);	// key 값을 리턴하게 만듦
		// 1) insert 											// 1이 들어가면 실행, 0이면 실행 안되고 앞의 쿼리만 실행됨
		// 2) select	=> last_ai_key 세팅		1로 호출			INSERT쿼리 실행 후 자동 증가 키값 받아오기  JDBC API 
		
		stmt.setInt(1, goods.getGoodsNo());
		stmt.setString(2, goods.getGoodsName());
		stmt.setInt(3, goods.getGoodsPrice());
		stmt.executeUpdate();					// insert 성공한 row 의 수
		
		ResultSet rs = stmt.getGeneratedKeys();	// select last_key	
		
		if(rs.next()) {
			keyId = rs.getInt(1);				// 1로 호출
		}
		
		if(rs!=null) {
			rs.close();
		}
		
		if(stmt!=null) {
			stmt.close();
		}
		
		return keyId;
	}
	
	
	
	public Map<String,Object> selectGoodsAndImgOne(Connection conn, int goodsNo) throws SQLException {

		Map<String,Object> map = new HashMap<String,Object>();
		// SELECT g.*, gi.* FROM goods g INNER JOIN goods_img gi 
		// ON g.goods_no = gi.goods_no WHERE g.goods_no = 1

		String sql = "SELECT g.goods_no,g.goods_name,g.goods_price, g.update_date, g.create_date,"
				+ "g.sold_out, gi.goods_no,gi.filename, gi.origin_filename,gi.content_type,gi.create_date FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE g.goods_no = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		rs = stmt.executeQuery();

		if(rs.next()){
			map.put("goodsNo", rs.getInt("g.goods_no"));
			map.put("goodsName",rs.getString("g.goods_name"));
			map.put("goodsPrice", rs.getInt("g.goods_price"));
			map.put("updateDate",rs.getString("g.update_date") );
		    map.put("createDate", rs.getString("g.create_date"));
		    map.put("soldOut",rs.getString("g.sold_out") );
		    map.put("fileName",rs.getString("gi.filename") );
		    map.put("originFilename", rs.getString("gi.origin_filename"));
		    map.put("contentType",rs.getString("gi.content_type") );
		    map.put("createDate",rs.getString("gi.create_date") );


		// 쿼리에서 where 조건이 없다면 반환 타입 List<Map<String,Object>> list
		}
		// 디버깅
		System.out.println("map >> " + map);

		if(rs!=null) {
			rs.close();
		}
		if(stmt!=null) {
			stmt.close();
		}

		return map;

	}	// end selectGoodsAndImgOne
	
	// 상품 리스트
	public List<Goods> selectGoodsListByPage(Connection conn, int rowPerPage, int beginRow) throws SQLException{
		
		List<Goods> goodsList = new ArrayList<Goods>();
		// SELECT goods_no goodsNo FROM goods ORDER BY goods_no DESC LIMIT ?,?
		
		String sql = "SELECT goods_no,goods_name,goods_price, DATE_FORMAT(update_date,'%Y-%m-%d %T') update_date, DATE_FORMAT(create_date,'%Y-%m-%d %T') create_date,"
				+ "sold_out FROM goods ORDER BY goods_no asc LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Goods goods = new Goods();
			goods.setGoodsNo(rs.getInt("goods_no"));
			goods.setGoodsName(rs.getString("goods_name"));
			goods.setGoodsPrice(rs.getInt("goods_price"));
			goods.setUpdateDate(rs.getString("update_date"));
			goods.setCreateDate(rs.getString("create_date"));
			goods.setSoldOut(rs.getString("sold_out"));
		
			goodsList.add(goods);
		}
		
		if(rs!=null) {
			rs.close();
		}
		if(stmt!=null) {
			stmt.close();
		}
		
		return goodsList;
	}	// end selectGoodsListByPage
	
	// 상품리스트 페이징
	public int goodsLastPage(Connection conn, int rowPerPage) throws SQLException {
		
		String sql = "SELECT COUNT(*) FROM goods";
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
	
	// 상품 삭제
	public int deleteGoods(Connection conn, Goods goods) throws SQLException {
		
		String sql="DELETE FROM goods WHERE goods_no=?";
		PreparedStatement stmt = null;
		int deleteGoods = 0;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goods.getGoodsNo());
			
			deleteGoods = stmt.executeUpdate();
			
			// 디버깅
			System.out.println("deleteGoods : " + deleteGoods);
			
		} finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
			return deleteGoods;
		}
}
