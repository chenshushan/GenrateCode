package com.chen.code.service;


import com.chen.code.common.Query;
import com.chen.code.common.utils.PageUtils;
import com.chen.code.entity.GenEntity;
import com.chen.code.service.support.IBaseService;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 资源服务类
 * </p>
 *
 * @author SPPan
 * @since 2016-12-28
 */
public interface ITableService extends IBaseService<GenEntity, Integer> {

	PageUtils<Map> queryTableList(Query query);

	List<Map> queryColumns(String tableName);

	byte[] generatorCodeByTable(String... tableNames);

	byte[] generatorCodeByEntity(String... tableNames);

	GenEntity findByClassName(String className);
}
