package com.bd.franchise;

import java.util.List;

public class Franchise {
	private int restaurantsNum;
	private String Longitude;
	private String Latitude;
	private String name;
	private String zip; 
	private String addr1;
	private String addr2;
	private int userIdx;
	private int typecategoryNum;
	
	//info
	private String openingHour;
	private String endingHour;
	private String mutualName;
	private String licenseNumber;
	private String introduce;
	private String origin;
	private String fctel;
	private int minorder;
	private String deliTime;
	
	private List<Integer> quantity;
	private List<Integer> menuNum;
	private List<Integer> eachprice;
	private String tel;
	private String memo;
	private int foodordernum;
	private String foodorderhowpay;
	private String foodorderdeliverymethod;
	private int foodordertotalprice;
	private int foodorderpay;
	private String titleimg;
	private String bannerimg;
	
	
	public String getTitleimg() {
		return titleimg;
	}
	public void setTitleimg(String titleimg) {
		this.titleimg = titleimg;
	}
	public String getBannerimg() {
		return bannerimg;
	}
	public void setBannerimg(String bannerimg) {
		this.bannerimg = bannerimg;
	}
	public String getDeliTime() {
		return deliTime;
	}
	public void setDeliTime(String deliTime) {
		this.deliTime = deliTime;
	}
	public int getFoodordernum() {
		return foodordernum;
	}
	public void setFoodordernum(int foodordernum) {
		this.foodordernum = foodordernum;
	}
	public int getFoodordertotalprice() {
		return foodordertotalprice;
	}
	public void setFoodordertotalprice(int foodordertotalprice) {
		this.foodordertotalprice = foodordertotalprice;
	}
	public int getFoodorderpay() {
		return foodorderpay;
	}
	public void setFoodorderpay(int foodorderpay) {
		this.foodorderpay = foodorderpay;
	}
	public String getFoodorderdeliverymethod() {
		return foodorderdeliverymethod;
	}
	public void setFoodorderdeliverymethod(String foodorderdeliverymethod) {
		this.foodorderdeliverymethod = foodorderdeliverymethod;
	}
	public String getFoodorderhowpay() {
		return foodorderhowpay;
	}
	public void setFoodorderhowpay(String foodorderhowpay) {
		this.foodorderhowpay = foodorderhowpay;
	}
	public List<Integer> getEachprice() {
		return eachprice;
	}
	public void setEachprice(List<Integer> eachprice) {
		this.eachprice = eachprice;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public List<Integer> getQuantity() {
		return quantity;
	}
	public void setQuantity(List<Integer> quantity) {
		this.quantity = quantity;
	}
	public List<Integer> getMenuNum() {
		return menuNum;
	}
	public void setMenuNum(List<Integer> menuNum) {
		this.menuNum = menuNum;
	}
	public int getRestaurantsNum() {
		return restaurantsNum;
	}
	public void setRestaurantsNum(int restaurantsNum) {
		this.restaurantsNum = restaurantsNum;
	}
	public String getLongitude() {
		return Longitude;
	}
	public void setLongitude(String longitude) {
		Longitude = longitude;
	}
	public String getLatitude() {
		return Latitude;
	}
	public void setLatitude(String latitude) {
		Latitude = latitude;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
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
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public int getTypecategoryNum() {
		return typecategoryNum;
	}
	public void setTypecategoryNum(int typecategoryNum) {
		this.typecategoryNum = typecategoryNum;
	}
	public String getOpeningHour() {
		return openingHour;
	}
	public void setOpeningHour(String openingHour) {
		this.openingHour = openingHour;
	}
	public String getEndingHour() {
		return endingHour;
	}
	public void setEndingHour(String endingHour) {
		this.endingHour = endingHour;
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
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public int getMinorder() {
		return minorder;
	}
	public void setMinorder(int minorder) {
		this.minorder = minorder;
	}
	public String getFctel() {
		return fctel;
	}
	public void setFctel(String fctel) {
		this.fctel = fctel;
	}
	
}
