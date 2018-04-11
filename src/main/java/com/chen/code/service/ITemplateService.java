package com.chen.code.service;


import com.chen.code.common.Query;
import com.chen.code.entity.Template;
import com.chen.code.service.support.IBaseService;
import org.springframework.data.domain.Page;

public interface ITemplateService extends IBaseService<Template, Integer> {
	Page<Template> list(Query query);

}
