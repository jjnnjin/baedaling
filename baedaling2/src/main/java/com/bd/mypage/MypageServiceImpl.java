package com.bd.mypage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bd.common.dao.CommonDAO;

@Service("mypage.mypageService")
public class MypageServiceImpl implements MypageService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public Mypage readMypage(int userIdx) {
		Mypage dto = null;
		try {			
			dto = dao.selectOne("mypage.readMypage", userIdx);
			
			String y, m, d;
			String birth[] = dto.getBirth().split("-");
			
			y = birth[0];
			m = birth[1];
			d = birth[2];
			
			dto.setYear(y);
			dto.setMonth(m);
			dto.setDate(d);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateUser(Mypage dto) throws Exception {
		try {
			if(dto.getYear()!=null&&dto.getMonth()!=null&&dto.getDate()!=null) {
				dto.setBirth(dto.getYear()+""+dto.getMonth()+""+dto.getDate());
			}
			dao.updateData("mypage.updateuser1", dto);
			dao.updateData("mypage.updateuser2", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteUser(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("mypage.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 주문리스트
	@Override
	public List<Mypage> orderlist(Map<String, Object> map) {
		List<Mypage> list = null;
		try {
			list = dao.selectList("mypage.orderList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 자유게시판 리스트
	@Override
	public List<Mypage> freelist(Map<String, Object> map) {
		List<Mypage> list = null;
		try {
			list = dao.selectList("mypage.freelist", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int freeCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("mypage.freeCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 추천게시판 리스트
	@Override
	public List<Mypage> recommendlist(Map<String, Object> map) {
		List<Mypage> list = null;
		try {
			list = dao.selectList("mypage.recommendlist", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int recommendCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("mypage.recommendCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int checkReview(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("mypage.checkReview",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 리뷰 리스트
	@Override
	public List<Mypage> reviewlist(Map<String, Object> map) {
		List<Mypage> list = null;
		try {
			list = dao.selectList("mypage.reviewlist", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int reviewCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("mypage.reviewCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// 리뷰 삭제
	@Override
	public void deleteReview(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("mypage.deleteReview", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	// 문의 리스트
	@Override
	public List<Mypage> inquirelist(Map<String, Object> map) {
		List<Mypage> list = null;
		try {
			list = dao.selectList("mypage.inquirelist", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int inquireCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("mypage.inquireCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 주문 상세
	@Override
	public Mypage orderDetail(Map<String, Object> map) {
		Mypage dto = null;
		try {
			dto = dao.selectOne("mypage.orderdetailList",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public List<Mypage> orderDetailMenu(Map<String, Object> map) {
		List<Mypage> list=null;
		try {
			list=dao.selectList("mypage.orderdetailMenu", map);
		} catch (Exception e) {
		}
		return list;
	}


}