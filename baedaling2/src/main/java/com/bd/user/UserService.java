package com.bd.user;

import java.util.List;
import java.util.Map;

import com.bd.user.User;

public interface UserService {
	public User loginUser(String userId);
	
	public void insertUser(User dto) throws Exception;
	public void insertfcUser(User dto) throws Exception;
	
	
	public void updateMembership(Map<String, Object> map) throws Exception;
	public void updateLastLogin(String userId) throws Exception;
	public void updateUser(User dto) throws Exception;
	
	public User readUser(String userId);
	public User readUser(long userIdx);
	
	public void deleteUser(Map<String, Object> map) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<User> listUser(Map<String, Object> map);
	
	public void generatePwd(User dto) throws Exception;
	public int readRestaurantsNum(int userIdx);
}
