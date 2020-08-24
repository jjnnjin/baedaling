package com.bd.fcnotice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bd.common.FileManager;
import com.bd.common.dao.CommonDAO;

@Service("fcnotice.fcNoticeService")
public class FcNoticeServiceImpl implements FcNoticeService {

	@Autowired
	private CommonDAO dao;

	@Autowired
	private FileManager fileManager;

	@Override
	public void insertNotice(FcNotice dto, String pathname) throws Exception {
		try {
			int seq = dao.selectOne("fcnotice.seq");
			dto.setNum(seq);
			dao.insertData("fcnotice.insertNotice", dto);

			// 파일
			if (!dto.getUpload().isEmpty()) {
				for (MultipartFile mf : dto.getUpload()) {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if (saveFilename == null)
						continue;

					String originalFilename = mf.getOriginalFilename();
					long fileSize = mf.getSize();

					dto.setOriginalFilename(originalFilename);
					dto.setSaveFilename(saveFilename);
					dto.setFileSize(fileSize);

					insertFile(dto);

				}
			}
		} catch (Exception e) {

		}

	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("fcnotice.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<FcNotice> listNotice(Map<String, Object> map) {
		List<FcNotice> list = null;
		try {
			list = dao.selectList("fcnotice.listNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.updateData("fcnotice.updateHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public FcNotice readNotice(int num) {
		FcNotice dto = null;
		try {
			dto = dao.selectOne("fcnotice.readNotice", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public FcNotice preReadNotice(Map<String, Object> map) {
		FcNotice dto = null;
		try {
			dto = dao.selectOne("fcnotice.preReadNotice",map);
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return dto;
	}

	@Override
	public FcNotice nextReadNotice(Map<String, Object> map) {
		FcNotice dto = null;
		
		try {
			dto = dao.selectOne("fcnotice.nextReadNotice",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateNotice(FcNotice dto, String pathname) throws Exception {
		try {
			dao.updateData("fcnotice.updateNotice", dto);
			
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
	public void deleteNotice(int num, String pathname) throws Exception {
		try {
			// 파일 지우기
			List<FcNotice> listFile=listFile(num);
			if(listFile!=null) {
				for(FcNotice dto:listFile) {
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			
			// 파일 테이블 내용 지우기
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("field", "num");
			map.put("num", num);
			deleteFile(map);
			
			dao.deleteData("fcnotice.deleteNotice", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertFile(FcNotice dto) throws Exception {
		try {
			dao.insertData("fcnotice.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

	@Override
	public List<FcNotice> listFile(int num) {
		List<FcNotice> listFile = null;
		try {
			listFile = dao.selectList("fcnotice.listFile", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFile;
	}

	@Override
	public FcNotice readFile(int fileNum) {
		FcNotice dto = null;

		try {
			dto = dao.selectOne("fcnotice.readFile", fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("fcnotice.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<FcNotice> listImpotantNotice() {
		List<FcNotice> list = null;
		try {
			list = dao.selectList("fcnotice.listImportant");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
