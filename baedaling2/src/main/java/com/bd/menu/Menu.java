package com.bd.menu;

import org.springframework.web.multipart.MultipartFile;

public class Menu {

	private int listNum;
	private int menuNum;
	private String menuName;
	private int menuPrice;
	private String origin;
	private int enabled;
	private String menuInfo;
	private int menuCategoryNum;
	private String menuCategoryName;
	private MultipartFile upload;
	private String saveFilename;
	private String originalFilename;
	private int restaurantsNum;
	private int userIdx;
	
	
	
	public int getUserIdx() {
		return userIdx;
	}

	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}

	public int getRestaurantsNum() {
		return restaurantsNum;
	}

	public void setRestaurantsNum(int restaurantsNum) {
		this.restaurantsNum = restaurantsNum;
	}

	public String getSaveFilename() {
		return saveFilename;
	}

	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}

	public String getOriginalFilename() {
		return originalFilename;
	}

	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}

	public MultipartFile getUpload() {
		return upload;
	}

	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}

	public int getListNum() {
		return listNum;
	}

	public void setListNum(int listNum) {
		this.listNum = listNum;
	}

	public int getMenuNum() {
		return menuNum;
	}

	public void setMenuNum(int menuNum) {
		this.menuNum = menuNum;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public int getMenuPrice() {
		return menuPrice;
	}

	public void setMenuPrice(int menuPrice) {
		this.menuPrice = menuPrice;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public int getEnabled() {
		return enabled;
	}

	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}

	public String getMenuInfo() {
		return menuInfo;
	}

	public void setMenuInfo(String menuInfo) {
		this.menuInfo = menuInfo;
	}

	public int getMenuCategoryNum() {
		return menuCategoryNum;
	}

	public void setMenuCategoryNum(int menuCategoryNum) {
		this.menuCategoryNum = menuCategoryNum;
	}

	public String getMenuCategoryName() {
		return menuCategoryName;
	}

	public void setMenuCategoryName(String menuCategoryName) {
		this.menuCategoryName = menuCategoryName;
	}

	
}
