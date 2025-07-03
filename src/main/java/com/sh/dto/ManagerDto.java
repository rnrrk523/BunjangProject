package com.sh.dto;

	public class ManagerDto {
		 private int productIdx;
		 private int price;
		 private int jjimCount;
		 private String productImg1;
		 private String  productName;
		 private String saleStartDate;
		 private String saleYn;
		 private int rowNum;
	 public ManagerDto() {}
	public ManagerDto(int productIdx, int price, int jjimCount, String productImg1, String productName,
			String saleStartDate, String saleYn, int rowNum) {
		this.productIdx = productIdx;
		this.price = price;
		this.jjimCount = jjimCount;
		this.productImg1 = productImg1;
		this.productName = productName;
		this.saleStartDate = saleStartDate;
		this.saleYn = saleYn;
		this.rowNum = rowNum;
	}
	
	public int getRowNum() {
		return rowNum;
	}
	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
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
	public int getJjimCount() {
		return jjimCount;
	}
	public void setJjimCount(int jjimCount) {
		this.jjimCount = jjimCount;
	}
	public String getProductImg1() {
		return productImg1;
	}
	public void setProductImg1(String productImg1) {
		this.productImg1 = productImg1;
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
	public String getSaleYn() {
		return saleYn;
	}
	public void setSaleYn(String saleYn) {
		this.saleYn = saleYn;
	}
	
	 
}
