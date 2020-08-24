package com.bd.foodorder;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bd.common.FileManager;
import com.bd.common.MyUtil;
import com.bd.user.SessionInfo;


@Controller("foodorder.foodOrderController")
@RequestMapping("/dashboard/*")
public class FoodOrderController {
	@Autowired
	private FoodOrderService service;
	@Autowired
	private FileManager fileManager;
	@Autowired
	private MyUtil myUtil;

	
	@RequestMapping("dashboard")
	public String dashboard(
			@RequestParam int restaurantsNum,
			HttpServletRequest req,
			Model model
			) {
		int orderCount = 0; 
		int waitngCount = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		//오늘 주문
		map.put("restaurantsNum", restaurantsNum);
		orderCount = service.todayOrderCount(map);
		//대기중인 주문
		map.put("restaurantsNum", restaurantsNum);
		map.put("foodOrderState", "주문완료");
		waitngCount = service.orderCount(map);
		//오늘, 이달 매출
		FoodOrder today = service.todaySalesRead(restaurantsNum);
		FoodOrder month = service.monthlySalesRead(restaurantsNum);
		//가게정보
		FoodOrder dto = service.readInfo(restaurantsNum);

		model.addAttribute("orderCount", orderCount);
		model.addAttribute("waitngCount", waitngCount );
		model.addAttribute("today", today);
		model.addAttribute("month", month);
		model.addAttribute("dto", dto);
		model.addAttribute("restaurantsNum",restaurantsNum);
		return ".dashboard.dashboard";
		
	}
	
	
	
