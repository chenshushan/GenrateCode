package com.chen.code.service.impl;

import com.chen.code.common.Query;
import com.chen.code.common.gen.FreemarkerGen;
import com.chen.code.common.utils.PageUtils;
import com.chen.code.common.utils.ToolUtils;
import com.chen.code.dao.ITableDao;
import com.chen.code.dao.support.IBaseDao;
import com.chen.code.entity.GenEntity;
import com.chen.code.service.ITableService;
import com.chen.code.service.support.impl.BaseServiceImpl;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipOutputStream;

@Service
public class TableServiceImpl extends BaseServiceImpl<GenEntity, Integer> implements ITableService {

	@Autowired
	private ITableDao tableDao;


	@Override
	public IBaseDao<GenEntity, Integer> getBaseDao() {
		return this.tableDao;
	}

	@Override
	public PageUtils<Map> queryTableList(Query query) {
//		查询数据库表
		StringBuilder sql =new StringBuilder("select table_name tableName, engine, table_comment tableComment, create_time createTime,TABLE_SCHEMA dbName  from information_schema.tables").
				append(" where table_schema = (select database())");

		List params=new ArrayList();
		String tableName = MapUtils.getString(query, "tableName");
		if(StringUtils.isNotEmpty(tableName)){
			sql.append(" and table_name like concat('%', ?, '%')");
			params.add(tableName);
		}
		sql.append(" order by tableName desc");

//		行数；
		String countSql = "select count(*) nums from (" + sql.toString() + ") a";
		List<Map> nums = getMapBySql(countSql, params.toArray());
		Long count = MapUtils.getLong(nums.get(0), "nums");

		if(count == null || count < 1){
			return new PageUtils();
		}
		int offset = query.getOffset();
		int pageSize = query.getPageSize();
		int currPage = query.getPageNumber();
		if(offset > 0){
			sql.append(String.format(" limit %s,%s"),offset, pageSize);
		}

		List<Map> data = getMapBySql(sql.toString(), params.toArray());
		PageUtils pageUtils = new PageUtils(currPage, pageSize, count);
		pageUtils.setList(data);
		return pageUtils;
	}

	@Override
	public List<Map> queryColumns(String tableName){
		String sql = "select column_name columnName, data_type dataType, column_comment columnComment, column_key columnKey, extra,CHARACTER_MAXIMUM_LENGTH len from information_schema.columns" +
				" where table_name = ? and table_schema = (select database()) order by ordinal_position";
		List<Map> data = getMapBySql(sql, tableName);
		return data;
	}

	@Override
	public byte[] generatorCodeByTable(String... tableNames) {
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		ZipOutputStream zip = new ZipOutputStream(outputStream);

		for(String tableName : tableNames){
			//查询表信息
			Map<String, String> table = queryTable(tableName);
			//查询列信息
			List<Map> columns = queryColumns(tableName);
			//生成代码
			try {
				FreemarkerGen.generatorCode(table, columns, zip);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		IOUtils.closeQuietly(zip);
		return outputStream.toByteArray();
	}

	@Override
	public byte[] generatorCodeByEntity(String... tableNames) {
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		ZipOutputStream zip = new ZipOutputStream(outputStream);
		for(String tableName : tableNames){
			if(ToolUtils.isEmpty(tableName)){
				continue;
			}
			GenEntity table = find(Integer.valueOf(tableName));
			//生成代码
			try {
				FreemarkerGen.generatorCode(table,zip);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		IOUtils.closeQuietly(zip);
		return outputStream.toByteArray();
	}



	private Map<String,String> queryTable(String tableName) {
		String sql = "select table_name tableName, engine, table_comment tableComment, create_time createTime,TABLE_SCHEMA dbName  from information_schema.tables " +
				"where table_schema = (select database()) and table_name = ?";
		List<Map> data = getMapBySql(sql, tableName);
		if(ToolUtils.isEmpty(data)){
			return Collections.emptyMap();
		}
		return data.get(0);
	}


	@Override
	public GenEntity findByClassName(String className){
		return tableDao.findByClassName(className);
	}

}
