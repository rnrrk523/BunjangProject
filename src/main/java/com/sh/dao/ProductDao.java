package com.sh.dao;

import java.util.ArrayList;

import com.sh.dto.ProductInfoDto;
import com.sh.dto.ProductListDto;
import com.sh.dto.ProductSearchListDto;

public interface ProductDao {
	ArrayList<ProductListDto> getProductList(int rnum1, int rnum2);
	ProductInfoDto getProductInfo(Integer storeIdx, int productIdx);
	ArrayList<ProductSearchListDto> getProductSearchList(int rnum1, int rnum2, String str);
	ArrayList<ProductSearchListDto> getProductSearchSortList1(String str);
	ArrayList<ProductSearchListDto> getProductSearchSortList2(String str);
	ArrayList<ProductSearchListDto> getProductSearchSortList3(String str);
	ArrayList<ProductSearchListDto> getProductSearchPageNumList(int rnum1, int rnum2, String sortStr, String str);
	ArrayList<ProductSearchListDto> getProductCategoryList(int rnum1, int rnum2, String categoryLevel, int categoryIdx);
	void setProductCheck(int productIdx, int viewdStoreIdx);
}
