package com.sh.service;

import java.util.List;

import com.sh.dto.CategoryDto;

public interface CategoryService2 {
	List<CategoryDto> getAllCategoryInfo();
	List<CategoryDto> getMiddleCategoryInfo(int pno);
	List<CategoryDto> getSmallCategoryInfo(int pno);
}
