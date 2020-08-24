package com.bd.review;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bd.common.dao.CommonDAO;

@Service("review.reviewService")
public class ReviewServiceImpl implements ReviewService{
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertReview(Review dto) throws Exception {
		try {
			int seq = dao.selectOne("rv.seq");
			dto.setReviewNum(seq);
			dao.insertData("rv.insertReview", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Review> mycontentList(Map<String, Object> map) {
		List<Review> list = null;
		try {
			list = dao.selectList("rv.mycontentList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("rv.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
