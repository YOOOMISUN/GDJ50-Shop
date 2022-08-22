package Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import vo.GoodsImg;

public class GoodsImgDao {
	
	// 상품 삭제
	public int deleteGoodsImg(Connection conn, GoodsImg goodsImg) throws SQLException {
		
		String sql="DELETE FROM goods_img WHERE goods_no=?";
		PreparedStatement stmt = null;
		int deleteGoodsImg = 0;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsImg.getGoodsNo());
			
			deleteGoodsImg = stmt.executeUpdate();
			
			// 디버깅
			System.out.println("deleteGoodsImg : " + deleteGoodsImg);
			
		} finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
			return deleteGoodsImg;
		
	}
	
	// 상품 수정
	public int updateGoodsImg(Connection conn, GoodsImg goodsImg) throws SQLException {
		
		int row = 0;
		String sql = "UPDATE goods_img SET filename=?, origin_filename=?, content_type=?,create_date=NOW() WHERE goods_no=?";
		PreparedStatement stmt = null;
		
		stmt=conn.prepareStatement(sql);
		stmt.setString(1,goodsImg.getFileName());
		stmt.setString(2,goodsImg.getOriginFileName());
		stmt.setString(3,goodsImg.getContentType());
		stmt.setInt(4,goodsImg.getGoodsNo());
		
		// 디버깅
		System.out.println("goodsImg.getFileName() : " + goodsImg.getFileName());
		System.out.println("goodsImg.getOriginFileName() : " + goodsImg.getOriginFileName());
		System.out.println("goodsImg.getContentType() : " + goodsImg.getContentType());
		System.out.println("goodsImg.getGoodsNo() : " + goodsImg.getGoodsNo());
		
		row = stmt.executeUpdate();
		
		// 디버깅
		System.out.println("updateGoodsImg : " + row);
					
		if(stmt!=null) {
			stmt.close();
		}
		
		return row;
		
	}	// end updateGoodsImg
	
	// 반환값 int : key값 (jdbc api)
	public int insertGoodsImg(Connection conn, GoodsImg goodsImg) throws SQLException {
		
		String sql = "INSERT INTO goods_img (goods_no, filename, origin_filename, content_type,create_date) VALUES (?,?,?,?,NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		int row = 0;
		
		stmt.setInt(1, goodsImg.getGoodsNo());
		stmt.setString(2, goodsImg.getFileName());
		stmt.setString(3, goodsImg.getOriginFileName());
		stmt.setString(4, goodsImg.getContentType());
		
		row = stmt.executeUpdate();


		if(stmt!=null) {
			stmt.close();
		}
		
		return row;
		
	}	// end insertGoodsImg
}
