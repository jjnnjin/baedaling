package com.bd.inquire;

public class Inquire {
	private int num; // 게시물 번호
	private String userId; // 질문자 아이디
	private String userName; // 질문자 이름
	private String email; // 질문자 이메일
	private String category; // 카테고리
	private String subject; // 제목
	private String question; // 질문
	private String created; // 질문일자
	private String answerId; // 답변아이디
	private String answerName;
	private String answer; // 답변
	private String answer_created; // 답변일자
	private int listNum; // 굴 갯수
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public String getAnswerId() {
		return answerId;
	}
	public void setAnswerId(String answerId) {
		this.answerId = answerId;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getAnswer_created() {
		return answer_created;
	}
	public void setAnswer_created(String answer_created) {
		this.answer_created = answer_created;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public String getAnswerName() {
		return answerName;
	}
	public void setAnswerName(String answerName) {
		this.answerName = answerName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}


}

/*
 * CREATE TABLE inquire (
    num           NUMBER PRIMARY KEY
    ,type         NUMBER(1) DEFAULT 0
    ,parent       NUMBER DEFAULT 0
    ,state        NUMBER(1) DEFAULT 0
    ,userId       VARCHAR2(50) NOT NULL
    ,userIdx      NUMBER NOT NULL
    ,email        VARCHAR2(50)
    ,category    VARCHAR2(50) NOT NULL
    ,subject     VARCHAR2(255) NOT NULL
    ,content     CLOB NOT NULL
    ,created     DATE DEFAULT SYSDATE
    ,CONSTRAINT fk_inquire_userIdx FOREIGN KEY(userIdx)
                REFERENCES user1(userIdx)
);

 */
