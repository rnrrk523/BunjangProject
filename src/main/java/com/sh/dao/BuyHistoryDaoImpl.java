package com.sh.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.sh.dto.BuySellDto;

public class BuyHistoryDaoImpl implements BuyHistoryDao {
	@Autowired
    SqlSession sqlSession;

    @Override
	public List<BuySellDto> selectBuyDetail(int storeIdx, String search) {
		HashMap<String,Object> map1 = new HashMap<>();
        map1.put("storeIdx", storeIdx);
        if(search == null || search.trim().isEmpty()) {
            map1.put("search", "");
        } else {
            map1.put("search", "AND UPPER(P.PRODUCT_NAME) LIKE '%' || UPPER('" + search + "') || '%'");
        }
        return sqlSession.selectList("BuyHistoryMapper.getBuyHistoryInfo", map1);
	}
    @Override
    public int updateSaleStatus(int productIdx, int historyIdx, String status) {
        HashMap<String,Object> map1 = new HashMap<>();
        map1.put("historyIdx", historyIdx);
        map1.put("status", status);

        return sqlSession.update("BuyHistoryMapper.updateSaleStatus", map1);
    }
    @Override
    public int updateProductSaleYn(int productIdx) {
        return sqlSession.update("BuyHistoryMapper.updateProductSaleYn", productIdx);
    }
	@Override
	public void updateAllSecession(int storeIdx) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("storeIdx", storeIdx);
		sqlSession.update("BuyHistoryMapper.updateAllSecession", map1);
	}
}
