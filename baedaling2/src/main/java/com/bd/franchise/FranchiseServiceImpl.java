package com.bd.franchise;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.bouncycastle.crypto.modes.EAXBlockCipher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bd.common.dao.CommonDAO;

import sun.print.resources.serviceui;

@Service("franchise.franchiseService")
public class FranchiseServiceImpl implements FranchiseService {
	@Autowired
	private CommonDAO dao;

	@Override
	public Franchise readBoard(int restaurantsNum) {
		Franchise dto = null;
		try {
			dto = dao.selectOne("fc.readBoard", restaurantsNum);
			String titleimg = dao.selectOne("fc.readimage1", restaurantsNum);
			String bannerimg = dao.selectOne("fc.readimage2", restaurantsNum);
			dto.setTitleimg(titleimg);
			dto.setBannerimg(bannerimg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public List<FranchiseMenu> listMenu(int restaurantsNum) {
		List<FranchiseMenu> list = null;
		try {
			list = dao.selectList("fc.listMenu",restaurantsNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<FranchiseMenu> listCategory() {
		List<FranchiseMenu> list = null;
		try {
			list = dao.selectList("fc.listCategory");
		} catch (Exception e) {
			
		}
		return list;
	}

	

	@Override
	public List<FranchiseMenu> detailList(Map<String, Object> map) {
		List<FranchiseMenu> list = null;
		try {
			list = dao.selectList("fc.detailMenu",map);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return list;
	}

	@Override
	public FranchiseMenu readMenu(int menuNum) {
		FranchiseMenu dto = null;
		try {
			dto = dao.selectOne("fc.readMenu",menuNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void insertOrder(Franchise dto) throws Exception {
		int req = 0;
		try {
			req = dao.selectOne("fc.orderseq");
			dto.setFoodordernum(req);
			dao.insertData("fc.insertorder", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertorderdetail(Franchise dto) throws Exception {
		int req = 0;
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("foodordernum", dto.getFoodordernum());
			for(int i=0; i<dto.getMenuNum().size(); i++) {
				req = dao.selectOne("fc.detailseq");
				map.put("orderdetailnum", req);
				map.put("menunum", dto.getMenuNum().get(i));
				map.put("qty",dto.getQuantity().get(i));
				map.put("orderoneprice", dto.getEachprice().get(i));
				dao.insertData("fc.insertdetailorder", map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Franchise readMenuPrice(Franchise adto) {
		Franchise dto = adto;
		try {
			int i = 0;
			int totalprice = 0;
			List<Integer> list = new ArrayList<Integer>(); 
			for(int menunum :dto.getMenuNum()) {
				int price = dao.selectOne("fc.readmenuprice",menunum);
				int eachprice = price * (dto.getQuantity().get(i++));
				totalprice =  totalprice + eachprice;
				list.add(eachprice);
			}
			dto.setFoodordertotalprice(totalprice);
			dto.setFoodorderpay(totalprice);
			dto.setEachprice(list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	
	@Override
	public List<FranchiseReview> listReview(Map<String, Object> map) {
		List<FranchiseReview> list = null;
		try {
			list = dao.selectList("fc.reviewList",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int reviewCount(int restaurantsNum) {
		int result = 0;
		try {
			result = dao.selectOne("fc.reviewCount", restaurantsNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public double aveStarCount(int restaurantsNum) {
		double result = 0.0;
		try {
			result = dao.selectOne("fc.aveStarCount", restaurantsNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int reviewReplyCount(int restaurantsNum) {
		int result = 0;
		try {
			result = dao.selectOne("fc.reviewReplyCount", restaurantsNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	

}
