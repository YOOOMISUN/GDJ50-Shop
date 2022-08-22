package vo;

public class Customer {
   private String customerId;
   private String customerPass;
   private String customerName;
   private String customerAddress;
   private String customerDetailAddr;
   private String customerTelephone;
   private String updateDate;
   private String createDate;
   
   
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getCustomerPass() {
		return customerPass;
	}
	public void setCustomerPass(String customerPass) {
		this.customerPass = customerPass;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCustomerAddress() {
		return customerAddress;
	}
	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}
	public String getCustomerDetailAddr() {
		return customerDetailAddr;
	}
	public void setCustomerDetailAddr(String customerDetailAddr) {
		this.customerDetailAddr = customerDetailAddr;
	}
	public String getCustomerTelephone() {
		return customerTelephone;
	}
	public void setCustomerTelephone(String customerTelephone) {
		this.customerTelephone = customerTelephone;
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
	
	
	public Customer(String customerId, String customerPass, String customerName, String customerAddress,
			String customerDetailAddr, String customerTelephone, String updateDate, String createDate) {
		super();
		this.customerId = customerId;
		this.customerPass = customerPass;
		this.customerName = customerName;
		this.customerAddress = customerAddress;
		this.customerDetailAddr = customerDetailAddr;
		this.customerTelephone = customerTelephone;
		this.updateDate = updateDate;
		this.createDate = createDate;
	}
	public Customer() {
		super();

	}
	@Override
	public String toString() {
		return "Customer [customerId=" + customerId + ", customerPass=" + customerPass + ", customerName="
				+ customerName + ", customerAddress=" + customerAddress + ", customerDetailAddr=" + customerDetailAddr
				+ ", customerTelephone=" + customerTelephone + ", updateDate=" + updateDate + ", createDate="
				+ createDate + "]";
	}
   
	
	
   
}