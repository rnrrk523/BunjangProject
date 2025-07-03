package com.sh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.dao.StoreDao2;
import com.sh.dto.StoreDto;

@Service
public class StoreServiceImpl2 implements StoreService2 {
    
    @Autowired
    StoreDao2 storeDao;

    @Override
    public StoreDto getStoreInfo(int storeIdx) {
        return storeDao.selectStoreDetail(storeIdx);
    }
    
    @Override
    public int updateStoreName(int storeIdx, String storeName) {
        return storeDao.updateStoreName(storeName, storeIdx);
    }
    
    @Override
    public int updateStoreIntroduction(int storeIdx, String storeInt) {
    	return storeDao.updateStoreIntroduction(storeInt, storeIdx);
    }
}
