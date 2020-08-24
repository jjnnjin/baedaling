package com.bd.mypage;

import java.util.List;
import java.util.Map;

public interface MypageService {
	public Mypage readMypage (int userIdx);
	
	public void updateUser(Mypage dto) throws Exception;
	public void deleteUser(Map<String, Object> map) throws Exception;
	
	public List<Mypage> orderlist(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	
	public int checkReview(Map<String, Object>map);
	
	public List<Mypage> freelist(Map<String, Object> map);
	public int freeCount(Map<String, Object> map);
	
	public List<Mypage> recommendlist(Map<String, Object> map);
	public int recommendCount(Map<String, Object> map);
	
	public List<Mypage> reviewlist(Map<String, Object> map);
	public int reviewCount(Map<String, Object> map);
	
	public void deleteReview(Map<String, Object> map) throws Exception;
	
	public List<Mypage> inquirelist(Map<String, Object> map);
	public int inquireCount(Map<String, Object> map);

	public Mypage orderDetail(Map<String, Object> map);
	public List<Mypage> orderDetailMenu(Map<String,Object> map);
	
}