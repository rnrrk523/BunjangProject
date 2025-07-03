package com.sh.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sh.dto.ProductDto;

@Service
public interface ProductService2 {
	List<ProductDto> getStoreProductInfo(int storeIdx, int categoryIdx, String str);
    int countProductsByStore(int storeIdx, int categoryIdx);
    List<ProductDto> selectCategoriesByStore(int storeIdx);
}
