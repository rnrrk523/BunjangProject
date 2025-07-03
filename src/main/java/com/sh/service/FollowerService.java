package com.sh.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sh.dto.StoreDto;

@Service
public interface FollowerService {
	List<StoreDto> getStoreFollowerInfo(int storeIdx);
}
