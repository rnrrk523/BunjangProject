package com.sh.dao;

import java.util.ArrayList;

import com.sh.dto.CategoryListDto;

public interface CategoryDao {
	ArrayList<CategoryListDto> getCategoryList1();
	ArrayList<CategoryListDto> getCategoryList2(int id);
	ArrayList<CategoryListDto> getCategoryList3(int id);
	String getAllCategoryName(int categoryIdx);
	String getMiddleCategoryName(int categoryIdx);
	String getSubCategoryName(int categoryIdx);
	int getMiddleCategoryParentId(int categoryIdx);
	int getSubCategoryParentId(int categoryIdx);
}
