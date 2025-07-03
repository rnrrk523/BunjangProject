package com.sh.dao;

import java.util.List;

import com.sh.dto.ProductDto;

public interface ProductDao2 {
    List<ProductDto> selectProductDetail(int storeIdx, int categoryIdx, String str);
    List<ProductDto> selectProductFameDetail(int storeIdx, int categoryIdx);
    int countProductsByStore(int storeIdx , int categoryIdx);
    List<ProductDto> selectCategoriesByStore(int storeIdx);
}
