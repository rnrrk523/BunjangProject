package com.sh.dto;

public class BuySellDto {
	private String saleDate;
    private String saleStatus;
    private String productName;
    private int productIdx;
    private int price;
    private String productInfo;
    private String productImg;
    private String storeName;
    private int saleHistoryIdx;
    private int reviewExists;
    private int storeIdx;
    
    public BuySellDto() {}
	public BuySellDto(String saleDate, String saleStatus, String productName, int productIdx, int price,
			String productInfo, String productImg, String storeName, int saleHistoryIdx, int reviewExists,
			int storeIdx) {
		super();
		this.saleDate = saleDate;
		this.saleStatus = saleStatus;
		this.productName = productName;
		this.productIdx = productIdx;
		this.price = price;
		this.productInfo = productInfo;
		this.productImg = productImg;
		this.storeName = storeName;
		this.saleHistoryIdx = saleHistoryIdx;
		this.reviewExists = reviewExists;
		this.storeIdx = storeIdx;
	}

	public String getSaleDate() {
		return saleDate;
	}

	public void setSaleDate(String saleDate) {
		this.saleDate = saleDate;
	}

	public String getSaleStatus() {
		return saleStatus;
	}

	public void setSaleStatus(String saleStatus) {
		this.saleStatus = saleStatus;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getProductIdx() {
		return productIdx;
	}

	public void setProductIdx(int productIdx) {
		this.productIdx = productIdx;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getProductInfo() {
		return productInfo;
	}

	public void setProductInfo(String productInfo) {
		this.productInfo = productInfo;
	}

	public String getProductImg() {
		return productImg;
	}

	public void setProductImg(String productImg) {
		this.productImg = productImg;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public int getSaleHistoryIdx() {
		return saleHistoryIdx;
	}

	public void setSaleHistoryIdx(int saleHistoryIdx) {
		this.saleHistoryIdx = saleHistoryIdx;
	}

	public int getReviewExists() {
		return reviewExists;
	}

	public void setReviewExists(int reviewExists) {
		this.reviewExists = reviewExists;
	}

	public int getStoreIdx() {
		return storeIdx;
	}

	public void setStoreIdx(int storeIdx) {
		this.storeIdx = storeIdx;
	}
}
