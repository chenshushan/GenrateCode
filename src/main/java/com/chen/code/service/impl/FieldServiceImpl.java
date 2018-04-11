package com.chen.code.service.impl;

import com.chen.code.dao.IFieldDao;
import com.chen.code.dao.support.IBaseDao;
import com.chen.code.entity.GenField;
import com.chen.code.service.IFieldService;
import com.chen.code.service.support.impl.BaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 资源表 服务实现类
 * </p>
 *
 * @author SPPan
 * @since 2016-12-28
 */
@Service
public class FieldServiceImpl extends BaseServiceImpl<GenField, Integer> implements IFieldService {

	@Autowired
	private IFieldDao fieldDao;


	@Override
	public IBaseDao<GenField, Integer> getBaseDao() {
		return this.fieldDao;
	}



}
