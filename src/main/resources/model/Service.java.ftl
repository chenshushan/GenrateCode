package com.chen.code.service;


import com.chen.code.common.Query;
import com.chen.code.entity.${className};
import com.chen.code.service.support.IBaseService;
import org.springframework.data.domain.Page;

public interface I${className}Service extends IBaseService<${className}, Integer> {
	Page<${className}> list(Query query);
}
