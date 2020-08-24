package com.bd.rerestaurants;

import java.util.List;
import java.util.Map;

public interface RestaurantsService {
	public List<Restaurants> listRestaurants(Map<String, Object> map) throws Exception;
	public int dataCount(Map<String, Object> map) throws Exception;
	public List<Restaurants> listAllRestaurants(Map<String, Object> map) throws Exception;
	public int dataAllCount(Map<String, Object> map) throws Exception;
	
	public List<Restaurants> listStarRestaurants(Map<String, Object> map) throws Exception;
	public List<Restaurants> listAllStarRestaurants(Map<String, Object> map) throws Exception;
	
	public List<Restaurants> listReviewRestaurants(Map<String, Object> map) throws Exception;
	public List<Restaurants> listAllReviewRestaurants(Map<String, Object> map) throws Exception;
	
}
