package com.sh.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sh.dto.FollowingStoreDto;

@Service
public interface FollowingService {
	List<FollowingStoreDto> getStoreFollowingInfo(int storeIdx, int myStoreIdx);
}
