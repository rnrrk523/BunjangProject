package com.sh.dao;

import java.util.List;

import com.sh.dto.StoreDto;

public interface FollowerDao {
	List<StoreDto> selectFollowerDetail(int storeIdx);
}
