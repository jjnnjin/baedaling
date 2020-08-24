package com.bd.rerestaurants;

public class Restaurants {
	private int restaurantsNum; // 레스토랑 번호
	private String name; // 이름
	private String addr1; // 주소
	private String openinghour; // 오픈시간
	private String endinghour; // 
	private String fctel; // 
	private int minorder; //
	private String savefilename; // 
	private double distance; // 거리
	private double starcount;
	private int reviewcount; // 리뷰 갯수
	
	public int getReviewcount() {
		return reviewcount;
	}
	public void setReviewcount(int reviewcount) {
		this.reviewcount = reviewcount;
	}
	public double getStarcount() {
		return starcount;
	}
	public void setStarcount(double starcount) {
		this.starcount = starcount;
	}
	public int getRestaurantsNum() {
		return restaurantsNum;
	}
	public void setRestaurantsNum(int restaurantsNum) {
		this.restaurantsNum = restaurantsNum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getOpeninghour() {
		return openinghour;
	}
	public void setOpeninghour(String openinghour) {
		this.openinghour = openinghour;
	}
	public String getEndinghour() {
		return endinghour;
	}
	public void setEndinghour(String endinghour) {
		this.endinghour = endinghour;
	}
	public String getFctel() {
		return fctel;
	}
	public void setFctel(String fctel) {
		this.fctel = fctel;
	}
	public int getMinorder() {
		return minorder;
	}
	public void setMinorder(int minorder) {
		this.minorder = minorder;
	}
	public String getSavefilename() {
		return savefilename;
	}
	public void setSavefilename(String savefilename) {
		this.savefilename = savefilename;
	}
	public double getDistance() {
		return distance;
	}
	public void setDistance(double distance) {
		this.distance = distance;
	}
	
	
}
