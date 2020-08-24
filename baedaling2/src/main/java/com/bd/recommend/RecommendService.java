package com.bd.recommend;

import java.util.List;
import java.util.Map;

public interface RecommendService {
	public void writeRecommend(Recommend dto, String pathname) throws Exception;
	public List<Recommend> listRecommend(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Recommend readPage(int num);
	public void updateHitCount(int num) throws Exception;
	public Recommend preReadRecommend(Map<String, Object> map);
	public Recommend nextReadRecommend(Map<String, Object> map);
	public void updateRecommend(Recommend dto, String pathname) throws Exception;
	public void deleteRecommend(int num, String pathname) throws Exception;
	
	public void insertFile(Recommend dto) throws Exception;
	public List<Recommend> listFile(int num);
	public Recommend readFile(int fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
	
	public void insertRecommendLike(Map<String, Object> map) throws Exception;
	public int recommendLikeCount(int num);
	
	public void insertReply(RecommendReply dto) throws Exception;
	public List<RecommendReply> listReply(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;
	public int replyCount(Map<String, Object> map);
}
