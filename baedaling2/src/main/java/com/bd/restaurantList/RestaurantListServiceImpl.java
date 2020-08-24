package com.bd.restaurantList;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bd.common.dao.CommonDAO;

@Service("restaurantList.restaurantListService")
public class RestaurantListServiceImpl implements RestaurantListService {
	
	@Autowired
	private CommonDAO dao;

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("rsl.dataCount", map);
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return result;
		
	}

	@Override
	public List<RestaurantList> listRestaurant(Map<String, Object> map) {
		List<RestaurantList> list = null;
		try {
			list=dao.selectList("rsl.listRestaurant", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void insertUserState(RestaurantList dto) throws Exception {
		try {
			dao.updateData("rsl.insertUserState", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public RestaurantList readUser(String restaurantsNum) {
		RestaurantList dto = null;
		
		try {
			dto = dao.selectOne("rsl.readUser", restaurantsNum);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateUserEnabled(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("rsl.updateUserEnabled", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<RestaurantList> listWaitRestaurant(Map<String, Object> map) {
		List<RestaurantList> list = null;
		try {
			list = dao.selectList("rsl.listWaitRestaurant",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int waitDataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("rsl.watiDataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void updateReady(int restaurantsNum) throws Exception {
		dao.updateData("rsl.updateReady",restaurantsNum);
		
	}
}
