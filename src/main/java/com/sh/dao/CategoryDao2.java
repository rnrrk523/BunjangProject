package com.sh.dao;

import java.util.List;

import com.sh.dto.CategoryDto;

public interface CategoryDao2 {
	List<CategoryDto> getAllCategoryDetail();
	List<CategoryDto> getMiddleCategoryDetail(int pno);
	List<CategoryDto> getSmallCategoryDetail(int pno);
}
