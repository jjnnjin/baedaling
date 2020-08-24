package com.bd.freeboard;

import java.util.List;
import java.util.Map;

public interface FreeBoardService {
	public void insertBoard(FreeBoard dto, String pathname) throws Exception;
	public List<FreeBoard> listBoard(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public FreeBoard readBoard(int num);
	public void updateHitCount(int num) throws Exception;
	public FreeBoard preReadBoard(Map<String, Object> map);
	public FreeBoard nextReadBoard(Map<String, Object> map);
	public void updateBoard(FreeBoard dto, String pathname)throws Exception;
	public void deleteBoard(int num, String pathname) throws Exception;

	//파일
	public void insertFile(FreeBoard dto) throws Exception;
	public List<FreeBoard> listFile(int num);
	public FreeBoard readFile(int fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
	
	//좋아요 
	public void insertBoardLike(Map<String, Object> map) throws Exception;
	public int boardLikeCount(int num);
	
	//댓글
	public void insertReply(Reply dto)throws Exception;
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;

}
