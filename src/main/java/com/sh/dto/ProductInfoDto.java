package com.sh.dto;

public class ProductInfoDto {
	private int productIdx;
	private int storeIdx;
	private String productName;
	private int price;
	private String productImg1;		// 대표이미지
	private String productImg2;
	private String productImg3;
	private int allCategoryIdx;		// 대분류 카테고리
	private int middleCategoryIdx;	// 중분류 카테고리
	private int subCategoryIdx;		// 소분류 카테고리
	private String saleYN;			// 판매여부
	private String productSize;
	private String elapsedDate;		// 판매 시작 경과일
	private String productInfo;
	private String productState;	// 상품 상태
	private int jjimCnt;			// 찜 수
	private int checkCnt;			// 조회 수
	private String jjimYN;			// 찜 여부
	
	public ProductInfoDto() { }
	public ProductInfoDto(int productIdx, int storeIdx, String productName, int price, String productImg1,
			String productImg2, String productImg3, int allCategoryIdx, int middleCategoryIdx, int subCategoryIdx,
			String saleYN, String productSize, String elapsedDate, String productInfo, String productState, int jjimCnt,
			int checkCnt, String jjimYN) {
		this.productIdx = productIdx;
		this.storeIdx = storeIdx;
		this.productName = productName;
		this.price = price;
		this.productImg1 = productImg1;
		this.productImg2 = productImg2;
		this.productImg3 = productImg3;
		this.allCategoryIdx = allCategoryIdx;
		this.middleCategoryIdx = middleCategoryIdx;
		this.subCategoryIdx = subCategoryIdx;
		this.saleYN = saleYN;
		this.productSize = productSize;
		this.elapsedDate = elapsedDate;
		this.productInfo = productInfo;
		this.productState = productState;
		this.jjimCnt = jjimCnt;
		this.checkCnt = checkCnt;
		this.jjimYN = jjimYN;
	}
	
	public int getProductIdx() {
		return productIdx;
	}
	public void setProductIdx(int productIdx) {
		this.productIdx = productIdx;
	}
	public int getStoreIdx() {
		return storeIdx;
	}
	public void setStoreIdx(int storeIdx) {
		this.storeIdx = storeIdx;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
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
	public String getSaleYN() {
		return saleYN;
	}
	public void setSaleYN(String saleYN) {
		this.saleYN = saleYN;
	}
	public String getProductSize() {
		return productSize;
	}
	public void setProductSize(String productSize) {
		this.productSize = productSize;
	}
	public String getElapsedDate() {
		return elapsedDate;
	}
	public void setElapsedDate(String elapsedDate) {
		this.elapsedDate = elapsedDate;
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
	public int getJjimCnt() {
		return jjimCnt;
	}
	public void setJjimCnt(int jjimCnt) {
		this.jjimCnt = jjimCnt;
	}
	public int getCheckCnt() {
		return checkCnt;
	}
	public void setCheckCnt(int checkCnt) {
		this.checkCnt = checkCnt;
	}
	public String getJjimYN() {
		return jjimYN;
	}
	public void setJjimYN(String jjimYN) {
		this.jjimYN = jjimYN;
	}
}