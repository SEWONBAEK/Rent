package com.rent.vaca.user;

public class InterestAccoVO {
	private int interestNo;
	private int userId;
	private int accoNo;
	
	private String name;
	private String addr;
	private String imageUrl;
	
	public int getInterestNo() {
		return interestNo;
	}
	public void setInterestNo(int interestNo) {
		this.interestNo = interestNo;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getAccoNo() {
		return accoNo;
	}
	public void setAccoNo(int accoNo) {
		this.accoNo = accoNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
}
