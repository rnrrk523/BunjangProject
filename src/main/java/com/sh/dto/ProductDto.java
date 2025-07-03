package com.sh.dto;

public class ProductDto {
	private int productIdx;
	private int price;
	private String productName;
	private String productImg;
    private String startDate;
    private int categoryIdx;
    private String categoryName;
    public ProductDto() {}
	public ProductDto(int productIdx, int price, String productName, String productImg, String startDate,
			int categoryIdx, String categoryName) {
		this.productIdx = productIdx;
		this.price = price;
		this.productName = productName;
		this.productImg = productImg;
		this.startDate = startDate;
		this.categoryName = categoryName;
		this.categoryIdx = categoryIdx;
	}
	
	public int getCategoryIdx() {
		return categoryIdx;
	}
	public void setCategoryIdx(int categoryIdx) {
		this.categoryIdx = categoryIdx;
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
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductImg() {
		return productImg;
	}
	public void setProductImg(String productImg) {
		this.productImg = productImg;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
    
}
