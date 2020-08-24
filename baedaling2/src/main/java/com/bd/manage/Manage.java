package com.bd.manage;

public class Manage {
	private int userIdx; // 회원번호
	private String userName; // 회원이름
	private String userId; // 회원아이디
	private String created_date;// 가입날짜
	private String birth; // 생년월일
	private String tel; // 전화번호
	private String email; // 이메일
	private String addr1; // 주소1
	private String addr2; // 주소2
	private int listNum; // 글번호
	
	private int stateCode; 
	private int enabled; 
	
	
	//주문리스트 
	private int foodOrderNum;
	private int foodOrderTotalPrice ; 
	private String foodOrderAddr;
	private String foodOrderDeliveryMethod;
	private String foodOrderHowPay;
	private String foodOrderPayCompletionDate;
	private String foodOrderCompletionDate;
	private String name;
	private String menuName;

	
	public int getFoodOrderTotalPrice() {
		return foodOrderTotalPrice;
	}
	public void setFoodOrderTotalPrice(int foodOrderTotalPrice) {
		this.foodOrderTotalPrice = foodOrderTotalPrice;
	}
	public int getFoodOrderNum() {
		return foodOrderNum;
	}
	public void setFoodOrderNum(int foodOrderNum) {
		this.foodOrderNum = foodOrderNum;
	}

	public String getFoodOrderAddr() {
		return foodOrderAddr;
	}
	public void setFoodOrderAddr(String foodOrderAddr) {
		this.foodOrderAddr = foodOrderAddr;
	}
	public String getFoodOrderDeliveryMethod() {
		return foodOrderDeliveryMethod;
	}
	public void setFoodOrderDeliveryMethod(String foodOrderDeliveryMethod) {
		this.foodOrderDeliveryMethod = foodOrderDeliveryMethod;
	}
	public String getFoodOrderHowPay() {
		return foodOrderHowPay;
	}
	public void setFoodOrderHowPay(String foodOrderHowPay) {
		this.foodOrderHowPay = foodOrderHowPay;
	}
	public String getFoodOrderPayCompletionDate() {
		return foodOrderPayCompletionDate;
	}
	public void setFoodOrderPayCompletionDate(String foodOrderPayCompletionDate) {
		this.foodOrderPayCompletionDate = foodOrderPayCompletionDate;
	}
	public String getFoodOrderCompletionDate() {
		return foodOrderCompletionDate;
	}
	public void setFoodOrderCompletionDate(String foodOrderCompletionDate) {
		this.foodOrderCompletionDate = foodOrderCompletionDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
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
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCreated_date() {
		return created_date;
	}
	public void setCreated_date(String created_date) {
		this.created_date = created_date;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	
	
	
}
