package com.sh.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sh.dto.StoreDto;

@Repository
public class StoreDaoImpl2 implements StoreDao2 {

    @Autowired
    SqlSession sqlSession;

    @Override
    public StoreDto selectStoreDetail(int storeIdx) {
    	HashMap<String,Integer> map1 = new HashMap<String,Integer>();
    	map1.put("storeIdx", storeIdx);
        return sqlSession.selectOne("StoreMapper.getStoreInfo2", map1);
    }
    @Override
    public int updateStoreName(String storeName, int storeIdx) {
        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("storeName", storeName);
        paramMap.put("storeIdx", storeIdx);
        return sqlSession.update("StoreMapper.updateStoreName", paramMap);
    }
    @Override
    public int updateStoreIntroduction(String storeInt, int storeIdx) {
    	HashMap<String, Object> paramMap = new HashMap<>();
    	paramMap.put("storeInt", storeInt);
    	paramMap.put("storeIdx", storeIdx);
    	return sqlSession.update("StoreMapper.updateStoreIntroduction", paramMap);
    }
}
