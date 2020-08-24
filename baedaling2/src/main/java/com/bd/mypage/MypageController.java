package com.bd.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bd.common.MyUtil;
import com.bd.user.SessionInfo;

@Controller("mypage.mypageController")
@RequestMapping("/mypage/*")
public class MypageController {
	@Autowired
	private MypageService service;
	@Autowired
	private MyUtil myUtil;
	
	// 회원 정보
	@RequestMapping(value="userInfo")
	public String readMypage(
				Model model,
				HttpSession session
				) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("user");
		int userIdx = info.getUserIdx();
		
		Mypage dto = null;
		try {
			dto = service.readMypage(userIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
	    model.addAttribute("searchBar", "mypage");
		model.addAttribute("dto", dto);
		
		return ".mypage.userInfo";
	}
	
	// 회원 정보 수정
	@RequestMapping(value="message", method=RequestMethod.GET)
	public String passwordForm(Model model
			) throws Exception{
		
			String msg = "개인정보 보호를 위해 비밀번호를 다시 한번 입력해주세요.";
			model.addAttribute("title", "비밀번호 변경");
			model.addAttribute("message", msg);
			return ".mypage.message";
	}
	
	@RequestMapping(value="message", method=RequestMethod.POST)
	public String passwordCheck(
			@RequestParam String userPwd,
			Model model,
			HttpSession session
			) throws Exception {
			
			SessionInfo info = (SessionInfo)session.getAttribute("user");
	
			Mypage dto = service.readMypage(info.getUserIdx());
			
			// 입력한 비밀번호와 현재 비밀번호의 일치여부 (수정해야함)
			if(dto==null || !userPwd.equals(dto.getUserPwd())) {
				model.addAttribute("message","패스워드가 일치하지 않습니다. 다시 입력해주세요.");
				return ".mypage.message";
			}
			return "redirect:/mypage/infochange";
	}
	
	
	@RequestMapping(value="infochange", method=RequestMethod.GET)
	public String infoChangeFrom(Model model, HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("user");
		int userIdx = info.getUserIdx();
		
		
		Mypage dto = service.readMypage(userIdx);
		
		if(dto==null) {
			return "";
		}
	    model.addAttribute("searchBar", "mypage");
		model.addAttribute("dto", dto);
		
		return ".mypage.infochange";
	}
	
	@RequestMapping(value="infochange", method=RequestMethod.POST)
	public String infoChangeSubmit(
			Mypage dto,
			Model model,
			final RedirectAttributes redAttr,
			HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("user");
		int idx = info.getUserIdx();
		dto.setUserIdx(idx);
		
		try {
			service.updateUser(dto);
		} catch (Exception e) {
		}
		
		StringBuilder sb = new StringBuilder();
		sb.append(dto.getUserName()+"님의 회원 정보 수정이 정상적으로 처리되었습니다.");

		redAttr.addFlashAttribute("title", "회원정보 수정");
		redAttr.addFlashAttribute("message", sb.toString());
		
		return "redirect:/mypage/message2";
	}
	
	@RequestMapping(value="message2", method=RequestMethod.GET)
	public String message2(@ModelAttribute("message") String message) throws Exception {
		
		if(message==null || message.length()==0) 
			return "redirect:/";
		
		return ".mypage.message2";	
	}
	
	// 주문 내역 리스트
	@RequestMapping(value="userorderList")
	public String orderList(
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			Model model,
			HttpSession session
			) throws Exception {
	
		SessionInfo info = (SessionInfo)session.getAttribute("user");
		int idx = info.getUserIdx();
		String cp = req.getContextPath();	

		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userIdx", idx);
		
		dataCount = service.dataCount(map);
		
		if(dataCount != 0) total_page = myUtil.pageCount(rows,  dataCount) ;

		if(total_page < current_page) current_page = total_page;
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		 
	    List<Mypage> list = service.orderlist(map);
	     
	    int listNum = 0;
	    int n = 0;
	    for(Mypage vo : list) {
	         listNum = dataCount - (offset + n);
	         vo.setListNum(listNum);
	         n++;
	     }
		
	    String query = "";
	    String listUrl = cp+"/mypage/userorderList";
//	    String articleUrl = cp+"/mypage/page?page=" + current_page;
	    
	    if(query.length()!=0) {
	    	listUrl = cp+"/mypage/userorderList?" + query;
//	    	articleUrl = cp+"/mypage/page?page=" + current_page + "&"+ query;
	    }
	    
	    String paging = myUtil.paging(current_page, total_page, listUrl);
	
	    model.addAttribute("searchBar", "mypage");
	    model.addAttribute("list", list);
	//  model.addAttribute("articleUrl", articleUrl);
	    model.addAttribute("page", current_page);
	    model.addAttribute("dataCount", dataCount);
	    model.addAttribute("total_page", total_page);
	    model.addAttribute("paging", paging);
	    
		return ".mypage.userorderList";
	}
	
	@RequestMapping(value="checkReview", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> checkReview(
			@RequestParam int foodOrderNum,
			@RequestParam int restaurantsNum,
			HttpSession session
			) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("user");
		int result = 0;
		String p = "true";
		Map<String, Object> model = new HashMap<>();
		model.put("foodOrderNum", foodOrderNum);
		model.put("restaurantsNum", restaurantsNum);
		model.put("userIdx",info.getUserIdx());
		try {
			result = service.checkReview(model);
			if(result>=1) {
				p = "false";
				model.put("passed", p);
				return model;
			}
			model.put("passed", p);
		} catch (Exception e) {
			p = "false";
			model.put("passed", p);
			return model;
		}
		return model;
	}
	
	// 내 게시물 리스트
	@RequestMapping(value="freelist")
	public String freelist(
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			Model model,
			HttpSession session
			) throws Exception {
	
		SessionInfo info = (SessionInfo)session.getAttribute("user");
		String cp = req.getContextPath();	

		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
			
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userIdx", info.getUserIdx());

		dataCount = service.freeCount(map);
		
		if(dataCount != 0) total_page = myUtil.pageCount(rows,  dataCount) ;

		if(total_page < current_page) current_page = total_page;
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		 
	    List<Mypage> list = service.freelist(map);
	     
	    int listNum = 0;
	    int n = 0;
	    for(Mypage vo : list) {
	         listNum = dataCount - (offset + n);
	         vo.setListNum(listNum);
	         n++;
	     }
		
	    String query = "";
	    String listUrl = cp+"/mypage/freelist";
	    String articleUrl = cp+"/freeboard/page?page=" + current_page;
	    
	    if(query.length()!=0) {
	    	listUrl = cp+"/mypage/freelist?" + query;
	    	articleUrl = cp+"/freeboard/page?page=" + current_page + "&"+ query;
	    }
	    
	    String paging = myUtil.paging(current_page, total_page, listUrl);
	
	    model.addAttribute("searchBar", "mypage");
	    model.addAttribute("list", list);
	    model.addAttribute("articleUrl", articleUrl);
	    model.addAttribute("page", current_page);
	    model.addAttribute("dataCount", dataCount);
	    model.addAttribute("total_page", total_page);
	    model.addAttribute("paging", paging);
	    
		return ".mypage.freelist";
	}
	
	// 내 게시물 리스트
	@RequestMapping(value="recommendlist")
	public String recommendlist(
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			Model model,
			HttpSession session
			) throws Exception {
	
		SessionInfo info = (SessionInfo)session.getAttribute("user");
		String cp = req.getContextPath();	

		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
			
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userIdx", info.getUserIdx());

		dataCount = service.recommendCount(map);
		
		if(dataCount != 0) total_page = myUtil.pageCount(rows,  dataCount) ;

		if(total_page < current_page) current_page = total_page;
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		 
	    List<Mypage> list = service.recommendlist(map);
	     
	    int listNum = 0;
	    int n = 0;
	    for(Mypage vo : list) {
	         listNum = dataCount - (offset + n);
	         vo.setListNum(listNum);
	         n++;
	     }
		
	    String query = "";
	    String listUrl = cp+"/mypage/recommendlist";
	    String articleUrl = cp+"/recommend/page?page=" + current_page;
	    
	    if(query.length()!=0) {
	    	listUrl = cp+"/mypage/recommendlist?" + query;
	    	articleUrl = cp+"/recommend/page?page=" + current_page + "&"+ query;
	    }
	    
	    String paging = myUtil.paging(current_page, total_page, listUrl);
	
	    model.addAttribute("searchBar", "mypage");
	    model.addAttribute("list", list);
	    model.addAttribute("articleUrl", articleUrl);
	    model.addAttribute("page", current_page);
	    model.addAttribute("dataCount", dataCount);
	    model.addAttribute("total_page", total_page);
	    model.addAttribute("paging", paging);
	    
		return ".mypage.recommendlist";
	}
	
	@RequestMapping(value="reviewList")
	public String reviewList(
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			Model model,
			HttpSession session
			) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("user");
		String cp = req.getContextPath();	

		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
			
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userIdx", info.getUserIdx());

		dataCount = service.reviewCount(map);
		
		if(dataCount != 0) total_page = myUtil.pageCount(rows,  dataCount) ;

		if(total_page < current_page) current_page = total_page;
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		 
	    List<Mypage> list = service.reviewlist(map);
	     
	    int listNum = 0;
	    int n = 0;
	    for(Mypage vo : list) {
	         listNum = dataCount - (offset + n);
	         vo.setListNum(listNum);
	         n++;
	     }
		
	    String query = "";
	    String listUrl = cp+"/mypage/reviewList";
	 //   String articleUrl = cp+"/recommend/page?page=" + current_page;
	    
	    if(query.length()!=0) {
	    	listUrl = cp+"/mypage/reviewList?" + query;
	  //  	articleUrl = cp+"/recommend/page?page=" + current_page + "&"+ query;
	    }
	    
	    String paging = myUtil.paging(current_page, total_page, listUrl);
	
	    model.addAttribute("searchBar", "mypage");
	    model.addAttribute("list", list);
	//    model.addAttribute("articleUrl", articleUrl);
	    model.addAttribute("page", current_page);
	    model.addAttribute("dataCount", dataCount);
	    model.addAttribute("total_page", total_page);
	    model.addAttribute("paging", paging);
	    
		return ".mypage.reviewList";
	}

