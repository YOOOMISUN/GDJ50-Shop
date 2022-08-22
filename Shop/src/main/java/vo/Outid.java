package vo;

public class Outid {
	// 탈퇴한 아이디랑 날짜 나오게 만드는 것
	private String outId;
	private String outDate;
	
	
	public String getOutId() {
		return outId;
	}
	public void setOutId(String outId) {
		this.outId = outId;
	}
	public String getOutDate() {
		return outDate;
	}
	public void setOutDate(String outDate) {
		this.outDate = outDate;
	}
	
	@Override
	public String toString() {
		return "Outid [outId=" + outId + ", outDate=" + outDate + "]";
	}
	
}
