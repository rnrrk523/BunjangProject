package com.sh.service;

import java.util.ArrayList;

import com.sh.dto.ProductInfoDto;
import com.sh.dto.ProductListDto;
import com.sh.dto.ProductSearchListDto;

public interface ProductService {
	ArrayList<ProductListDto> getProductList(int pageNum);
	ProductInfoDto getProductInfo(Integer storeIdx, int productIdx);
	ArrayList<ProductSearchListDto> getProductSearchList(int pageNum, String str);
	ArrayList<ProductSearchListDto> getProductSearchSortList(String sort, String str);
	ArrayList<ProductSearchListDto> getProductSearchPageNumList(Integer pageNum, String sort, String str);
	ArrayList<ProductSearchListDto> getProductCategoryList(Integer pageNum, String categoryLevel, int categoryIdx);
	void setProductCheck(int productIdx, int viewdStoreIdx);
}
