package com.bd.menu;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bd.common.FileManager;
import com.bd.common.dao.CommonDAO;

@Service("menu.menuService")
public class MenuServiceImpl implements MenuService{

	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	
	@Override
	public void insertMenu(Menu dto, String pathname) throws Exception {
		
		try {
			String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename != null) {
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
			}
			int result =  dao.selectOne("menu.restaurantsNum",dto.getUserIdx());
			dto.setRestaurantsNum(result);
			dao.insertData("menu.insertMenu",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		
		
	}

	@Override
	public List<Menu> listMenu(Map<String, Object> map) {
		List<Menu> list = null;
		try {
			list = dao.selectList("menu.listMenu", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("menu.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Menu readMenu(int menuNum) {
		Menu dto = null;
		try {
			dto =  dao.selectOne("menu.readMenu", menuNum);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateMenu(Menu dto, String pathname) throws Exception {
		try{
			String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename != null) {
				if(dto.getSaveFilename()!=null && dto.getSaveFilename().length()!=0)
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
			}
			
			dao.updateData("menu.updateMenu", dto);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteMenu(int menuNum, String pathname) throws Exception {
		try{
			Menu dto=readMenu(menuNum);
			
			
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
			
			dao.deleteData("menu.deleteMenu", menuNum);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Menu> listCategory() {
		List<Menu> list = null;
		try {
			list = dao.selectList("menu.listCategory");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
