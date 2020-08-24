package com.bd.manage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bd.common.dao.CommonDAO;

@Service("manage.manageService")
public class ManageServiceImpl implements ManageService {
	
	@Autowired
	private CommonDAO dao;

	@Override
	// 회원 목록 조회
	public List<Manage> listManage(Map<String, Object> map) {
		List<Manage> list = null;
		
		try {
			list=dao.selectList("manage.listManage", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	// 글 갯수 등
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("manage.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertUserState(Manage dto) throws Exception {
		try {
			dao.updateData("manage.insertUserState", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	@Override
	public Manage readUser(String userId) {
		Manage dto = null;
		
		try {
			dto = dao.selectOne("manage.readUser", userId);
			
			if(dto!=null) {
				if(dto.getEmail()!=null) {
					String [] s=dto.getEmail().split("@");
					dto.setEmail(s[0]);
					dto.setEmail(s[1]);
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateUserEnabled(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("manage.updateUserEnabled", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Manage> allOrderList(Map<String, Object> map) {
		List<Manage> list = null;
		try {
			list = dao.selectList("manage.allOrderList", map);
			
			String result, temp;
			int c;
			for(Manage dto : list) {
				String []ss=dto.getMenuName().split(",");
				if(ss.length==1) {
					continue;
				}
				
				result="";
				c=0;
				temp="";
				for(int i=0; i<ss.length; i++) {
					if(i==0) {
						c=1;
						temp=ss[i];
					} else if(i==ss.length-1) {
						if(temp.equals(ss[i])) {
							c++;
						}
						
						if(c<=1) {
							result+=temp;
						} else {
							result+=temp+"("+c+")";
						}
					} else if(temp.equals(ss[i])) {
						c++;
					} else {
						if(c>1) {
							result+=temp+"("+c+"),";
						} else {
							result+=temp+",";
						}
						c=1;
						temp=ss[i];
					}
				}
				dto.setMenuName(result);
			}
			
			
		} catch (Exception e) {
		}
		return list;
	}
	
	
}
