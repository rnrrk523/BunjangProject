package com.sh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.dao.ProductDao2;
import com.sh.dto.ProductDto;

@Service
public class ProductServiceImpl2 implements ProductService2 {

    @Autowired
    private ProductDao2 productDao;

    @Override
    public List<ProductDto> getStoreProductInfo(int storeIdx, int categoryIdx, String str) {
        if ("인기순".equals(str)) {
            return productDao.selectProductFameDetail(storeIdx, categoryIdx);
        } else {
            return productDao.selectProductDetail(storeIdx, categoryIdx, str);
        }
    }

    @Override
    public int countProductsByStore(int storeIdx, int categoryIdx) {
        return productDao.countProductsByStore(storeIdx, categoryIdx);
    }

    @Override
    public List<ProductDto> selectCategoriesByStore(int storeIdx) {
        return productDao.selectCategoriesByStore(storeIdx);
    }
}
