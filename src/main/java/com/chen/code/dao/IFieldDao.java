package com.chen.code.dao;

import com.chen.code.dao.support.IBaseDao;
import com.chen.code.entity.GenField;
import org.springframework.stereotype.Repository;

@Repository
public interface IFieldDao extends IBaseDao<GenField, Integer> {
}
