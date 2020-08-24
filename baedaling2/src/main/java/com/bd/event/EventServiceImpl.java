package com.bd.event;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bd.common.FileManager;
import com.bd.common.dao.CommonDAO;

@Service("event.eventService")
public class EventServiceImpl implements EventService {
	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertEvent(Event dto, String pathname) throws Exception {
		try {
			String bannerFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
			if(bannerFilename!=null) {
				dto.setImageFilename(bannerFilename);
			}
			
			dao.insertData("event.insertEvent", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("event.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Event> listEvent(Map<String, Object> map) {
		List<Event> list = null;
		try {
			list = dao.selectList("event.listEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.updateData("event.updateHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Event readEvent(int num) {
		Event dto = null;
		try {
			dto = dao.selectOne("event.readEvent", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Event preReadEvent(Map<String, Object> map) {
		Event dto = null;
		try {
			dto = dao.selectOne("event.preReadEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Event nextReadEvent(Map<String, Object> map) {
		Event dto = null;
		try {
			dto = dao.selectOne("event.nextReadEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateEvent(Event dto, String pathname) throws Exception {
		try {
			String bannerFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
			
			if(bannerFilename != null) {
				if(dto.getImageFilename().length()!=0) {
					fileManager.doFileDelete(dto.getImageFilename(), pathname);
				}
				
				dto.setImageFilename(bannerFilename);
			}
		
			dao.updateData("event.updateEvent", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteEvent(int num, String pathname, String userId) throws Exception {
		try {
			Event dto = readEvent(num);
			if(dto==null) {
				return;
			}
			if(dto.getImageFilename()!=null)
					fileManager.doFileDelete(dto.getImageFilename(), pathname);
			
			dao.deleteData("event.deleteEvent", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}