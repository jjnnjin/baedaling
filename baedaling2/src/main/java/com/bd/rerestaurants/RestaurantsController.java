package com.bd.rerestaurants;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bd.common.MyUtil;
import com.bd.user.Sessionlocation;

@Controller("restaurants.restaurantsController")
@RequestMapping("/restaurants/*")
public class RestaurantsController {
	@Autowired
	private RestaurantsService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="list")
	public String list(
			@RequestParam int typecategorynum,
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="state", defaultValue="distance") String state,
			@RequestParam(value="typecategorynum", defaultValue="13") String scope,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception{
		Sessionlocation location = (Sessionlocation) session.getAttribute("location");
		String cp = req.getContextPath();
		if(location==null) {
			return "redirect:/main";
		}
		Map<String, Object> map = new HashMap<String,Object>();
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		
		String city = location.getAddr().trim();
		city = city.substring(0,city.indexOf(" "));
		
		String longitude = location.getLongitude();
		String latitude = location.getLatitude();
		
		map.put("city", city);
		map.put("typecategorynum", typecategorynum);
		map.put("longitude",longitude);
		map.put("latitude", latitude);
		
		if(typecategorynum==13) {
			dataCount = service.dataAllCount(map);
		} else {
			dataCount = service.dataCount(map);
		}
		total_page = myUtil.pageCount(rows, dataCount);
		
		if(current_page>total_page) {
			current_page = total_page;
		}
		int offset = (current_page-1)*rows;
		if(offset<0) {
			offset = 0;
		}
		
		map.put("rows", rows);
		map.put("offset", offset);
		
		
		List<Restaurants> list = null;
		try {
			if(state.equals("distance")) {;
				if(typecategorynum==13) { 
					list = service.listAllRestaurants(map);
				} else {
					list = service.listRestaurants(map);
				}
			} else if(state.equals("star")) {
				if(typecategorynum==13) { 
					list = service.listAllStarRestaurants(map);
				} else {
					list = service.listStarRestaurants(map);
				}
			} else if(state.equals("review")) {
				if(typecategorynum==13) { 
					list = service.listAllReviewRestaurants(map);
				} else {
					list = service.listReviewRestaurants(map);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		String query = "";
        
        query = "state="+state+"&typecategorynum="+typecategorynum;

        String listUrl = cp+"/restaurants/list?"+query;
        
        String paging = myUtil.paging(current_page, total_page, listUrl);
        model.addAttribute("searchBar", "true");
        model.addAttribute("typecategorynum",typecategorynum);
        model.addAttribute("list", list);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        model.addAttribute("state", state);
        
		return ".restaurantsmenu.list";
	}
}
