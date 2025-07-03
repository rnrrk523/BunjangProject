package com.sh.dao;

import java.util.List;
import java.util.Map;

import com.sh.dto.ReviewsDto;

public interface ReviewsDao {
	List<ReviewsDto> selectReviewsDetail(int storeIdx);
	List<ReviewsDto> UpdateReviewsView(Map<String, Object> params);
	int insertReview(Map<String, Object> params);
	int updateReview(Map<String, Object> params);
}
