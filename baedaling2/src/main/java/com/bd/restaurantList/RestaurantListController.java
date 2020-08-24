package com.bd.restaurantList;

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

@Controller("restaurantList.restaurantListController")
@RequestMapping("/restaurant/*")
public class RestaurantListController {
	
	@Autowired
	private RestaurantListService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("restaurantWaitlist")
	public String restaurantsWaitlist(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="name") String condition,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam(defaultValue="1") String ready,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception {
		
		String cp = req.getContextPath();
		
		int rows=5;
		int total_page=0;
		int dataCount=0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword=URLDecoder.decode(keyword, "utf-8");
		}
		
		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ready", ready);
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount=service.waitDataCount(map);
		
		if(dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		if(total_page<current_page) {
			current_page=total_page;
		}
		
		// 리스트에 출력할 데이터를 가져오기
		int offset=(current_page-1)*rows;
		if(offset<0) offset=0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		// 글 리스트
		List<RestaurantList> list = service.listWaitRestaurant(map);
		
		// 리스트 번호
		int listNum, n=0;
		for(RestaurantList dto : list) {
			listNum = dataCount-(offset+n);
			dto.setListNum(listNum);
			n++;
		}
		String query="";
		String listUrl=cp+"/restaurant/restaurantWaitlist";
		
		if(keyword.length()!=0) {
			query="condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		 }
		if(ready.length()!=0) {
			if(query.length()!=0)
				query=query+"&ready="+ready;
			else
				query="ready="+ready;
		}
		
		if(query.length()!=0) {

			listUrl = cp+"/restaurant/restaurantWaitlist?"+query;
		}
		
		String paging=myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("listUrl", listUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("ready", ready);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".restaurant.restaurantsWaitList";
	}
	// AJAX-Text
	@RequestMapping(value="/restaurant/detaileRestaurant")
	public String detaileRestaurant(
			@RequestParam String restaurantsNum,
			Model model
			) throws Exception {
		RestaurantList dto = service.readUser(restaurantsNum);
		// List<RestaurantList> listState = service.listUserState(userId);
		
		model.addAttribute("dto", dto);
		// model.addAttribute("listState", listState);
		
		return "restaurant/detaileRestaurant";
	}
	@RequestMapping(value="/restaurant/updateUserState", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateUserState(
			RestaurantList dto
			) throws Exception {
		
		String state="true";
		
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("restaurantsNum", dto.getRestaurantsNum());
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
	
	
	@RequestMapping("restaurantlist")
	public String restaurantslist(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam(defaultValue="") String enabled,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception {
		String cp = req.getContextPath();
		
		int rows=20;
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
		// map.put("userId", info.getUserId());
		
		dataCount=service.dataCount(map);
		
		if(dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		if(total_page<current_page) {
			current_page=total_page;
		}
		
		// 리스트에 출력할 데이터를 가져오기
		int offset=(current_page-1)*rows;
		if(offset<0) offset=0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		// 글 리스트
		List<RestaurantList> list = service.listRestaurant(map);
		
		// 리스트 번호
		int listNum, n=0;
		for(RestaurantList dto : list) {
			listNum = dataCount-(offset+n);
			dto.setListNum(listNum);
			n++;
		}
		String query="";
		String userListUrl=cp+"/restaurant/restaurantlist?page="+current_page;
		
		//String listUrl=cp+"/restaurant/restaurantlist";
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
//			listUrl=cp+"/restaurant/restaurantlist?"+query; // jsp
			userListUrl = cp+"/restaurant/restaurantlist?page="+current_page+"&"+query;
		}
		
		String paging=myUtil.paging(current_page, total_page, userListUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("userListUrl", userListUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("enabled", enabled);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".restaurant.restaurantlist";
	}
	
	@RequestMapping(value="updateRestaurant", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateRestaurant(
			@RequestParam int restaurantsNum
			){
		String state = "true";
		try {
			service.updateReady(restaurantsNum);

		} catch (Exception e) {
			state = "false";
		}
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	
	
}
