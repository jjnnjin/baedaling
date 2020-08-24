package com.bd.manage;

import java.util.List;
import java.util.Map;

public interface ManageService {
	public int dataCount(Map<String, Object> map); 
	public List<Manage> listManage(Map<String, Object> map); // 회원목록
	// public void userBlock(Map<String, Object> map) throws Exception; // 차단&해제
	// public int block(int userIdx);
	
	public Manage readUser(String userId); // 회원정보 상세표
	public void updateUserEnabled(Map<String, Object> map) throws Exception; // alter창 회원상태변경
	public void insertUserState(Manage dto) throws Exception; // 변경된 회원상태 저장 
	
	public List<Manage> allOrderList(Map<String, Object> map); 	//주문리스트
}
