package com.sh.service;

import java.io.BufferedReader;
import java.io.Reader;
import java.sql.Clob;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.dao.ProductDao;
import com.sh.dto.ProductInfoDto;
import com.sh.dto.ProductListDto;
import com.sh.dto.ProductSearchListDto;

@Service
public class ProductServiceImpl implements ProductService {
	@Autowired
	ProductDao pDao;
	
	@Override
	public ArrayList<ProductListDto> getProductList(int pageNum) {
		int end = pageNum * 10;
		int start = end - 9;
		
		return pDao.getProductList(start, end);
	}

	@Override
	public ProductInfoDto getProductInfo(Integer storeIdx, int productIdx) {
		ProductInfoDto productInfo = pDao.getProductInfo(storeIdx, productIdx);
		return productInfo;
	}

	@Override
	public ArrayList<ProductSearchListDto> getProductSearchList(int pageNum, String str) {
		int end = pageNum * 10;
		int start = end - 9;
		
		return pDao.getProductSearchList(start, end, "%"+str+"%");
	}

	@Override
	public ArrayList<ProductSearchListDto> getProductSearchSortList(String sort, String str) {
		if(sort.equals("최신순")) {
			return pDao.getProductSearchSortList1("%"+str+"%");
		}else if(sort.equals("저가순")) {
			return pDao.getProductSearchSortList2("%"+str+"%");
		}else if(sort.equals("고가순")){
			return pDao.getProductSearchSortList3("%"+str+"%");
		}
		return pDao.getProductSearchSortList1("%"+str+"%");
	}

	@Override
	public ArrayList<ProductSearchListDto> getProductSearchPageNumList(Integer pageNum, String sort, String str) {
		int end = pageNum * 10;
		int start = end - 9;
		String sortStr = "p.sale_start_date DESC";
		if(sort.equals("저가순")) {
			sortStr = "p.price ASC";
		}else if(sort.equals("고가순")){
			sortStr = "p.price DESC";
		}
		
		return pDao.getProductSearchPageNumList(start, end, sortStr, "%"+str+"%");
	}

	@Override
	public ArrayList<ProductSearchListDto> getProductCategoryList(Integer pageNum, String categoryLevel, int categoryIdx) {
		int end = pageNum * 10;
		int start = end - 9;
		String categoryLevelStr = "p.all_category_idx";
		if(categoryLevel.equals("all")) {
			categoryLevelStr = "p.all_category_idx";
		}else if(categoryLevel.equals("middle")) {
			categoryLevelStr = "p.middle_category_idx";
		}else if(categoryLevel.equals("sub")) {
			categoryLevelStr = "p.sub_category_idx";
		}
		
		ArrayList<ProductSearchListDto> categoryItmeList = pDao.getProductCategoryList(start, end, categoryLevelStr, categoryIdx);
		
		return categoryItmeList;
	}

	@Override
	public void setProductCheck(int productIdx, int viewdStoreIdx) {
		pDao.setProductCheck(productIdx, viewdStoreIdx);
	}
	
}
