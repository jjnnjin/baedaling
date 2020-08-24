package com.bd.faq;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bd.common.dao.CommonDAO;

@Service("faq.boardService")
public class BoardServiceImpl implements BoardService{

	@Autowired
	private CommonDAO dao;
	
	
	
	@Override
	public void insertBoard(Board dto) throws Exception {
		try {
			
			dao.insertData("faq.insertBoard",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Board> listBoard(Map<String, Object> map) {
		List<Board> list = null;
		
		try {
			list = dao.selectList("faq.listBoard",map);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("faq.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Board readBoard(int num) {
		Board dto = null;
		try {
			dto = dao.selectOne("faq.readFaq",num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateBoard(Board dto) throws Exception {
		try {
			dao.updateData("faq.updateBoard",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void deleteBoard(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("faq.deleteBoard",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void insertCategory(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateCategory(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Board> listCategory() {
		List<Board> list = null;
		try {
			list = dao.selectList("faq.listCategory");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public void deleteCategory(int categoryNum) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
