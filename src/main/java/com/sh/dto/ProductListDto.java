package com.sh.dto;

public class ProductListDto {
	private int productIdx;
	private String productName;
	private String saleStartDate; // 판매시작일
	private String elapsedDate;	// 판매 시작 경과일
	private String productImg; // 대표 이미지
	private int price;
	
	public ProductListDto() { }
	public ProductListDto(int productIdx, String productName, String saleStartDate, String elapsedDate,
			String productImg, int price) {
		this.productIdx = productIdx;
		this.productName = productName;
		this.saleStartDate = saleStartDate;
		this.elapsedDate = elapsedDate;
		this.productImg = productImg;
		this.price = price;
	}
	
	public int getProductIdx() {
		return productIdx;
	}
	public void setProductIdx(int productIdx) {
		this.productIdx = productIdx;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getSaleStartDate() {
		return saleStartDate;
	}
	public void setSaleStartDate(String saleStartDate) {
		this.saleStartDate = saleStartDate;
	}
	public String getElapsedDate() {
		return elapsedDate;
	}
	public void setElapsedDate(String elapsedDate) {
		this.elapsedDate = elapsedDate;
	}
	public String getProductImg() {
		return productImg;
	}
	public void setProductImg(String productImg) {
		this.productImg = productImg;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
}
