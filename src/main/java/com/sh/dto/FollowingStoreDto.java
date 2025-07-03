package com.sh.dto;

public class FollowingStoreDto {
	private int storeIdx;
    private int visitCount;
    private int sellCount;
    private int avgStartIdx;
    private int productCount;
    private int reviewCount;
    private int jjimCount;
    private int followerCount;
    private int followingCount;
    private String storeName;
    private String openDate;
    private String introduction;
    private String profileImg;
    private String followingYN;
    
    public FollowingStoreDto() { }
    
	public FollowingStoreDto(int storeIdx, int visitCount, int sellCount, int avgStartIdx, int productCount,
			int reviewCount, int jjimCount, int followerCount, int followingCount, String storeName, String openDate,
			String introduction, String profileImg, String followingYN) {
		super();
		this.storeIdx = storeIdx;
		this.visitCount = visitCount;
		this.sellCount = sellCount;
		this.avgStartIdx = avgStartIdx;
		this.productCount = productCount;
		this.reviewCount = reviewCount;
		this.jjimCount = jjimCount;
		this.followerCount = followerCount;
		this.followingCount = followingCount;
		this.storeName = storeName;
		this.openDate = openDate;
		this.introduction = introduction;
		this.profileImg = profileImg;
		this.followingYN = followingYN;
	}

	public int getStoreIdx() {
		return storeIdx;
	}

	public void setStoreIdx(int storeIdx) {
		this.storeIdx = storeIdx;
	}

	public int getVisitCount() {
		return visitCount;
	}

	public void setVisitCount(int visitCount) {
		this.visitCount = visitCount;
	}

	public int getSellCount() {
		return sellCount;
	}

	public void setSellCount(int sellCount) {
		this.sellCount = sellCount;
	}

	public int getAvgStartIdx() {
		return avgStartIdx;
	}

	public void setAvgStartIdx(int avgStartIdx) {
		this.avgStartIdx = avgStartIdx;
	}

	public int getProductCount() {
		return productCount;
	}

	public void setProductCount(int productCount) {
		this.productCount = productCount;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}

	public int getJjimCount() {
		return jjimCount;
	}

	public void setJjimCount(int jjimCount) {
		this.jjimCount = jjimCount;
	}

	public int getFollowerCount() {
		return followerCount;
	}

	public void setFollowerCount(int followerCount) {
		this.followerCount = followerCount;
	}

	public int getFollowingCount() {
		return followingCount;
	}

	public void setFollowingCount(int followingCount) {
		this.followingCount = followingCount;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getOpenDate() {
		return openDate;
	}

	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public String getFollowingYN() {
		return followingYN;
	}

	public void setFollowingYN(String followingYN) {
		this.followingYN = followingYN;
	}
}
