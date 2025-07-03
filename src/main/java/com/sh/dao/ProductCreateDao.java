package com.sh.dao;

import com.sh.dto.InsertProductDto;

public interface ProductCreateDao {
	int insertProduct(InsertProductDto product);
}