	@RequestMapping(value="delete")
	public String deleteReview(
			@RequestParam int reviewNum,
			@RequestParam String page,
			HttpSession session) throws Exception {
		
		String query= "";
		
		if(query.length()!=0) {		
			query += "page="+page;
		}
		
		SessionInfo info = (SessionInfo)session.getAttribute("user");
		
		Map<String , Object> map = new HashMap<>();
		map.put("reviewNum", reviewNum);
		map.put("userIdx", info.getUserIdx());
		
		service.deleteReview(map);
		
		return "redirect:/mypage/reviewList?"+query;
	}
	
	// 내 문의
	@RequestMapping(value="myInquire")
	public String myInquire(
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			Model model,
			HttpSession session
			) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("user");
		String cp = req.getContextPath();	

		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
			
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userIdx", info.getUserIdx());

		dataCount = service.inquireCount(map);
		if(dataCount != 0) total_page = myUtil.pageCount(rows,  dataCount) ;

		if(total_page < current_page) current_page = total_page;
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		 
	    List<Mypage> list = service.inquirelist(map);
	     
	    int listNum = 0;
	    int n = 0;
	    for(Mypage vo : list) {
	         listNum = dataCount - (offset + n);
	         vo.setListNum(listNum);
	         n++;
	     }
		
