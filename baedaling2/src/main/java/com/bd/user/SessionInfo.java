package com.bd.user;

// 세션에 저장할 정보(아이디, 이름, 권한등)
public class SessionInfo {
	private int userIdx;
	private String userId;
	private String userName;
	private int separate ;
	private int restaurantsNum;
	private String longitude;
	private String latitude;
	
	
	
	public int getRestaurantsNum() {
		return restaurantsNum;
	}
	public void setRestaurantsNum(int restaurantsNum) {
		this.restaurantsNum = restaurantsNum;
	}
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getSeparate() {
		return separate;
	}
	public void setSeparate(int separate) {
		this.separate = separate;
	}
	
}
