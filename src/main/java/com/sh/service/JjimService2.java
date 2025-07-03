package com.sh.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sh.dto.JjimDto;
@Service
public interface JjimService2 {
	List<JjimDto> getStoreJjimInfo(int storeIdx, String str);
	void deleteJjimProduct(List<Integer> productIdxList, int storeIdx);
}
