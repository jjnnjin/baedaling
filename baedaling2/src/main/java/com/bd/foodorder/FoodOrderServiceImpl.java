package com.bd.foodorder;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bd.common.FileManager;
import com.bd.common.dao.CommonDAO;

@Service("foodorder.foodorderService")
public class FoodOrderServiceImpl implements FoodOrderService{
	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;

	@Override
	public List<FoodOrder> readOrder(Map<String, Object> map) {
		List<FoodOrder> list = null;
		try {
			list = dao.selectList("fo.orderComplete", map);
			
			
			String s="";
			for(FoodOrder vo : list) {
				s="";
				try {
					String s1[] = vo.getSmenuName().split(",");
					String s2[] = vo.getSqty().split(",");
				
					for(int i=0; i<s1.length; i++) {
						s+=s1[i]+"("+s2[i]+") ";
					}
				
					System.out.println(s);
					vo.setSmenuName(s);
				} catch (Exception e) {
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//주문 상태 변경 
	@Override
	public void updateOrderState(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("fo.updateState", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	

	@Override
	public void deleteOrder(int foodorderNum) throws Exception {
		try {
			dao.deleteData("fo.deletedetailOrder", foodorderNum);
			dao.deleteData("fo.deleteOrder", foodorderNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	@Override
	public int orderCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("fo.orderCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	@Override
	public int allorderCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("fo.allorderCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public int todayOrderCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("fo.todayOrderCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}



	//매출
	@Override
	public FoodOrder todaySalesRead(int restaurantsNum) {
		FoodOrder dto = null;
		try {
			dto = dao.selectOne("fo.todaySales", restaurantsNum);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	
	}

	@Override
	public FoodOrder monthlySalesRead(int restaurantsNum) {
		FoodOrder dto = null;
		try {
			dto = dao.selectOne("fo.monthlySales", restaurantsNum);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public FoodOrder annualSalesRead(int restaurantsNum) {
		FoodOrder dto = null;
		try {
			dto = dao.selectOne("fo.annualSales", restaurantsNum);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public List<FoodOrder> bestMenuChart(int restaurantsNum) {
		List<FoodOrder> list = null;
		try {
			list = dao.selectList("fo.monthlyBest", restaurantsNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	@Override
	public List<FoodOrder> todayBestMenu(int restaurantsNum) {
		List<FoodOrder> list = null;
		try {
			list = dao.selectList("fo.todayBest", restaurantsNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	

	@Override
	public Map<String,Object> montlyChart(int restaurantsNum) {
		Map<String, Object> map = null;
		try {
			map= dao.selectOne("fo.monthlySalesChart", restaurantsNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	
	@Override
	public Map<String, Object> reviewChart(int restaurantsNum) {
		Map<String, Object> map = null;
		try {
			map= dao.selectOne("fo.monthlyReviewChart", restaurantsNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	
	@Override
	public List<FoodOrder> allList(Map<String, Object> map) {
		List<FoodOrder> list = null;
		try {
			list = dao.selectList("fo.allOrderList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	
//가맹점 정보 
	
	@Override
	public FoodOrder readInfo(int restaurantsNum) {
		FoodOrder dto = null;
		try {
			dto=dao.selectOne("fo.readInfo", restaurantsNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}



	@Override
	public List<FoodOrder> listFile(int restaurantsNum) {
		List<FoodOrder> listFile = null;
		try {
			listFile=dao.selectList("fo.fcFileList", restaurantsNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFile;
	}

	@Override
	public void updateInfo(FoodOrder dto, String pathname) {
		int i = 1;
		try {
			dao.updateData("fo.updateInfo", dto);
			
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) { 
					String saveFilename=fileManager.doFileUpload(mf, pathname);
					if(saveFilename==null) continue;
					
					dto.setSaveFilename(saveFilename);
					dto.setSeparate(i);
					insertFile(dto);
					i++;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	@Override
	public void updateFcState(FoodOrder dto) throws Exception {
		try {
			dao.updateData("fo.updateFcState", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	@Override
	public void insertFile(FoodOrder dto) throws Exception {
		try {
			dao.insertData("fo.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	
	public void deleteFile(Map<String, Object> map) throws Exception{
		try {
			dao.deleteData("fo.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e; 
		}
	}

	@Override
	public FoodOrder readFile(int fileNum) {
		FoodOrder dto = null;
		try {
			dto =dao.selectOne("fo.readFile", fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public List<FoodOrder> reviewList(Map<String, Object> map) {
		List<FoodOrder> list = null;
		try {
			list =dao.selectList("fo.reviewList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int reviewCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("fo.reviewCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
				
		return result;
	}

	@Override
	public List<FoodOrder> replyList(Map<String, Object> map) {
		List<FoodOrder> list = null;
		try {
			list =dao.selectList("fo.replyList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<FoodOrder> reply(Map<String, Object> map) {
		List<FoodOrder> list = null;
		try {
			list =dao.selectList("fo.reply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	
	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("fo.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
				
		return result;
	}

	@Override
	public FoodOrder reviewRead(int reviewNum) {
		FoodOrder dto = null;
		try {
			dto = dao.selectOne("fo.reviewRead", reviewNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void insertReply(FoodOrder dto) throws Exception {
		
		try {
			dao.updateData("fo.updateReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public FoodOrder readRestaurant(int restaurantsNum) {
		FoodOrder dto = null;
		try {
			dto = dao.selectOne("fo.readRestaurant", restaurantsNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateRestaurant(FoodOrder dto) {
		try {
			dao.updateData("fo.updateRestaurant",dto);
			dao.updateData("fo.updateRestaurantInfo",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void updateCompleteDate(int foodorderNum) throws Exception {
		try {
			dao.updateData("fo.updateCompleteDate", foodorderNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}



	


	



	
	
	


	

	
}
