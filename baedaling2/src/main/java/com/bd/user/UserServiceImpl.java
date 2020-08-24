package com.bd.user;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bd.common.dao.CommonDAO;

@Service("user.userService")
public class UserServiceImpl implements UserService{
	@Autowired
	private CommonDAO dao;
	
	@Override
	public User loginUser(String userId) {
		User dto=null;
		
		try {
			dto=dao.selectOne("user.loginUser", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void insertUser(User dto) throws Exception {
		try {
			if(dto.getYear()!=null&&dto.getMonth()!=null&&dto.getDate()!=null) {
				dto.setBirth(dto.getYear()+""+dto.getMonth()+""+dto.getDate());
			}
			int idx = dao.selectOne("user.selectidx");
			dto.setUserIdx(idx);
			dto.setSeparate(0);
			dao.insertData("user.insertuser0", idx);
			dao.insertData("user.insertuser1", dto);
			dao.insertData("user.insertuser2", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertfcUser(User dto) throws Exception {
		try {
			if(dto.getYear()!=null&&dto.getMonth()!=null&&dto.getDate()!=null) {
				dto.setBirth(dto.getYear()+""+dto.getMonth()+""+dto.getDate());
			}
			int idx = dao.selectOne("user.selectidx");
			int fcnum = dao.selectOne("user.selectfcnum");
			dto.setUserIdx(idx);
			dto.setRestaurantsNum(fcnum);
			dto.setSeparate(1);
			dao.insertData("user.insertuser0", idx);
			dao.insertData("user.insertuser1", dto);
			dao.insertData("user.insertuser2", dto);
			
			dao.insertData("user.insertRestaurants", dto);
			dao.insertData("user.insertRestaurantsInfo", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	
	@Override
	public void updateMembership(Map<String, Object> map) throws Exception {
		
	}

	@Override
	public void updateLastLogin(String userId) throws Exception {
		
	}

	@Override
	public void updateUser(User dto) throws Exception {

	}

	@Override
	public User readUser(String userId) {
		User dto = null;
		try {
			dto = dao.selectOne("user.readUserId", userId);
			} catch (Exception e) {
				e.printStackTrace();
		}
		return dto;
	}

	@Override
	public User readUser(long userIdx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteUser(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<User> listUser(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void generatePwd(User dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int readRestaurantsNum(int userIdx) {
		int result = 0;
		try {
			result = dao.selectOne("user.readRestaurantsNum",userIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


}
