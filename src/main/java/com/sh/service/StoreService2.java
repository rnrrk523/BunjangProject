package com.sh.service;

import org.springframework.stereotype.Service;

import com.sh.dto.StoreDto;
@Service
public interface StoreService2 {
    StoreDto getStoreInfo(int storeIdx);
    int updateStoreName(int storeIdx, String storeName);
    int updateStoreIntroduction(int storeIdx, String storeInt);
}
