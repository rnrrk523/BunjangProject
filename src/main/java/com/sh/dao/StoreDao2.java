package com.sh.dao;

import com.sh.dto.StoreDto;

public interface StoreDao2 {
    StoreDto selectStoreDetail(int storeIdx);
    int updateStoreName(String storeName, int storeIdx);
    int updateStoreIntroduction(String storeInt, int storeIdx);
}
