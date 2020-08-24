package com.bd.fcnotice;

import java.util.List;
import java.util.Map;




public interface FcNoticeService {
	public void insertNotice(FcNotice dto, String pathname) throws Exception;
	public int dataCount(Map<String,Object> map);
	public List<FcNotice> listNotice(Map<String,Object> map);
	public List<FcNotice> listImpotantNotice();
	public void updateHitCount(int num) throws Exception;
	public FcNotice readNotice(int num);
	public FcNotice preReadNotice(Map<String,Object> map);
	public FcNotice nextReadNotice(Map<String,Object> map);
	public void updateNotice(FcNotice dto, String pathname) throws Exception;
	public void deleteNotice(int num, String pathname) throws Exception;
	
	public void insertFile(FcNotice dto) throws Exception;
	public List<FcNotice> listFile(int num);
	public FcNotice readFile(int fileNum);
	public void deleteFile(Map<String,Object> map) throws Exception;
}
