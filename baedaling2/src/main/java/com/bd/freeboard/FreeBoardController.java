package com.bd.freeboard;

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

@Controller("free.freeBoardController")
@RequestMapping("/freeboard/*")
public class FreeBoardController {
	@Autowired
	private FreeBoardService service;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;
	
	
	@RequestMapping("list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception {
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

        List<FreeBoard> list = service.listBoard(map);
        
        int listNum =0;
        int n = 0;
        for(FreeBoard dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
        
        String query = "";
        String listUrl = cp+"/freeboard/list";
        String articleUrl = cp+"/freeboard/page?page=" + current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/freeboard/list?" + query;
        	articleUrl = cp+"/freeboard/page?page=" + current_page + "&"+ query;
        }
        
        String paging = myUtil.paging(current_page, total_page, listUrl);

        model.addAttribute("list", list);
        model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		model.addAttribute("searchBar","freeboard");
		
		return ".freeboard.list";
	}
	
	
	@RequestMapping(value="write", method=RequestMethod.GET)
	public String writeForm(
			Model model
			) throws Exception {

		model.addAttribute("mode", "write");
		return ".freeboard.write";
	}

	@RequestMapping(value="write", method=RequestMethod.POST)
	public String writeSubmit(
			FreeBoard dto,
			HttpSession session) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("user");
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "resource" + File.separator + "freeBoard";		
			
			dto.setUserId(info.getUserId());
			dto.setUserName(info.getUserName());
			dto.setUseridx(info.getUserIdx());
			service.insertBoard(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/freeboard/list";
	}
	
	
	@RequestMapping(value="page")
	public String page(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model) throws Exception{
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}

		service.updateHitCount(num);

		FreeBoard dto = service.readBoard(num);
		if(dto==null)
			return "redirect:/freeboard/list?"+query;
        
		// 이전 글, 다음 글
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", num);

		FreeBoard preReadDto = service.preReadBoard(map);
		FreeBoard nextReadDto = service.nextReadBoard(map);
        
		//파일 
		List<FreeBoard> listFile = service.listFile(num);
		
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".freeboard.page";
	}
	
	@RequestMapping(value="delete")
	public String delete(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"resource"+File.separator+"freeboard";
		service.deleteBoard(num, pathname);
		
		return "redirect:/freeboard/list?"+query;
	}
	
	
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session,			
			Model model	) throws Exception {
//		SessionInfo info=(SessionInfo)session.getAttribute("user");
		
//		if(! info.getUserId().equals("admin")) {
//			return "redirect:/freeboard/list?page="+page;
//		}

		FreeBoard dto = service.readBoard(num);
		if(dto==null) {
			return "redirect:/freeboard/list?page="+page;
		}
		
		List<FreeBoard> listFile=service.listFile(num);
			
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		
		return ".freeboard.write";
	}
	
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			FreeBoard dto,
			@RequestParam String page,
			HttpSession session) throws Exception {

//		SessionInfo info=(SessionInfo)session.getAttribute("user");
//		if(! info.getUserId().equals("admin")) {
//			return "redirect:/freeboard/list?page="+page;
//		}
		
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + File.separator + "resource" + File.separator + "freeboard";		
			
	//		dto.setUserId(info.getUserId());
			service.updateBoard(dto, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/freeboard/list?page="+page;
	}
	
	
	
	@RequestMapping(value="deleteFile",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(
			@RequestParam int fileNum,
			HttpSession session
			) throws Exception {
//		SessionInfo info=(SessionInfo)session.getAttribute("user");
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"resource"+File.separator+"freeboard";
		
		FreeBoard dto=service.readFile(fileNum);
		if(dto!=null) {
			fileManager.doFileDelete(dto.getSaveFilename(),pathname);
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("field", "fileNum");
		map.put("num", fileNum);
		service.deleteFile(map);
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", "true");
		return model;
	
	}
	
	@RequestMapping(value="insertBoardLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertBoardLike(
			@RequestParam int num,
			HttpSession session 
			){
		String state="true";
		int boardLikeCount=0;
		SessionInfo info=(SessionInfo)session.getAttribute("user");
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("num", num);
		paramMap.put("userIdx", info.getUserIdx());
		
		try {
			service.insertBoardLike(paramMap);
		} catch (Exception e) {
			e.printStackTrace();
			state="false";
		}
			
		boardLikeCount = service.boardLikeCount(num);
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		model.put("boardLikeCount", boardLikeCount);
		
		return model;
	}
	
	
	
	@RequestMapping(value="insertReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(
			Reply dto,
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
		List<Reply> listReply=service.listReply(map);
		
		for(Reply dto : listReply) {
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
		
		return "/freeboard/listReply";
	}

	
	
	@RequestMapping(value="download")
	public void download(
			@RequestParam int fileNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "resource" + File.separator + "freeboard";

		boolean b = false;
		
		FreeBoard dto = service.readFile(fileNum);
		if(dto!=null) {
			String saveFilename = dto.getSaveFilename();
			String originalFilename = dto.getOriginalFilename();
			
			b = fileManager.doFileDownload(saveFilename, originalFilename, pathname, resp);
		}
		
		if (!b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다.');history.back();</script>");
			} catch (Exception e) {
				throw e;
			}
		}
	}
	
	@RequestMapping(value="zipdownload")
	public void zipdownload(
			@RequestParam int num,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "resource" + File.separator + "freeboard";

		boolean b = false;
		
		List<FreeBoard> listFile = service.listFile(num);
		if(listFile.size()>0) {
			String []sources = new String[listFile.size()];
			String []originals = new String[listFile.size()];
			String zipFilename = num+".zip";
			
			for(int idx = 0; idx<listFile.size(); idx++) {
				sources[idx] = pathname+File.separator+listFile.get(idx).getSaveFilename();
				originals[idx] = File.separator+listFile.get(idx).getOriginalFilename();
			}
			
			b = fileManager.doZipFileDownload(sources, originals, zipFilename, resp);
		}
		
		if (!b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다.');history.back();</script>");
			} catch (Exception e) {
			}
		}
	}

	
	

}