	@RequestMapping(value="orderlist")
	public String orderList(
			@RequestParam int restaurantsNum,
			@RequestParam (value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			Model model
			) {
		
		int orderCount1 =0;
		int orderCount2 =0;
		int orderCount3 =0;
		int orderCount4 =0;
	
		String cp = req.getContextPath();
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
		int offset = (current_page-1) * rows;
	 		if(offset < 0) offset = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("restaurantsNum", restaurantsNum);
		map.put("foodOrderState", "주문완료");
		List<FoodOrder> list1 = service.readOrder(map);
		orderCount1 = service.orderCount(map);
		
		map.put("restaurantsNum", restaurantsNum);
		map.put("foodOrderState", "접수완료");
		List<FoodOrder> list2 = service.readOrder(map);
		orderCount2 = service.orderCount(map);
		
		map.put("restaurantsNum", restaurantsNum);
		map.put("foodOrderState", "배달중");
		List<FoodOrder> list3 = service.readOrder(map);
		orderCount3 = service.orderCount(map);
		
		map.put("restaurantsNum", restaurantsNum);
		map.put("foodOrderState", "배달완료");
		map.put("offset",offset);
		map.put("rows",rows);
		List<FoodOrder> list4 = service.readOrder(map);
		orderCount4 = service.orderCount(map);
		
		
	     int listNum =0;
	     int n = 0;
	     for(FoodOrder dto : list4) {
	       listNum = dataCount - (offset + n);
	       dto.setListNum(listNum);
	       n++;
	      }
	     
	    String query = "restaurantsNum="+restaurantsNum; 
	    String listUrl = cp+"/dashboard/orderlist?"+query;
	    String paging = myUtil.paging(current_page, total_page, listUrl);
		model.addAttribute("list1", list1);
		model.addAttribute("list2",list2);
		model.addAttribute("list3",list3);
		model.addAttribute("list4",list4);
		model.addAttribute("orderCount1", orderCount1);
		model.addAttribute("orderCount2", orderCount2);
		model.addAttribute("orderCount3", orderCount3);
		model.addAttribute("orderCount4", orderCount4);
		model.addAttribute("restaurantsNum", restaurantsNum);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		return ".dashboard.orderlist";
	}
	
	
	
	

	
	
	
	@RequestMapping(value="salesList")
	public String page(
			@RequestParam int restaurantsNum,
			@RequestParam (value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			Model model
			) throws Exception{
		// List<FoodOrder> bestlist = service.bestMenuChart(restaurantsNum);
		String cp = req.getContextPath();
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
		Map<String, Object> mm = new HashMap<String, Object>();
		mm.put("restaurantsNum", restaurantsNum);
		mm.put("foodOrderState", "배달완료");
		dataCount = service.allorderCount(mm);
		
		if(dataCount != 0)
            total_page = myUtil.pageCount(rows,  dataCount) ;
		
	     if(total_page < current_page) 
	            current_page = total_page;
			
	        int offset = (current_page-1) * rows;
	 		if(offset < 0) offset = 0;
	         mm.put("offset", offset);
	         mm.put("rows", rows);
	    List<FoodOrder> listall = service.allList(mm);
		
		FoodOrder today = service.todaySalesRead(restaurantsNum);
		FoodOrder month = service.monthlySalesRead(restaurantsNum);
		FoodOrder annual = service.annualSalesRead(restaurantsNum);
		
		//Map<String, Object> sSales = service.montlyChart(restaurantsNum);
	     int listNum =0;
	     int n = 0;
	     for(FoodOrder dto : listall) {
	       listNum = dataCount - (offset + n);
	       dto.setListNum(listNum);
	       n++;
	      }
	     
	    String query = "restaurantsNum="+restaurantsNum; 
	    String listUrl = cp+"/dashboard/salesList?"+query;
	    String paging = myUtil.paging(current_page, total_page, listUrl);
		
		
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		model.addAttribute("today",today);
		model.addAttribute("month",month);
		model.addAttribute("annual",annual);
		model.addAttribute("restaurantsNum",restaurantsNum);
		model.addAttribute("list",listall);
	//	model.addAttribute("sSales", sSales);
		// model.addAttribute("bestlist",bestlist);
		
		return ".dashboard.salesList";
	}
	
	
	@RequestMapping(value="pie3d", produces="application/json;charset=utf-8")
	@ResponseBody	
	public String pie3d(
			@RequestParam int restaurantsNum
			) throws Exception{
		List<FoodOrder> bestlist = service.bestMenuChart(restaurantsNum);
		
		JSONArray arr = new JSONArray();
		JSONObject job = new JSONObject();
		
		JSONArray ja = new JSONArray();
		for(FoodOrder dto : bestlist) {
			ja.put(new JSONArray("['"+dto.getMenuName()+"',"+dto.getBestSales()+"]"));
		}
		
		job.put("data", ja);
		arr.put(job);
		
		return arr.toString();
	}
	
	
	@RequestMapping(value="pie3d2", produces="application/json;charset=utf-8")
	@ResponseBody	
	public String pie3d2(
			@RequestParam int restaurantsNum
			) throws Exception{
		List<FoodOrder> todaylist = service.todayBestMenu(restaurantsNum);
		
		JSONArray arr = new JSONArray();
		JSONObject job = new JSONObject();
		
		JSONArray ja = new JSONArray();
		for(FoodOrder dto : todaylist) {
			ja.put(new JSONArray("['"+dto.getMenuName()+"',"+dto.getBestSales()+"]"));
		}
		
		job.put("data", ja);
		arr.put(job);
		
		return arr.toString();
	}
	
	
	@RequestMapping(value="barChart", produces="application/json;charset=utf-8")
	@ResponseBody
	public String lineChart(
			@RequestParam int restaurantsNum
			)throws Exception{
		
		Map<String, Object> sSales = service.montlyChart(restaurantsNum);
		
		JSONArray arr = new JSONArray();
		
		JSONObject ob;
		ob = new JSONObject();
		ob.put("name", "1월");
		ob.put("y", sSales.get("M01"));
		arr.put(ob);
		
		ob = new JSONObject();
		ob.put("name", "2월");
		ob.put("y", sSales.get("M02"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "3월");
		ob.put("y", sSales.get("M03"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "4월");
		ob.put("y", sSales.get("M04"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "5월");
		ob.put("y", sSales.get("M05"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "6월");
		ob.put("y", sSales.get("M06"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "7월");
		ob.put("y", sSales.get("M07"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "8월");
		ob.put("y", sSales.get("M08"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "9월");
		ob.put("y", sSales.get("M09"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "10월");
		ob.put("y", sSales.get("M10"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "11월");
		ob.put("y", sSales.get("M11"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "12월");
		ob.put("y", sSales.get("M12"));
		arr.put(ob);
		
		JSONObject job = new JSONObject();
		job.put("name", "월별 판매현황");
		job.put("colorByPoint", true);
		job.put("data", arr);

		
		JSONArray jarr = new JSONArray();
		jarr.put(job);

		return jarr.toString(); 
	}
	
	
	
	@RequestMapping(value="lineChart", produces="application/json;charset=utf-8")
	@ResponseBody
	public String lineChart2(
			@RequestParam int restaurantsNum
			)throws Exception{
		
		Map<String, Object> reviews = service.reviewChart(restaurantsNum);
		
		JSONArray arr = new JSONArray();
		
		JSONObject ob;
		ob = new JSONObject();
		ob.put("name", "1월");
		ob.put("y", reviews.get("M01"));
		arr.put(ob);
		
		ob = new JSONObject();
		ob.put("name", "2월");
		ob.put("y", reviews.get("M02"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "3월");
		ob.put("y", reviews.get("M03"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "4월");
		ob.put("y", reviews.get("M04"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "5월");
		ob.put("y", reviews.get("M05"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "6월");
		ob.put("y", reviews.get("M06"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "7월");
		ob.put("y", reviews.get("M07"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "8월");
		ob.put("y", reviews.get("M08"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "9월");
		ob.put("y", reviews.get("M09"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "10월");
		ob.put("y", reviews.get("M10"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "11월");
		ob.put("y", reviews.get("M11"));
		arr.put(ob);

		ob = new JSONObject();
		ob.put("name", "12월");
		ob.put("y", reviews.get("M12"));
		arr.put(ob);
		
		JSONObject job = new JSONObject();
		job.put("name", "월별 리뷰 개수");
		job.put("colorByPoint", true);
		job.put("data", arr);

		
		JSONArray jarr = new JSONArray();
		jarr.put(job);

		return jarr.toString(); 
	}
	
	
	
	
	@RequestMapping(value="updateState" ,produces="application/json;charset=utf-8")
	@ResponseBody
	public Map<String, Object> updateState(
			@RequestParam int foodorderNum,
			@RequestParam String orderState
			) throws Exception{
		
		String state = "false";
		
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("orderState", orderState);
			map.put("foodorderNum", foodorderNum);
			
			service.updateOrderState(map);
			service.orderCount(map);
			if(orderState.equals("배달완료")) {
				service.updateCompleteDate(foodorderNum);
			}
			state = "true";
		} catch (Exception e) {
			
		}
		Map<String, Object> model = new HashMap<>();
		model.put("state",state);
		
		return model;
		
	}
	
	@RequestMapping(value="delete", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(
			@RequestParam int foodorderNum
			) throws Exception{
		String state = "false";
		try {
			service.deleteOrder(foodorderNum);
			state = "true";
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	
	@RequestMapping("fcinfo_read")
	public String infoPage(
			@RequestParam int restaurantsNum,
			Model model
			)throws Exception{
		
		FoodOrder dto = service.readInfo(restaurantsNum);
		if(dto==null)
			return "redirect:/dashboard/orderlist?";
		
		List<FoodOrder> listFile = service.listFile(restaurantsNum);
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
	//	model.addAttribute("query", query);
		
		return ".dashboard.fcinfo_read";
	}
	
	
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int restaurantsNum,
			Model model
			) throws Exception{
		FoodOrder dto = service.readInfo(restaurantsNum);
		if(dto==null) {
			return "redirect:/dachboard/orderlist?";
		}
		List<FoodOrder> listFile = service.listFile(restaurantsNum);
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		
		return ".dashboard.fcinfo_write";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			FoodOrder dto,
			HttpSession session
			)throws Exception{
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + File.separator + "resource" + File.separator + "dashboard";
			service.updateInfo(dto, pathname);
			service.updateFcState(dto);
		} catch (Exception e) {
		}
		return "redirect:/dashboard/fcinfo_read?restaurantsNum="+dto.getRestaurantsNum();
	}
	
	
	@RequestMapping(value="updateFcState")
	public String updateFcState(
			FoodOrder dto,
			@RequestParam int restaurantsNum
			) throws Exception{
		
		try {
			service.updateFcState(dto);
		} catch (Exception e) {
		}
		return "redirect:/dashboard/fcinfo_read?restaurantsNum="+dto.getRestaurantsNum();
	}
			
	
	@RequestMapping(value="deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(
			@RequestParam int fileNum,
			HttpSession session
			)throws Exception{
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"resource"+File.separator+"dashboard";
		
		FoodOrder dto = service.readFile(fileNum);
		if(dto!=null) {
			fileManager.doFileDelete(dto.getSaveFilename(),pathname);
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("fileNum", fileNum);
		service.deleteFile(map);
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", "true");
		return model;
		
	}
	
	
	@RequestMapping("myReviewList")
	public String reviewList(
			@RequestParam int restaurantsNum,
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			Model model
			) {
		String cp = req.getContextPath();
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		
		int reviewCount = 0;
		Map<String, Object> map = new HashMap<>();
		
		map.put("restaurantsNum", restaurantsNum);
		reviewCount = service.reviewCount(map);
		
		if(reviewCount != 0)
            total_page = myUtil.pageCount(rows,  reviewCount) ;
		
	    // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
            current_page = total_page;
		
        int offset = (current_page-1) * rows;
 		if(offset < 0) offset = 0;
         map.put("offset", offset);
         map.put("rows", rows);
        
		List<FoodOrder> list = service.reviewList(map);
		
	     int listNum =0;
	     int n = 0;
	     for(FoodOrder dto : list) {
	       listNum = reviewCount - (offset + n);
	       dto.setListNum(listNum);
	       n++;
	      }
	    
	    String query = "restaurantsNum="+restaurantsNum;
	    String listUrl = cp+"/dashboard/myReviewList?"+query;
        String articleUrl = cp+"/dashboard/reviewRead?"+query+"&page=" + current_page;

	    String paging = myUtil.paging(current_page, total_page, listUrl);
		
		
		model.addAttribute("list", list);
		model.addAttribute("reviewCount", reviewCount);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		return ".dashboard.myReviewList";
	}
	
	
	
	@RequestMapping("myReplyList")
	public String replyList(
			@RequestParam int restaurantsNum,
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			Model model
			) {
		
		String cp = req.getContextPath();
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		
		int reviewCount = 0;
		Map<String, Object> map = new HashMap<>();
		
		map.put("restaurantsNum", restaurantsNum);
		reviewCount = service.replyCount(map);
		
		if(reviewCount != 0)
            total_page = myUtil.pageCount(rows,  reviewCount) ;
		
	    // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
            current_page = total_page;
		
        int offset = (current_page-1) * rows;
 		if(offset < 0) offset = 0;
         map.put("offset", offset);
         map.put("rows", rows);
        
		List<FoodOrder> list = service.reply(map);
		
	     int listNum =0;
	     int n = 0;
	     for(FoodOrder dto : list) {
	       listNum = reviewCount - (offset + n);
	       dto.setListNum(listNum);
	       n++;
	      }
	    String query = "restaurantsNum="+restaurantsNum;
	    String listUrl = cp+"/dashboard/myReplyList?"+query;
	    String paging = myUtil.paging(current_page, total_page, listUrl);
		
		
		model.addAttribute("list", list);
		model.addAttribute("reviewCount", reviewCount);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return ".dashboard.myReplyList";
	}
	
	
	@RequestMapping("reviewRead")
	public String reviewRead(
			@RequestParam int restaurantsNum,
			@RequestParam int reviewNum,
			@RequestParam String page,
			Model model
			) {
		String query="page="+page;
		FoodOrder dto = service.reviewRead(reviewNum);
		
		model.addAttribute("query", query);
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		return ".dashboard.reviewRead";
	}
	
	
	@RequestMapping(value="insertReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(
			FoodOrder dto
			) {
		String state="true";
		
		try {
			service.insertReply(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	
	@RequestMapping(value="listReply")
	public String listReply(
			@RequestParam int restaurantsNum,
			@RequestParam int reviewNum,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model
			) throws Exception {
		
		int rows=5;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map=new HashMap<>();
		map.put("restaurantsNum", restaurantsNum);
		map.put("reviewNum", reviewNum);
		dataCount=service.replyCount(map);

		total_page = myUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
		List<FoodOrder> listReply=service.replyList(map);
		
		for(FoodOrder dto : listReply) {
			dto.setReply(dto.getReply());
		}
		
		// AJAX 용 페이징
		String paging=myUtil.pagingMethod(current_page, total_page, "listPage");
		
		// 포워딩할 jsp로 넘길 데이터
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "dashboard/listReply";
	}


	@RequestMapping(value = "updateRestaurant", method = RequestMethod.GET)
	public String updateRestaurant(
			HttpSession session,
			Model model
			) {
		SessionInfo info = (SessionInfo)session.getAttribute("user");
		int restaurantsNum = info.getRestaurantsNum();
		FoodOrder dto = service.readRestaurant(restaurantsNum);
		model.addAttribute("dto",dto);	
		return ".dashboard.fcupdate";
	}
	
	
	@RequestMapping(value = "updateRestaurant", method = RequestMethod.POST)
	public String updateRestaurantSubmit(
			FoodOrder dto,
			HttpSession session
			)throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("user");
		int restaurantsNum = info.getRestaurantsNum();
		try {
			service.updateRestaurant(dto);
		} catch (Exception e) {
		}
			
		return "redirect:/dashboard/dashboard?restaurantsNum="+restaurantsNum;
	}
	
	
	
	
	
	
}
