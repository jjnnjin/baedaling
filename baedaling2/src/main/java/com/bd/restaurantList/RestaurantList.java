package com.bd.restaurantList;

public class RestaurantList {
	private int listNum; // 번호
	private int userIdx; // (user1)
	private String name; // 이름 (restaurants)
	private String userId; // 아이디(user1)
	private String mutualName; // 상호명 (restaurantsInfo)
	private String licenseNumber; // 사업자등록번호(restaurantsInfo)
	private String addr1; // 주소1(restaurants)
	private String addr2; // 주소2(restaurants)
	private int restaurantsNum;
	
	private int stateCode;
	private int enabled;
	private int ready;
	
	
	public int getRestaurantsNum() {
		return restaurantsNum;
	}
	public void setRestaurantsNum(int restaurantsNum) {
		this.restaurantsNum = restaurantsNum;
	}
	public int getReady() {
		return ready;
	}
	public void setReady(int ready) {
		this.ready = ready;
	}
	public int getStateCode() {
		return stateCode;
	}
	public void setStateCode(int stateCode) {
		this.stateCode = stateCode;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getMutualName() {
		return mutualName;
	}
	public void setMutualName(String mutualName) {
		this.mutualName = mutualName;
	}
	public String getLicenseNumber() {
		return licenseNumber;
	}
	public void setLicenseNumber(String licenseNumber) {
		this.licenseNumber = licenseNumber;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

}
