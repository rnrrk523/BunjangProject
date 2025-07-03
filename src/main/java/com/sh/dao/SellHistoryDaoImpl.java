package com.sh.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.sh.dto.BuySellDto;
import com.sh.dto.StoreDto;

public class SellHistoryDaoImpl implements SellHistoryDao {
	@Autowired
    SqlSession sqlSession;

    @Override
	public List<BuySellDto> selectSellDetail(int storeIdx, String search) {
		HashMap<String,Object> map1 = new HashMap<>();
        map1.put("storeIdx", storeIdx);
        if(search == null || search.trim().isEmpty()) {
            map1.put("search", "");
        } else {
            map1.put("search", "AND UPPER(P.PRODUCT_NAME) LIKE '%' || UPPER('" + search + "') || '%'");
        }
        return sqlSession.selectList("SellHistoryMapper.getSellHistoryInfo", map1);
	}

}
