package com.bd.inquire;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bd.common.dao.CommonDAO;

@Service("inquire.inquireService")
public class InquireServiceImpl implements InquireService {
	
	@Autowired
	private CommonDAO dao;
	
	// 게시물 등록하는 메서드
	@Override
	public void insertInquire(Inquire dto) throws Exception {
		try {
			dao.insertData("inquire.insertInquire", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	// 게시물 리스트 보여지는 메서드
	@Override
	public List<Inquire> listInquire(Map<String, Object> map) {
		List<Inquire> list = null;
		
		try {
			list=dao.selectList("inquire.listInquire", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 게시물 갯수 나타내는 메서드
	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("inquire.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 게시물을 보여주는 메서드
	@Override
	public Inquire readInquire(int num) {
		Inquire dto = null;
		
		// 게시물 가져오기 
		try {
			dto=dao.selectOne("inquire.readInquire", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	// 이전글 메서드
	@Override
	public Inquire preReadInquire(Map<String, Object> map) {
		Inquire dto=null;
		
		try {
			dto=dao.selectOne("inquire.preReadInquire", map);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return dto;
	}
	
	// 다음글 메서드
	@Override
	public Inquire nextReadInquire(Map<String, Object> map) {
		Inquire dto = null;
		
		try {
			dto=dao.selectOne("inquire.nextReadInquire", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	// 글수정 메서드
	@Override
	public void updateInquire(Inquire dto) throws Exception {
		dao.updateData("inquire.updateInquire", dto);
	}
	
	// admin이 답변 메서드
	@Override
	public void updateInquireAdmin(Inquire dto) throws Exception {
		try {
			dao.insertData("inquire.updateInquireAdmin", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	// 글삭제 메서드
	@Override
	public void deleteInquire(int num, String userId) throws Exception {
		try {
			Inquire dto = readInquire(num);
			if(dto==null || (! userId.equals("admin") && !userId.equals(dto.getUserId()))) {
				return;
			}
			dao.deleteData("inquire.deleteInquire", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
