package com.bd.rerestaurants;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bd.common.dao.CommonDAO;

@Service("restaurants.restaurantsService")
public class RestaurantsServiceImpl implements RestaurantsService {
	@Autowired
	private CommonDAO dao;
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Restaurants> listRestaurants(Map<String, Object> map) throws Exception {
		List<Restaurants> list = null;
		try {
			dao.callSelectListProcedureMap("resto.listRestaurants", map);
			list = (List<Restaurants>)map.get("result");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			dao.callSelectOneProcedureMap("resto.countRestaurants", map);
			result = (Integer)map.get("result");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Restaurants> listAllRestaurants(Map<String, Object> map) throws Exception {
		List<Restaurants> list = null;
		try {
			dao.callSelectListProcedureMap("resto.listAllRestaurants", map);
			list = (List<Restaurants>)map.get("result");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}

	@Override
	public int dataAllCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			dao.callSelectOneProcedureMap("resto.countAllRestaurants", map);
			result = (Integer)map.get("result");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Restaurants> listStarRestaurants(Map<String, Object> map) throws Exception {
		List<Restaurants> list = null;
		try {
			dao.callSelectListProcedureMap("resto.listStarRestaurants", map);
			list = (List<Restaurants>)map.get("result");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Restaurants> listAllStarRestaurants(Map<String, Object> map) throws Exception {
		List<Restaurants> list = null;
		try {
			dao.callSelectListProcedureMap("resto.listAllStarRestaurants", map);
			list = (List<Restaurants>)map.get("result");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Restaurants> listReviewRestaurants(Map<String, Object> map) throws Exception {
		List<Restaurants> list = null;
		try {
			dao.callSelectListProcedureMap("resto.listReviewRestaurants", map);
			list = (List<Restaurants>)map.get("result");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Restaurants> listAllReviewRestaurants(Map<String, Object> map) throws Exception {
		List<Restaurants> list = null;
		try {
			dao.callSelectListProcedureMap("resto.listAllReviewRestaurants", map);
			list = (List<Restaurants>)map.get("result");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}

}
