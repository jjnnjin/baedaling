package com.bd.manage;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.bd.common.MyUtil;
import com.bd.user.SessionInfo;

@Controller("manage.manageController")
@RequestMapping("/manage/*")
public class ManageController {
	
	@Autowired
	private ManageService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("userlist")
	// 회원 목록 
	public String userlist(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam(defaultValue="") String enabled,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("user");
		String cp = req.getContextPath();
		
		int rows = 20;
		int total_page=0;
		int dataCount=0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword=URLDecoder.decode(keyword, "utf-8");
		}
		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("enabled", enabled);
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount=service.dataCount(map);
		if(dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		if(total_page < current_page) {
			current_page = total_page;
		}
		
		// 리스트에 출력할 데이터를 가져오기
		int offset = (current_page-1)*rows;
		if(offset<0) offset=0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		// 회원 리스트
		List<Manage> list = service.listManage(map);
		// 리스트 번호
		int listNum, n=0;
		for(Manage dto : list) {
			listNum = dataCount-(offset+n);
			dto.setListNum(listNum);
			n++;
		}
		
		String query="";
		String userListUrl = cp+"/manage/userlist?page="+current_page;
		
		if(keyword.length()!=0) {
			query="condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		if(enabled.length()!=0) {
			if(query.length()!=0)
				query=query+"&enabled="+enabled;
			else 
				query="enabled="+enabled;
		}
		
		if(query.length()!=0) {
			userListUrl = cp+"/manage/userlist?page="+current_page+"&"+query;
			
		}
		
		String paging = myUtil.paging(current_page, total_page, userListUrl);
		
		model.addAttribute("searchBar","manageBoard");
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("enabled", enabled);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".manage.userlist";
	}
	// AJAX-Text
	// 회원정보 누르면 상세정보와 차단/해제 할 수 있는 창 
	@RequestMapping(value="/manage/detaileUser")
	public String detaileUser(
			@RequestParam String userId,
			Model model
			) throws Exception {
		Manage dto = service.readUser(userId);
		// Manage userState=service.readUserState(userId);
		// List<Manage> listState = service.listUserState(userId);
		
		
		model.addAttribute("dto", dto);
		// model.addAttribute("userState", userState);
		// model.addAttribute("listState", listState);
		
		return "manage/detaileUser";
	
	}
	
	@RequestMapping(value="/manage/updateUserState", method=RequestMethod.POST)
	@ResponseBody
	// 회원 차단/해제 
	public Map<String, Object> updateUserState(
			Manage dto
			) throws Exception {
		
		String state="true";
		
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("userId", dto.getUserId());
			System.out.println(dto.getUserId());
			if(dto.getStateCode()==1) {
				map.put("enabled", 1);
			} else {
				map.put("enabled", 0);
			}
			service.updateUserEnabled(map);
			// service.insertUserState(dto);
			
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value="/manage/orderlist")
	// 주문 리스트
	public String orderList(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception{
		String cp = req.getContextPath();
		
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
   	    
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
        // 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("condition", condition);
        map.put("keyword", keyword);
        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = myUtil.pageCount(rows,  dataCount) ;

        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
            current_page = total_page;

        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);

        List<Manage> list = service.allOrderList(map);
        
        int listNum =0;
        int n = 0;
        for(Manage dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
        
        String query = "";
        String listUrl = cp+"/manage/orderlist";
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/manage/orderlist?" + query;
        }
        
        String paging = myUtil.paging(current_page, total_page, listUrl);

        model.addAttribute("list", list);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".manage.orderlist";
	}
	
	
	
}
