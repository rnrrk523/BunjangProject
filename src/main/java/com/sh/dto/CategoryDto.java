package com.sh.dto;

public class CategoryDto {
	private int categoryIdx;
	private String categoryName;
	public CategoryDto() {}
	public CategoryDto(int categoryIdx, String categoryName) {
		this.categoryIdx = categoryIdx;
		this.categoryName = categoryName;
	}
	public int getCategoryIdx() {
		return categoryIdx;
	}
	public void setCategoryIdx(int categoryIdx) {
		this.categoryIdx = categoryIdx;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
}
