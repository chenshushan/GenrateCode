package com.chen.code.service.impl;

import com.chen.code.common.Query;
import com.chen.code.dao.I${className}Dao;
import com.chen.code.dao.support.IBaseDao;
import com.chen.code.entity.${className};
import com.chen.code.service.I${className}Service;
import com.chen.code.service.support.impl.BaseServiceImpl;
import com.github.wenhao.jpa.PredicateBuilder;
import com.github.wenhao.jpa.Specifications;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Range;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class ${className}ServiceImpl extends BaseServiceImpl<${className}, Integer> implements I${className}Service {

	@Autowired
	private I${className}Dao ${classname}Dao;


	@Override
	public IBaseDao<${className}, Integer> getBaseDao() {
		return this.${classname}Dao;
	}


	@Override
	public Page<${className}> list(Query query) {
		PageRequest pageRequest = getPageRequest(query);
		PredicateBuilder<${className}> builder = Specifications.<${className}>and();

		<#list columns as column>
		<#if (column.ifSearch == "1" )>

			<#if (column.attrType == "String")>
		String ${column.attrname} = query.getString("${column.attrname}");
		builder.like(${column.attrname} != null,"${column.attrname}", "%"+${column.attrname}+"%");
			<#elseif (column.attrType == "Reference" )>
		// 此处按关联需要查询的属性修改
		String ${column.attrname}Id = query.getString("${column.attrname}.${column.attrname}Id");
		builder.like(${column.attrname}Id != null,"${column.attrname}.${column.attrname}Id", "%"+${column.attrname}Id+"%");
			<#elseif (column.attrType == "Integer" || column.attrType == "Float" || column.attrType == "BigDecimal" || column.attrType == "Date")>
		Date ${column.attrname}Begin = query.getDate("${column.attrname}Begin");
		Date ${column.attrname}End = query.getDate("${column.attrname}End");
		builder.between(${column.attrname}Begin !=null && ${column.attrname}End != null,"${column.attrname}",new Range(${column.attrname}Begin,${column.attrname}End));
			<#elseif (column.attrType == "Enum")>
		String ${column.attrname} = query.getString("${column.attrname}");
		builder.eq(${column.attrname} != null,"${column.attrname}", EnumUtil.valueOf(${column.attrType},${column.attrname}));
			<#else>
			</#if>
		</#if>
		</#list>

		Specification<${className}> specification = builder.build();

		Page<${className}> page = ${classname}Dao.findAll(specification,pageRequest);
		return page;
	}
}
