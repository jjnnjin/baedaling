package com.bd.foodorder;

import java.util.List;
import java.util.Map;

public interface FoodOrderService {
	
	//주문관리
	public List<FoodOrder> readOrder(Map<String, Object> map);
	public int orderCount(Map<String, Object> map);
	public int allorderCount(Map<String, Object> map);
	public int todayOrderCount(Map<String, Object> map);
	public void updateOrderState(Map<String, Object> map) throws Exception;
	public void updateCompleteDate(int foodorderNum) throws Exception;
	public void deleteOrder(int foodorderNum) throws Exception;
	
	
	public List<FoodOrder> allList(Map<String, Object> map);
	
	//매출
	public FoodOrder todaySalesRead(int restaurantsNum);
	public FoodOrder monthlySalesRead(int restaurantsNum);
	public FoodOrder annualSalesRead(int restaurantsNum);
	
	//차트
	public List<FoodOrder> bestMenuChart(int restaurantsNum);
	public List<FoodOrder> todayBestMenu(int restaurantsNum);
	public Map<String, Object> montlyChart(int restaurantsNum);
	public Map<String, Object> reviewChart(int restaurantsNum);
	
	//가맹점정보
	public FoodOrder readInfo(int restaurantsNum);
	public List<FoodOrder> listFile(int restaurantsNum);
	public void updateInfo(FoodOrder dto, String pathname);
	public void updateFcState(FoodOrder dto) throws Exception;
	public void insertFile(FoodOrder dto) throws Exception;
	public FoodOrder readFile(int fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
	
	//리뷰
	public List<FoodOrder> reviewList(Map<String, Object> map);
	public int reviewCount(Map<String, Object> map);
	public FoodOrder reviewRead(int reviewNum);
	
	public List<FoodOrder> replyList(Map<String, Object> map);
	public List<FoodOrder> reply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void insertReply(FoodOrder dto)throws Exception;
	
	// 가맹점 수정위한 가맹점정보
	public FoodOrder readRestaurant(int restaurantsNum);
	public void updateRestaurant(FoodOrder dto);
	
	
}

