package com.sh.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sh.dto.ManagerDto;
@Service
public interface ManagerService {
    List<ManagerDto> getProductManagerInfo(int storeIdx, String str, int startRow, int endRow , String search);
    int getTotalProductCount(int storeIdx, String str, String search);
    boolean deleteProduct(int productIdx);
}

