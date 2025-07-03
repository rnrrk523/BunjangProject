package com.sh.dto;

public class ProductSearchListDto {
	private int productIdx;
	private String productName;
	private String saleStartDate;
	private String elapsedDate;
	private String productImg;
	private int price;
	private int allCategoryIdx;
	private int middleCategoryIdx;
	private int subCategoryIdx;
	
	public ProductSearchListDto() { }
	public ProductSearchListDto(int productIdx, String productName, String saleStartDate, String elapsedDate,
			String productImg, int price, int allCategoryIdx, int middleCategoryIdx, int subCategoryIdx) {
		this.productIdx = productIdx;
		this.productName = productName;
		this.saleStartDate = saleStartDate;
		this.elapsedDate = elapsedDate;
		this.productImg = productImg;
		this.price = price;
		this.allCategoryIdx = allCategoryIdx;
		this.middleCategoryIdx = middleCategoryIdx;
		this.subCategoryIdx = subCategoryIdx;
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
	public int getAllCategoryIdx() {
		return allCategoryIdx;
	}
	public void setAllCategoryIdx(int allCategoryIdx) {
		this.allCategoryIdx = allCategoryIdx;
	}
	public int getMiddleCategoryIdx() {
		return middleCategoryIdx;
	}
	public void setMiddleCategoryIdx(int middleCategoryIdx) {
		this.middleCategoryIdx = middleCategoryIdx;
	}
	public int getSubCategoryIdx() {
		return subCategoryIdx;
	}
	public void setSubCategoryIdx(int subCategoryIdx) {
		this.subCategoryIdx = subCategoryIdx;
	}
}
