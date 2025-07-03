package com.sh.dto;

public class StoreInfoDto {
	private int storeIdx;			// idx
	private String storeName;		// 이름
	private String introduction;	// 소개글
	private String openDate;		// 개설일
	private String elapsedDate;		// 오픈 경과 날짜
	private int productCnt;			// 상품 수
	private int followCnt;			// 팔로우수
	
	public StoreInfoDto() { }
	public StoreInfoDto(int storeIdx, String storeName, String introduction, String openDate, String elapsedDate,
			int productCnt, int followCnt) {
		this.storeIdx = storeIdx;
		this.storeName = storeName;
		this.introduction = introduction;
		this.openDate = openDate;
		this.elapsedDate = elapsedDate;
		this.productCnt = productCnt;
		this.followCnt = followCnt;
	}
	
	public int getStoreIdx() {
		return storeIdx;
	}
	public void setStoreIdx(int storeIdx) {
		this.storeIdx = storeIdx;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public String getOpenDate() {
		return openDate;
	}
	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}
	public String getElapsedDate() {
		return elapsedDate;
	}
	public void setElapsedDate(String elapsedDate) {
		this.elapsedDate = elapsedDate;
	}
	public int getProductCnt() {
		return productCnt;
	}
	public void setProductCnt(int productCnt) {
		this.productCnt = productCnt;
	}
	public int getFollowCnt() {
		return followCnt;
	}
	public void setFollowCnt(int followCnt) {
		this.followCnt = followCnt;
	}
}
