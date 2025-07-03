package com.sh.dto;

public class StoreReviewDto {
	private int storeIdx;
	private String writerName;
	private int startCnt;
	private String reviewText;
	private String elapsedDate;
	
	public StoreReviewDto() { }
	public StoreReviewDto(int storeIdx, String writerName, int startCnt, String reviewText, String elapsedDate) {
		this.storeIdx = storeIdx;
		this.writerName = writerName;
		this.startCnt = startCnt;
		this.reviewText = reviewText;
		this.elapsedDate = elapsedDate;
	}
	
	public int getStoreIdx() {
		return storeIdx;
	}
	public void setStoreIdx(int storeIdx) {
		this.storeIdx = storeIdx;
	}
	public String getWriterName() {
		return writerName;
	}
	public void setWriterName(String writerName) {
		this.writerName = writerName;
	}
	public int getStartCnt() {
		return startCnt;
	}
	public void setStartCnt(int startCnt) {
		this.startCnt = startCnt;
	}
	public String getReviewText() {
		return reviewText;
	}
	public void setReviewText(String reviewText) {
		this.reviewText = reviewText;
	}
	public String getElapsedDate() {
		return elapsedDate;
	}
	public void setElapsedDate(String elapsedDate) {
		this.elapsedDate = elapsedDate;
	}
}
