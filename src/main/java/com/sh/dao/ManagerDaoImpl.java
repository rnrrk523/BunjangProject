package com.sh.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.sh.dto.ManagerDto;

public class ManagerDaoImpl implements ManagerDao {
    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<ManagerDto> selectManagerDetail(int storeIdx, String str, int startRow, int endRow, String search) {
        Map<String, Object> params = new HashMap<>();
        params.put("storeIdx", storeIdx);
        params.put("startRow", startRow);
        params.put("endRow", endRow);

        if ("전체".equals(str)) {
            params.put("sort", ""); // 전체일 땐 조건 없음
        } else if ("판매중".equals(str)) {
            params.put("sort", "AND p.SALE_YN = 'N'");
        } else if ("판매완료".equals(str)) {
            params.put("sort", "AND p.SALE_YN = 'Y'");
        } else {
            params.put("sort", "");
        }
        if(search.length()!=0) {
        	params.put("searchKeywordCondition", "AND LOWER(p.PRODUCT_NAME) LIKE '%' || LOWER('" + search + "') || '%'");
        }

        return sqlSession.selectList("ProductManagerMapper.getProductManagerInfo", params);
    }

    @Override
    public int getTotalProductCount(int storeIdx, String str, String search) {
        Map<String, Object> params = new HashMap<>();
        params.put("storeIdx", storeIdx);

        if ("전체".equals(str)) {
            params.put("sort", "");
        } else if ("판매중".equals(str)) {
            params.put("sort", "AND SALE_YN = 'N'");
        } else if ("판매완료".equals(str)) {
            params.put("sort", "AND SALE_YN = 'Y'");
        } else {
            params.put("sort", "");
        }
        if(search.length()!=0) {
        	params.put("searchKeywordCondition", "AND LOWER(p.PRODUCT_NAME) LIKE '%' || LOWER('" + search + "') || '%'");
        }
        return sqlSession.selectOne("ProductManagerMapper.getProductManagerCount", params);
    }
    @Override
    public int deleteProduct(int productIdx) {
        return sqlSession.delete("ProductManagerMapper.deleteProduct", productIdx);
    }
}

