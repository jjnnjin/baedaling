package com.bd.menu;

import java.util.List;
import java.util.Map;

public interface MenuService {

	public void insertMenu(Menu dto, String pathname) throws Exception;
	public List<Menu> listMenu(Map<String, Object> map);
	public int dataCount(Map<String,Object> map);
	public Menu readMenu(int menuNum);
	public void updateMenu(Menu dto, String pathname) throws Exception;
	public void deleteMenu(int menuNum, String pathname) throws Exception;
	public List<Menu> listCategory();

}
