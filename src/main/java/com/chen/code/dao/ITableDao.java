package com.chen.code.dao;

import com.chen.code.dao.support.IBaseDao;
import com.chen.code.entity.GenEntity;
import org.springframework.stereotype.Repository;

@Repository
public interface ITableDao extends IBaseDao<GenEntity, Integer> {
	GenEntity findByClassName(String className);

}
