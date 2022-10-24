package vo;

public class Cart {
	private int cartNo;
	private int goodsNo;
	private String goodsName;
	private String customerId;
	private int goodsQuantity;
	private String createDate;
	
	
	public int getCartNo() {
		return cartNo;
	}
	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}
	public int getGoodsNo() {
		return goodsNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public int getGoodsQuantity() {
		return goodsQuantity;
	}
	public void setGoodsQuantity(int goodsQuantity) {
		this.goodsQuantity = goodsQuantity;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	public Cart() {
		super();
		
	}
	public Cart(int cartNo, int goodsNo, String goodsName, String customerId, int goodsQuantity, String createDate) {
		super();
		this.cartNo = cartNo;
		this.goodsNo = goodsNo;
		this.goodsName = goodsName;
		this.customerId = customerId;
		this.goodsQuantity = goodsQuantity;
		this.createDate = createDate;
	}
	
	
	
	
}
