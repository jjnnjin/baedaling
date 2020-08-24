package com.bd.review;

public class Review {
	private int foodOrderNum;
	private int userIdx;
	private String content;
	private String created;
	private int starCount;
	private int reviewNum;
	private int restaurantsNum;
	private int savefilename;
	
	private int num;
	private int listNum;
	private String userName;
	private String subject;
	private String hitCount;
	private int replyCount;
	
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getHitCount() {
		return hitCount;
	}
	public void setHitCount(String hitCount) {
		this.hitCount = hitCount;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getSavefilename() {
		return savefilename;
	}
	public void setSavefilename(int savefilename) {
		this.savefilename = savefilename;
	}
	public int getFoodOrderNum() {
		return foodOrderNum;
	}
	public void setFoodOrderNum(int foodOrderNum) {
		this.foodOrderNum = foodOrderNum;
	}
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public int getStarCount() {
		return starCount;
	}
	public void setStarCount(int starCount) {
		this.starCount = starCount;
	}
	public int getReviewNum() {
		return reviewNum;
	}
	public void setReviewNum(int reviewNum) {
		this.reviewNum = reviewNum;
	}
	public int getRestaurantsNum() {
		return restaurantsNum;
	}
	public void setRestaurantsNum(int restaurantsNum) {
		this.restaurantsNum = restaurantsNum;
	}
}
