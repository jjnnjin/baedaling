package com.bd.recommend;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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


@Controller("recommend.recommendBoardController")
@RequestMapping("/recommend/*")
public class RecommendController {
	@Autowired
	private RecommendService service;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping("/list")
	public String list(
			@RequestParam(value="page",defaultValue="1") int on_page,
			@RequestParam(defaultValue="any") String category,
			@RequestParam(defaultValue="") String key,
			HttpServletRequest req,
			Model model
			) throws Exception {
		int shownum = 10;
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			key = URLDecoder.decode(key,"utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("category", category);
		map.put("key", key);
		
		dataCount = service.dataCount(map);
		if(dataCount!=0) {
			total_page = myUtil.pageCount(shownum, dataCount);
		}
		
		if(total_page<on_page) {
			on_page  = total_page;
		}
		int offset = (on_page-1) * shownum;
		if(offset<0) {
			offset = 0;
		}
		map.put("offset", offset);
		map.put("shownum", shownum);
		
		List<Recommend> list = service.listRecommend(map);
		int listnum = 0;
		int n = 0; 
		for(Recommend dto : list) {
			listnum = dataCount - (offset+n);
			dto.setListNum(listnum);
			n++;
		}
		
		String cp = req.getContextPath();
		String query = "";
		String listUrl = cp+"/recommend/list";
		String pageUrl = cp+"/recommend/page?page="+on_page;
		if(key.length()!=0) {
			query = "category="+category+"&key="+URLEncoder.encode(key,"utf-8");
		}
		
		if(query.length()!=0) {
			listUrl = cp+"/recommend/list?"+query;
			pageUrl = cp+"/recommend/page?page="+on_page+"&"+query;
		}
		
		String paging = myUtil.paging(on_page, total_page, listUrl);
		
		model.addAttribute("searchBar","recommendBoard");
		model.addAttribute("list", list);
		model.addAttribute("page", on_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);		
		model.addAttribute("pageUrl", pageUrl);
		model.addAttribute("category", category);
		model.addAttribute("key", key);
		return ".recommendboard.list";
	}
	
	@RequestMapping(value="write", method=RequestMethod.GET)
	public String insertForm(
			Model model
			) {
		model.addAttribute("state","write");
		return ".recommendboard.write";
	}
	
	@RequestMapping(value="write", method=RequestMethod.POST)
	public String insertSubmit(
			Recommend dto,
			HttpSession session
			) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("user");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"resource"+File.separator+"recommendboard";
		try {
			dto.setUserId(info.getUserId());
			dto.setUserName(info.getUserName());
			dto.setUserIdx(info.getUserIdx());
			service.writeRecommend(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/recommend/list";
	}
	
	@RequestMapping(value="page")
	public String readpage(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="any") String category,
			@RequestParam(defaultValue="") String key,
			Model model
			) throws Exception {
		key = URLDecoder.decode(key, "utf-8");
		String query="page="+page;
		if(key.length()!=0) {
			query+="&category="+category+"&key="+URLEncoder.encode(key, "UTF-8");
		}
		
		service.updateHitCount(num);
		
		Recommend dto = service.readPage(num);
		if(dto==null) {
			return "redirect:/recommend/list?"+query;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("category", category);
		map.put("key", key);
		map.put("num", num);
		
		Recommend preReadDto = service.preReadRecommend(map);
		Recommend nextReadDto = service.nextReadRecommend(map);
        
		List<Recommend> listFile=service.listFile(num);
		
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".recommendboard.page";
	}
	
	@RequestMapping(value="download")
	public void download(
			@RequestParam int fileNum,
			HttpServletResponse resp,
			HttpSession session
			)throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "resource" + File.separator + "recommendboard";
		boolean b = false;
		
		Recommend dto = service.readFile(fileNum);
		if(dto!=null) {
			String saveFilename = dto.getSaveFilename();
			String originalFilename = dto.getOriginalFilename();
			
			b = fileManager.doFileDownload(saveFilename, originalFilename, pathname, resp);
		}
		if(!b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>");
			} catch (Exception e) {
				throw e;
			}
		}
	}
	
	@RequestMapping(value="delete")
	public String delete(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam (defaultValue="any") String category,
			@RequestParam (defaultValue="") String key,
			HttpSession session
			) throws Exception {
		key = URLDecoder.decode(key, "utf-8");
		String query="page="+page;
		if(key.length()!=0) {
			query+="&category="+category+"&key="+URLEncoder.encode(key, "UTF-8");
		}
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "resource" + File.separator + "recommendboard";
			service.deleteRecommend(num,pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/recommend/list?"+query;
	}
	
	@RequestMapping(value="deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(
			@RequestParam int fileNum,
			HttpSession session
			) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "resource" + File.separator + "recommendboard";
		
		Recommend dto=service.readFile(fileNum);
		if(dto!=null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("field", "fileNum");
		map.put("num", fileNum);
		service.deleteFile(map);
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", "true");
		return model;
	}
	
	@RequestMapping(value="insertRecommendLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertRecommendLike(
			@RequestParam int num,
			HttpSession session
			) {
		String state="true";
		int recommendLikeCount=0;
		SessionInfo info=(SessionInfo)session.getAttribute("user");
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("num", num);
		paramMap.put("userId", info.getUserId());
		paramMap.put("userIdx", info.getUserIdx());
		try {
			service.insertRecommendLike(paramMap);
		} catch (Exception e) {
			state="false";
		}
			
		recommendLikeCount = service.recommendLikeCount(num);
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		model.put("recommendLikeCount", recommendLikeCount);
		
		return model;
	}
	
	@RequestMapping(value="insertReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(
			RecommendReply dto,
			HttpSession session
			) {
		SessionInfo info=(SessionInfo)session.getAttribute("user");
		String state="true";
		
		try {
			dto.setUserId(info.getUserId());
			dto.setUserName(info.getUserName());
			dto.setUserIdx(info.getUserIdx());
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
			@RequestParam int num,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model
			) throws Exception {
		
		int rows=5;
		int total_page=0;
		int dataCount=0;
		Map<String, Object> map=new HashMap<>();
		map.put("num", num);
		
		dataCount=service.replyCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
		List<RecommendReply> listReply=service.listReply(map);
		
		for(RecommendReply dto : listReply) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		// AJAX 용 페이징
		String paging=myUtil.pagingMethod(current_page, total_page, "listPage");
		
		// 포워딩할 jsp로 넘길 데이터
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "/recommendboard/listReply";
	}
	
	@RequestMapping(value="deleteReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(
			@RequestParam Map<String, Object> paramMap
			) {
		
		String state="true";
		try {
			service.deleteReply(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("state", state);
		return map;
	}
	
	@RequestMapping(value="update", method = RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam String page,
			Model model
			) throws Exception{
		Recommend dto = service.readPage(num);
		if(dto == null) {
			return "redirect:/recomend/list";
		}
		List<Recommend> listFile = service.listFile(num);
		
		model.addAttribute("state","update");
		model.addAttribute("page",page);
		model.addAttribute("dto",dto);
		model.addAttribute("listFile",listFile);
		
		
		
		return ".recommendboard.write";
	}
	
	@RequestMapping(value="update",method=RequestMethod.POST)
	public String updateSubmit(Recommend dto,
			@RequestParam String page,
			HttpSession session) {
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "resource" + File.separator + "recommendboard";

			service.updateRecommend(dto, pathname);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/recommend/list?page=" + page;
	}
}
