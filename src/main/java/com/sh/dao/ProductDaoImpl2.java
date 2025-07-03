package com.sh.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sh.dto.ProductDto;

@Repository
public class ProductDaoImpl2 implements ProductDao2 {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<ProductDto> selectProductDetail(int storeIdx, int categoryIdx, String str) {
        HashMap<String, Object> map1 = new HashMap<>();
        map1.put("storeIdx", storeIdx);

        if (categoryIdx == 0) {
            map1.put("category", "");
        } else {
            map1.put("category", "AND ALL_CATEGORY_IDX = " + categoryIdx);
        }

        switch (str) {
            case "최신순":
                map1.put("sort", "SALE_START_DATE DESC");
                break;
            case "저가순":
                map1.put("sort", "PRICE");
                break;
            case "고가순":
                map1.put("sort", "PRICE DESC");
                break;
            default :
            map1.put("sort", "SALE_START_DATE DESC");
        }
        return sqlSession.selectList("StoreProductMapper.getStoreProductInfo", map1);
    }

    @Override
    public List<ProductDto> selectProductFameDetail(int storeIdx, int categoryIdx) {
        HashMap<String, Object> map2 = new HashMap<>();
        map2.put("storeIdx", storeIdx);

        if (categoryIdx == 0) {
            map2.put("category", "");
        } else {
            map2.put("category", "AND p.ALL_CATEGORY_IDX = " + categoryIdx);
        }

        return sqlSession.selectList("StoreProductMapper.getStoreProductFameInfo", map2);
    }
    @Override
    public int countProductsByStore(int storeIdx, int categoryIdx) {
        HashMap<String, Object> params = new HashMap<>();
        params.put("storeIdx", storeIdx);

        if (categoryIdx == 0) {
            params.put("category", "");
        } else {
            params.put("category", "AND ALL_CATEGORY_IDX = " + categoryIdx);
        }

        return sqlSession.selectOne("StoreProductMapper.countProductsByStore", params);
    }
    @Override
    public List<ProductDto> selectCategoriesByStore(int storeIdx) {
        return sqlSession.selectList("StoreProductMapper.getStoreProductCategoryInfo", storeIdx);
    }
}

