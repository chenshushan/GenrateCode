package com.chen.code.service.impl;

import com.chen.code.common.Query;
import com.chen.code.dao.ITemplateDao;
import com.chen.code.dao.support.IBaseDao;
import com.chen.code.entity.Template;
import com.chen.code.service.ITemplateService;
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
public class TemplateServiceImpl extends BaseServiceImpl<Template, Integer> implements ITemplateService {

	@Autowired
	private ITemplateDao templateDao;


	@Override
	public IBaseDao<Template, Integer> getBaseDao() {
		return this.templateDao;
	}


	@Override
	public Page<Template> list(Query query) {
		PageRequest pageRequest = getPageRequest(query);
		PredicateBuilder<Template> builder = Specifications.<Template>and();

		String templateName = query.getString("templateName");
		builder.like(templateName!=null,"templateName", "%"+templateName+"%");
		Date createdTimeBegin = query.getDate("createdTimeBegin");
		Date createdTimeEnd = query.getDate("createdTimeEnd");
		builder.between(createdTimeBegin !=null && createdTimeEnd != null,"createdTime",new Range(createdTimeBegin,createdTimeEnd));

		Specification<Template> specification = builder.build();

		Page<Template> page = templateDao.findAll(specification,pageRequest);
		return page;
	}
}
