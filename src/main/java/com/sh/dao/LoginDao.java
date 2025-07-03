package com.sh.dao;

public interface LoginDao {
	Integer getLoginCheckResult(String id);
	void setStoreInsert(String name, String id);
}
