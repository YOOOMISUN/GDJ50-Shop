package vo;

public class GoodsImg {
	private int goodsNo;
	private String fileName;
	private String originFileName;
	private String contentType;
	private String createDate;
	
	
	public int getGoodsNo() {
		return goodsNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getOriginFileName() {
		return originFileName;
	}
	public void setOriginFileName(String originFileName) {
		this.originFileName = originFileName;
	}
	public String getContentType() {
		return contentType;
	}
	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	
	@Override
	public String toString() {
		return "GoodsImg [goodsNo=" + goodsNo + ", fileName=" + fileName + ", originFileName=" + originFileName
				+ ", contentType=" + contentType + ", createDate=" + createDate + "]";
	}
	
}
