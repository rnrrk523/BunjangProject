package com.sh.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sh.dto.ReviewsDto;
@Service
public interface ReviewsService {
	List<ReviewsDto> getStoreReviewsInfo(int storeIdx);
	int insertReview(Map<String, Object> params);
	List<ReviewsDto> getUpdateReviewsView(Map<String, Object> params);
	int updateReview(Map<String, Object> params);
}
