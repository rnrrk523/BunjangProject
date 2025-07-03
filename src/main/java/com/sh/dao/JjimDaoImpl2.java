package com.sh.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.sh.dto.JjimDto;

public class JjimDaoImpl2 implements JjimDao2 {
	@Autowired
    SqlSession sqlSession;

    @Override
    public List<JjimDto> selectJjimDetail(int storeIdx, String str) {
        HashMap<String,Object> map1 = new HashMap<>();
        map1.put("storeIdx", storeIdx);
        switch (str) {
	        case "최신순":
	            map1.put("sort", "SALE_START_DATE DESC");
	            break;
	        case "저가순":
	            map1.put("sort", "PRICE");
	            break;
	        case "고가순":
	            map1.put("sort", "PRICE DESC");
	            break;
	        default : 
	        	map1.put("sort", "SALE_START_DATE DESC");
	    }
        return sqlSession.selectList("StoreJjimMapper.getStoreJjimInfo", map1);
    }
    @Override
    public List<JjimDto> selectJjimFameDetail(int storeIdx) {
        HashMap<String, Object> map2 = new HashMap<>();
        map2.put("storeIdx", storeIdx);


        return sqlSession.selectList("StoreJjimMapper.getStoreJjimFameInfo", map2);
    }
    @Override
    public int deleteJjimProduct(int storeIdx, int productIdx) {
        String statement = "StoreJjimMapper.deleteStoreJjim";  // 매퍼 XML에 정의된 id, namespace 포함
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("storeIdx", storeIdx);
        paramMap.put("productIdx", productIdx);

        return sqlSession.update(statement, paramMap);
    }
}
