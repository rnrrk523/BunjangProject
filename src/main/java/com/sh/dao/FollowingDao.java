package com.sh.dao;

import java.util.List;

import com.sh.dto.FollowingStoreDto;

public interface FollowingDao {
	List<FollowingStoreDto> selectFollowingDetail(int storeIdx, int myStoreIdx);
}
