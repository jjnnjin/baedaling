package com.bd.freeboard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bd.common.FileManager;
import com.bd.common.dao.CommonDAO;

@Service("freeBoard.freeBoardService")
public class FreeBoardServiceImpl implements FreeBoardService{
	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertBoard(FreeBoard dto, String pathname) throws Exception {
		try {
			int seq = dao.selectOne("fb.seq");
			dto.setNum(seq);

			dao.insertData("fb.insertFreeboard",dto);
			
			//파일 
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename==null) continue;
					
					String originalFilename = mf.getOriginalFilename();
					long fileSize = mf.getSize();
					
					dto.setOriginalFilename(originalFilename);
					dto.setSaveFilename(saveFilename);
					dto.setFileSize(fileSize);
					
					insertFile(dto);
					
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<FreeBoard> listBoard(Map<String, Object> map) {
		List<FreeBoard> list=null;

		try {
			list=dao.selectList("fb.listFreeboard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("fb.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public FreeBoard readBoard(int num) {
		FreeBoard dto = null; 
		int cnt = 0; 
		try {
			dto = dao.selectOne("fb.readFreeBoard", num);
			cnt = dao.selectOne("fb.boardLikeCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.updateData("fb.updateHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e; 
		}
	}

	@Override
	public FreeBoard preReadBoard(Map<String, Object> map) {
		FreeBoard dto = null;
		try {
			dto =dao.selectOne("fb.preReadBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public FreeBoard nextReadBoard(Map<String, Object> map) {
		FreeBoard dto = null;
		try {
			dto =dao.selectOne("fb.nextReadBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateBoard(FreeBoard dto, String pathname) throws Exception {
		try {
			dao.updateData("fb.updateFreeboard", dto);
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) { 
					String saveFilename=fileManager.doFileUpload(mf, pathname);
					if(saveFilename==null) continue;
					
					String originalFilename=mf.getOriginalFilename();
					long fileSize=mf.getSize();
					
					dto.setOriginalFilename(originalFilename);
					dto.setSaveFilename(saveFilename);
					dto.setFileSize(fileSize);
					
					insertFile(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		
	}

	@Override
	public void deleteBoard(int num, String pathname) throws Exception {
		try {
			List<FreeBoard> listFile = listFile(num);
			if(listFile!=null) {
				for(FreeBoard dto : listFile) {
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "num");
			map.put("num", num);
			deleteFile(map);
			
			dao.deleteData("fb.deleteFreeBoard", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}				
	}

	@Override
	public void insertBoardLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("fb.insertBoardLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}				
	}

	@Override
	public int boardLikeCount(int num) {
		int result = 0;
		try {
			result = dao.selectOne("fb.boardLikeCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("fb.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}				
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null; 
		try {
			list =dao.selectList("fb.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("fb.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}				
	}

	@Override
	public void insertFile(FreeBoard dto) throws Exception {
		try {
			dao.insertData("fb.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}				
	}

	@Override
	public List<FreeBoard> listFile(int num) {
		List<FreeBoard> listFile=null;
		
		try {
			listFile=dao.selectList("fb.listFile", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listFile;
	}

	@Override
	public FreeBoard readFile(int fileNum) {
		FreeBoard dto = null;
		try {
			dto= dao.selectOne("fb.readFile", fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("fb.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}				
	}

}
