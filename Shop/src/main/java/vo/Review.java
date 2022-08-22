package vo;

public class Review {
	private int reviewNo;
	private int goodsNo;
	private String customerId;
	private String reviewContent;
	private String updateDate;
	private String createDate;
	
	
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public int getGoodsNo() {
		return goodsNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public Review(int reviewNo, int goodsNo, String customerId, String reviewContent, String updateDate,
			String createDate) {
		super();
		this.reviewNo = reviewNo;
		this.goodsNo = goodsNo;
		this.customerId = customerId;
		this.reviewContent = reviewContent;
		this.updateDate = updateDate;
		this.createDate = createDate;
	}
	
	public Review() {
		super();

	}
	@Override
	public String toString() {
		return "Review [reviewNo=" + reviewNo + ", goodsNo=" + goodsNo + ", customerId=" + customerId
				+ ", reviewContent=" + reviewContent + ", updateDate=" + updateDate + ", createDate=" + createDate
				+ "]";
	}
	
	
	
}
