package com.sh.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sh.dto.InsertProductDto;

@Repository
public class ProductCreateDaoImpl implements ProductCreateDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    private static final String NAMESPACE = "NewMapper";

    @Override
    public int insertProduct(InsertProductDto product) {
        return sqlSession.insert(NAMESPACE + ".insertProduct", product);
    }
}