	    String query = "";
	    String listUrl = cp+"/mypage/myInquire";
	 //   String articleUrl = cp+"/inquire/page?page=" + current_page;
	    
	    if(query.length()!=0) {
	    	listUrl = cp+"/mypage/myInquire?" + query;
	  //  	articleUrl = cp+"/inquire/page?page=" + current_page + "&"+ query;
	    }
	    
	    String paging = myUtil.paging(current_page, total_page, listUrl);
	
	    model.addAttribute("searchBar", "mypage");
	    model.addAttribute("list", list);
	//    model.addAttribute("articleUrl", articleUrl);
	    model.addAttribute("page", current_page);
	    model.addAttribute("dataCount", dataCount);
	    model.addAttribute("total_page", total_page);
	    model.addAttribute("paging", paging);
	
		return ".mypage.myInquire";
	}
	
	@RequestMapping(value="readOrderDetail",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> readOrderDetail(
			@RequestParam int foodOrderNum,
			HttpSession session) {
		SessionInfo info = (SessionInfo)session.getAttribute("user");
		
		Map<String, Object> map = new HashMap<>();
		map.put("userIdx", info.getUserIdx());
		map.put("foodOrderNum", foodOrderNum);
		
		
		
		Mypage dto = service.orderDetail(map);
		List<Mypage> list = service.orderDetailMenu(map);
		
		
		Map<String , Object> model = new HashMap<>();
		model.put("dto", dto);
		model.put("list", list);
		return model; 
	}
}