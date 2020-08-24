package com.bd.franchise;

public class FranchiseReview {
	private int reviewNum;
	private String content;
	private String created;
	private int starCount;
	private String menuName;
	private double aveStarCount;
	private String reply;
	private String replyCreated;
	private String userName;
	
	
	
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getReviewNum() {
		return reviewNum;
	}
	public void setReviewNum(int reviewNum) {
		this.reviewNum = reviewNum;
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
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public double getAveStarCount() {
		return aveStarCount;
	}
	public void setAveStarCount(double aveStarCount) {
		this.aveStarCount = aveStarCount;
	}
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public String getReplyCreated() {
		return replyCreated;
	}
	public void setReplyCreated(String replyCreated) {
		this.replyCreated = replyCreated;
	}
}
