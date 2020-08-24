package com.bd.review;

import java.util.List;
import java.util.Map;

public interface ReviewService {
	public void insertReview(Review dto) throws Exception;
	
	public List<Review> mycontentList(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
}
