package com.rent.vaca.user;

public class UserTermsVO {

	private int userId;
	private int termId;
	private int agreed;
	
	private String agreedAt;
	private String createAt;
	
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getTermId() {
		return termId;
	}
	public void setTermId(int termId) {
		this.termId = termId;
	}
	public int getAgreed() {
		return agreed;
	}
	public void setAgreed(int agreed) {
		this.agreed = agreed;
	}
	public String getAgreedAt() {
		return agreedAt;
	}
	public void setAgreedAt(String agreedAt) {
		this.agreedAt = agreedAt;
	}
	public String getCreateAt() {
		return createAt;
	}
	public void setCreateAt(String createAt) {
		this.createAt = createAt;
	}
	
}
