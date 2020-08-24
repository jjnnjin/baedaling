package com.bd.faq;

import java.util.List;
import java.util.Map;

public interface BoardService {
	
	public void insertBoard(Board dto) throws Exception;
	public List<Board> listBoard(Map<String,Object> map);
	public int dataCount(Map<String,Object> map);
	public Board readBoard(int num);
	public void updateBoard(Board dto) throws Exception;
	public void deleteBoard(Map<String,Object> map) throws Exception;
	
	public void insertCategory(Map<String, Object> map) throws Exception;
	public void updateCategory(Map<String, Object> map) throws Exception;
	public List<Board> listCategory();
	public void deleteCategory(int categoryNum) throws Exception;
}
