package com.rent.vaca.user;

public class BizTermsVO {
	
	private int bizId;
	private int termId;
	private int agreed;
	
	private String agreedAt;
	private String createAt;
	
	public int getBizId() {
		return bizId;
	}
	public void setBizId(int bizId) {
		this.bizId = bizId;
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
	public String getUpdateAt() {
		return updateAt;
	}
	public void setUpdateAt(String updateAt) {
		this.updateAt = updateAt;
	}
	private String updateAt;
}
