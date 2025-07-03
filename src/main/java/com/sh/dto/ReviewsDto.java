package com.sh.dto;

public class ReviewsDto {
	private int targetStoreIdx;
	private int writerIdx;
	private int productIdx;
	private int startCnt;
	private String writerStoreName;
	private String profileImg;
	private String productName;
	private String reviewText;
	private String reviewDate;
	
	public ReviewsDto() {}
	public ReviewsDto(int targetStoreIdx, int writerIdx, int productIdx, int startCnt, String writerStoreName,
			String profileImg, String productName, String reviewText, String reviewDate) {
		this.targetStoreIdx = targetStoreIdx;
		this.writerIdx = writerIdx;
		this.productIdx = productIdx;
		this.startCnt = startCnt;
		this.writerStoreName = writerStoreName;
		this.profileImg = profileImg;
		this.productName = productName;
		this.reviewText = reviewText;
		this.reviewDate = reviewDate;
	}
	public int getTargetStoreIdx() {
		return targetStoreIdx;
	}
	public void setTargetStoreIdx(int targetStoreIdx) {
		this.targetStoreIdx = targetStoreIdx;
	}
	public int getWriterIdx() {
		return writerIdx;
	}
	public void setWriterIdx(int writerIdx) {
		this.writerIdx = writerIdx;
	}
	public int getProductIdx() {
		return productIdx;
	}
	public void setProductIdx(int productIdx) {
		this.productIdx = productIdx;
	}
	public int getStartCnt() {
		return startCnt;
	}
	public void setStartCnt(int startCnt) {
		this.startCnt = startCnt;
	}
	public String getWriterStoreName() {
		return writerStoreName;
	}
	public void setWriterStoreName(String writerStoreName) {
		this.writerStoreName = writerStoreName;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getReviewText() {
		return reviewText;
	}
	public void setReviewText(String reviewText) {
		this.reviewText = reviewText;
	}
	public String getReviewDate() {
		return reviewDate;
	}
	public void setReviewDate(String reviewDate) {
		this.reviewDate = reviewDate;
	}
	
}
