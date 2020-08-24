package com.bd.user;

public class User {
	private int userIdx;
	private String userId;
	private String userPwd;
	private String userName;
	private String enabled;
	private String created_date;
	private int separate;
	private String birth;
	private String email;
	private String tel;
	private String zip;
	private String addr1;
	private String addr2;
	private String longitude;
	private String latitude;
	private String year;
	private String month;
	private String date;
	
	private String fcName;
	private String mutualName;
	private String licenseNumber;
	private String fczip;
	private String fcaddr1;
	private String fcaddr2;
	private String fctel;
	private int restaurantsNum;
	private int typecategoryNum; //1.브런치 2.한식 3.분식 4.야식 5.일식 6.중식 7 치킨 8패스트푸드 9 디저트 10 피자 11양식 
	
	public int getTypecategoryNum() {
		return typecategoryNum;
	}
	public void setTypecategoryNum(int typecategoryNum) {
		this.typecategoryNum = typecategoryNum;
	}
	public String getFcName() {
		return fcName;
	}
	public void setFcName(String fcName) {
		this.fcName = fcName;
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
	public String getFczip() {
		return fczip;
	}
	public void setFczip(String fczip) {
		this.fczip = fczip;
	}
	public String getFcaddr1() {
		return fcaddr1;
	}
	public void setFcaddr1(String fcaddr1) {
		this.fcaddr1 = fcaddr1;
	}
	public String getFcaddr2() {
		return fcaddr2;
	}
	public void setFcaddr2(String fcaddr2) {
		this.fcaddr2 = fcaddr2;
	}
	public String getFctel() {
		return fctel;
	}
	public void setFctel(String fctel) {
		this.fctel = fctel;
	}
	public int getRestaurantsNum() {
		return restaurantsNum;
	}
	public void setRestaurantsNum(int restaurantsNum) {
		this.restaurantsNum = restaurantsNum;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getEnabled() {
		return enabled;
	}
	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getCreated_date() {
		return created_date;
	}
	public void setCreated_date(String created_date) {
		this.created_date = created_date;
	}
	public int getSeparate() {
		return separate;
	}
	public void setSeparate(int separate) {
		this.separate = separate;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	
}
