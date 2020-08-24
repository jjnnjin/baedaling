package com.bd.mypage;

public class Mypage {
	private int userIdx;
	private String userId;
	private String userPwd;
	private String userName;
	
	private String birth;
	private String year;
	private String month;
	private String date;

	private String tel;
	private String email;

	private int zip;
	private String addr1;
	private String addr2;
	private String created_date;
	
	private String longitude;
	private String latitude;
	
	// 주문 내역
	private int listNum;
	private String name; // 가게이름
	private String menuName; // 메뉴이름
	private int qty; // 수량
	private int oneMenuTotalPrice;
	private int foodOrderTotalPrice; // 총 결제금액
	private String foodOrderState; // 주문상태
	private String foodOrderDate; // 주문날짜와 시간
	private String foodOrderAddr; // 가게주소
	private int orderOnePrice;
	private String memo;
	private String fctel;
	private String foodOrderHowPay;
	private int restaurantsNum;
	private int foodOrderNum;

	// 내가 쓴 추천/자유게시판
	private int num;
	private String subject;
	private String created;
	private int hitCount;
	private int replyCount;
	private int fileCount;
	
	// 내가 쓴 리뷰
	private String content;
	private String reply;
	private String replycreated;
	private int reviewNum;
	private int starCount;
	
	// 내 문의
	private String answer;
	
	

	
	public int getOrderOnePrice() {
		return orderOnePrice;
	}
	public void setOrderOnePrice(int orderOnePrice) {
		this.orderOnePrice = orderOnePrice;
	}
	public int getOneMenuTotalPrice() {
		return oneMenuTotalPrice;
	}
	public void setOneMenuTotalPrice(int oneMenuTotalPrice) {
		this.oneMenuTotalPrice = oneMenuTotalPrice;
	}
	public String getFoodOrderHowPay() {
		return foodOrderHowPay;
	}
	public void setFoodOrderHowPay(String foodOrderHowPay) {
		this.foodOrderHowPay = foodOrderHowPay;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getFoodOrderAddr() {
		return foodOrderAddr;
	}
	public void setFoodOrderAddr(String foodOrderAddr) {
		this.foodOrderAddr = foodOrderAddr;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getFctel() {
		return fctel;
	}
	public void setFctel(String fctel) {
		this.fctel = fctel;
	}
	public String getFoodOrderState() {
		return foodOrderState;
	}
	public void setFoodOrderState(String foodOrderState) {
		this.foodOrderState = foodOrderState;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public String getReplycreated() {
		return replycreated;
	}
	public void setReplycreated(String replycreated) {
		this.replycreated = replycreated;
	}
	public int getReviewNum() {
		return reviewNum;
	}
	public void setReviewNum(int reviewNum) {
		this.reviewNum = reviewNum;
	}
	public int getStarCount() {
		return starCount;
	}
	public void setStarCount(int starCount) {
		this.starCount = starCount;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public int getFileCount() {
		return fileCount;
	}
	public void setFileCount(int fileCount) {
		this.fileCount = fileCount;
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
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
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
	public int getZip() {
		return zip;
	}
	public void setZip(int zip) {
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
	public String getCreated_date() {
		return created_date;
	}
	public void setCreated_date(String created_date) {
		this.created_date = created_date;
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
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public int getFoodOrderTotalPrice() {
		return foodOrderTotalPrice;
	}
	public void setFoodOrderTotalPrice(int foodOrderTotalPrice) {
		this.foodOrderTotalPrice = foodOrderTotalPrice;
	}
	public String getFoodOrderDate() {
		return foodOrderDate;
	}
	public void setFoodOrderDate(String foodOrderDate) {
		this.foodOrderDate = foodOrderDate;
	}
	public int getRestaurantsNum() {
		return restaurantsNum;
	}
	public void setRestaurantsNum(int restaurantsNum) {
		this.restaurantsNum = restaurantsNum;
	}
	public int getFoodOrderNum() {
		return foodOrderNum;
	}
	public void setFoodOrderNum(int foodOrderNum) {
		this.foodOrderNum = foodOrderNum;
	}
}