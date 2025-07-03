package com.sh.dto;

public class InsertProductDto {
	private Integer storeIdx;
    private String productName;
    private Integer price;
    private String productImg1;
    private String productImg2;
    private String productImg3;
    private Integer allCategoryIdx;
    private Integer middleCategoryIdx;
    private Integer subCategoryIdx;
    private String productSize;
    private String productInfo;
    private String productState;
    public InsertProductDto() {}
	public InsertProductDto(Integer storeIdx, String productName, Integer price, String productImg1, String productImg2,
			String productImg3, Integer allCategoryIdx, Integer middleCategoryIdx, Integer subCategoryIdx,
			String productSize, String productInfo, String productState) {
		super();
		this.storeIdx = storeIdx;
		this.productName = productName;
		this.price = price;
		this.productImg1 = productImg1;
		this.productImg2 = productImg2;
		this.productImg3 = productImg3;
		this.allCategoryIdx = allCategoryIdx;
		this.middleCategoryIdx = middleCategoryIdx;
		this.subCategoryIdx = subCategoryIdx;
		this.productSize = productSize;
		this.productInfo = productInfo;
		this.productState = productState;
	}

	public Integer getStoreIdx() {
		return storeIdx;
	}
	public void setStoreIdx(Integer storeIdx) {
		this.storeIdx = storeIdx;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public String getProductImg1() {
		return productImg1;
	}
	public void setProductImg1(String productImg1) {
		this.productImg1 = productImg1;
	}
	public String getProductImg2() {
		return productImg2;
	}
	public void setProductImg2(String productImg2) {
		this.productImg2 = productImg2;
	}
	public String getProductImg3() {
		return productImg3;
	}
	public void setProductImg3(String productImg3) {
		this.productImg3 = productImg3;
	}
	public Integer getAllCategoryIdx() {
		return allCategoryIdx;
	}
	public void setAllCategoryIdx(Integer allCategoryIdx) {
		this.allCategoryIdx = allCategoryIdx;
	}
	public Integer getMiddleCategoryIdx() {
		return middleCategoryIdx;
	}
	public void setMiddleCategoryIdx(Integer middleCategoryIdx) {
		this.middleCategoryIdx = middleCategoryIdx;
	}
	public Integer getSubCategoryIdx() {
		return subCategoryIdx;
	}
	public void setSubCategoryIdx(Integer subCategoryIdx) {
		this.subCategoryIdx = subCategoryIdx;
	}
	public String getProductSize() {
		return productSize;
	}
	public void setProductSize(String productSize) {
		this.productSize = productSize;
	}
	public String getProductInfo() {
		return productInfo;
	}
	public void setProductInfo(String productInfo) {
		this.productInfo = productInfo;
	}
	public String getProductState() {
		return productState;
	}
	public void setProductState(String productState) {
		this.productState = productState;
	}
    
}
