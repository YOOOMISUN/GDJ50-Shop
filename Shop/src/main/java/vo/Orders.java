package vo;

public class Orders {
	private int orderNo;
	private int goodsNo;
	private String customerId;
	private int orderQuantity;
	private int orderPrice;
	private String orderAddr;
	private String orderDetailAddr;
	private String orderState;
	private String payment;
	private String updateDate;
	private String createDate;
	
	
	public Orders() {
		super();

	}
	
	
	public Orders(int orderNo, int goodsNo, String customerId, int orderQuantity, int orderPrice, String orderAddr,
			String orderDetailAddr, String orderState, String payment, String updateDate, String createDate) {
		super();
		this.orderNo = orderNo;
		this.goodsNo = goodsNo;
		this.customerId = customerId;
		this.orderQuantity = orderQuantity;
		this.orderPrice = orderPrice;
		this.orderAddr = orderAddr;
		this.orderDetailAddr = orderDetailAddr;
		this.orderState = orderState;
		this.payment = payment;
		this.updateDate = updateDate;
		this.createDate = createDate;
	}
	
	
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
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
	public int getOrderQuantity() {
		return orderQuantity;
	}
	public void setOrderQuantity(int orderQuantity) {
		this.orderQuantity = orderQuantity;
	}
	public int getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(int orderPrice) {
		this.orderPrice = orderPrice;
	}
	public String getOrderAddr() {
		return orderAddr;
	}
	public void setOrderAddr(String orderAddr) {
		this.orderAddr = orderAddr;
	}
	public String getOrderDetailAddr() {
		return orderDetailAddr;
	}
	public void setOrderDetailAddr(String orderDetailAddr) {
		this.orderDetailAddr = orderDetailAddr;
	}
	public String getOrderState() {
		return orderState;
	}
	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
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
	
	
	
	
	
}
