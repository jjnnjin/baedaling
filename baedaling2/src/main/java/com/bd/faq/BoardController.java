package com.bd.faq;

import java.net.URLDecoder;
import java.net.URLEncoder;
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

import com.bd.common.MyUtil;
import com.bd.user.SessionInfo;

@Controller("faq.boardController")
@RequestMapping("/faq/*")
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="0") int group,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception{
		String cp = req.getContextPath();
		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword,"utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("group", group);
		map.put("condition", condition);
		map.put("keyword", keyword);
		
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
        
        List<Board> list = service.listBoard(map);
        
        int listNum = 0;
        int n = 0;
        
        for(Board dto : list) {
        	listNum = dataCount - (offset +n);
        	dto.setListNum(listNum);
        	n++;
        }
        
        String query = "";
        String listUrl = cp+"/faq/list?group="+group;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length() != 0) {
        	listUrl += "&" + query;
        }
        
        String paging = myUtil.paging(current_page, total_page, listUrl);
		List<Board> grouplist = service.listCategory();
		
		model.addAttribute("searchBar","faq");
		model.addAttribute("groupList",grouplist);
        model.addAttribute("list",list);
        model.addAttribute("group",group);
        model.addAttribute("page",current_page);
        model.addAttribute("dataCount",dataCount);
        model.addAttribute("total_page",total_page);
        model.addAttribute("paging",paging);
        model.addAttribute("condition",condition);
        model.addAttribute("keyword",keyword);
        
		
		return ".faq.list";
	}
	
	@RequestMapping(value = "created", method = RequestMethod.GET)
	public String createdForm(
			Model model
			) throws Exception{
		List<Board> groupList = service.listCategory();
		
		model.addAttribute("mode","created");
		model.addAttribute("groupList",groupList);
		
		return ".faq.created";		
	}
	
	@RequestMapping(value="created", method=RequestMethod.POST)
	public String createdSubmit(
			Board dto,
			HttpSession session
			) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("user");
		
		try {
			dto.setUserName(info.getUserName());
			service.insertBoard(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/faq/list";
	}
	
	@RequestMapping(value="delete")
	public String delete(
			@RequestParam int num,
			@RequestParam int group,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword
			) throws Exception{
		
		keyword = URLDecoder.decode(keyword,"utf-8");
		String query = "group=" + group + "&page="+page;
		if(keyword.length() != 0) {
			query += "&condition="+condition+"&keyword="+keyword;
		}
		
		Map<String , Object> map = new HashMap<>();
		map.put("num", num);
		
		service.deleteBoard(map);
		
		return "redirect:/faq/list?"+query;
	}
	
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam String page,
			Model model
			) {
		
		Board dto = service.readBoard(num);
		if(dto == null) {
			return "redirect:/list?page="+page;
		}
		
		List<Board> groupList = service.listCategory();
		
		model.addAttribute("mode","update");
		model.addAttribute("groupList",groupList);
		model.addAttribute("page",page);
		model.addAttribute("dto",dto);
		
		return ".faq.created";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			Board dto,
			@RequestParam String page
			) throws Exception {
		try {
			service.updateBoard(dto);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "redirect:/faq/list?page="+page;
	}
	
	
}
