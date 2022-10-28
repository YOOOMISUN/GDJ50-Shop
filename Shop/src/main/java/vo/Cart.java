package vo;

public class Cart {
	private int cartNo;
	private String customerId;
	private int goodsNo;
	private String goodsName;
	private int gooodsPrice;
	private int goodsQuantity;
	private String createDate;
	
	
	
	public int getCartNo() {
		return cartNo;
	}
	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
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
	public int getGooodsPrice() {
		return gooodsPrice;
	}
	public void setGooodsPrice(int gooodsPrice) {
		this.gooodsPrice = gooodsPrice;
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
	
	
	@Override
	public String toString() {
		return "Cart [cartNo=" + cartNo + ", customerId=" + customerId + ", goodsNo=" + goodsNo + ", goodsName="
				+ goodsName + ", gooodsPrice=" + gooodsPrice + ", goodsQuantity=" + goodsQuantity + ", createDate="
				+ createDate + "]";
	}
	
	
	public Cart(int cartNo, String customerId, int goodsNo, String goodsName, int gooodsPrice, int goodsQuantity,
			String createDate) {
		super();
		this.cartNo = cartNo;
		this.customerId = customerId;
		this.goodsNo = goodsNo;
		this.goodsName = goodsName;
		this.gooodsPrice = gooodsPrice;
		this.goodsQuantity = goodsQuantity;
		this.createDate = createDate;
	}
	
	
	public Cart() {
		super();
		
	}
	
	
	
	
	
	
}
