package com.bd.menu;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bd.common.MyUtil;
import com.bd.user.SessionInfo;


@Controller("menu.MenuController")
public class MenuController {

	@Autowired
	private MenuService service;
	
	@Autowired
	private MyUtil myUtil;
	
	
	@RequestMapping(value="/menu/list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="0") int group,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception{
		String cp = req.getContextPath();
		SessionInfo info = (SessionInfo)session.getAttribute("user");
		
		int rows = 12;
		int total_page = 0;
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("group", group);
		map.put("restaurantsNum", info.getRestaurantsNum());
		
		dataCount = service.dataCount(map);
		if(dataCount != 0 ) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		if(total_page< current_page) {
			current_page = total_page;
		}
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        List<Menu> list = service.listMenu(map);
        int listNum = 0;
        int n = 0;
        
        for(Menu dto : list) {
        	listNum = dataCount - (offset +n);
        	dto.setListNum(listNum);
        	n++;
        }
        String listUrl = cp+"/menu/list?group="+group;
        String paging = myUtil.paging(current_page, total_page, listUrl);
		List<Menu> groupList = service.listCategory();
        
        model.addAttribute("groupList",groupList);
        model.addAttribute("list",list);
        model.addAttribute("group",group);
        model.addAttribute("page",current_page);
        model.addAttribute("dataCount",dataCount);
        model.addAttribute("total_page",total_page);
        model.addAttribute("paging",paging);
        
		return ".menu.list";
	}
	
	@RequestMapping(value="/menu/created", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> insertSubmit(Menu dto,
			HttpSession session
			) throws Exception{
		String state = "false";
		SessionInfo info = (SessionInfo)session.getAttribute("user");
		dto.setUserIdx(info.getUserIdx());
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "menu";
			service.insertMenu(dto, pathname);
			state="true";
		} catch (Exception e) {
			e.printStackTrace();
		}
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
		
	}
	
	
	@RequestMapping(value="menu/read", method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> readMenu(int menuNum){
		Map<String, Object> map = new HashMap<>();
		Menu dto = service.readMenu(menuNum);
		
		
		map.put("dto", dto);
		return map;
	}
	
	@RequestMapping(value="/menu/update", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> updateSubmit(Menu dto,
			HttpSession session
			) throws Exception{
		String state = "false";
		SessionInfo info = (SessionInfo)session.getAttribute("user");
		dto.setUserIdx(info.getUserIdx());
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "menu";
			service.updateMenu(dto, pathname);
			state="true";
		} catch (Exception e) {
			e.printStackTrace();
		}
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
		
	}
	
	
	@RequestMapping(value="/menu/delete", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(
			@RequestParam int menuNum,
			HttpSession session) throws Exception {
		
		String state="false";
		
		
			try {
				String root = session.getServletContext().getRealPath("/");
				String pathname = root + "uploads" + File.separator + "menu";
				service.deleteMenu(menuNum, pathname);
				state="true";
			} catch (Exception e) {
			}
		
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	
	
}
