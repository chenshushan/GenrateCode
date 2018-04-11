package com.chen.code.controller.admin.gen;

import com.chen.code.common.Query;
import com.chen.code.common.R;
import com.chen.code.controller.BaseController;
import com.chen.code.entity.${className};
import com.chen.code.service.I${className}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/${classname}")
public class ${className}Controller extends BaseController {

	@Autowired
	I${className}Service ${classname}Service;

	@RequestMapping("/data")
	public @ResponseBody R data(@RequestParam Map<String, Object> params){
		Query query = new Query(params);
		Page<${className}> page = ${classname}Service.list(query);
		return R.ok().put("rows",page.getContent()).put("total",page.getTotalElements());
	}

    @RequestMapping(value = "/modi/{id}")
	public String modi(@PathVariable Integer id) {
		${className} entity = ${classname}Service.find(id);
		request().setAttribute("entity", entity);
		putEnum();
		return "/admin/${classname}/modi";
	}


	@RequestMapping(value= {"/modiOK"},method = RequestMethod.POST)
	@ResponseBody
	public R modiOK(${className} source){
		int id = source.get${className}Id();
		${className} target = ${classname}Service.find(id);
	<#list columns as column>
		target.set${column.attrName}(source.get${column.attrName}());
	</#list>
		target.setModifiedTime(new Date());
		target.setModifiedCount(target.getModifiedCount()+1);

		${classname}Service.update(target);
		return R.ok();
	}

	@RequestMapping("/{path}")
	public String turn(@PathVariable String path){
		putEnum();
		return "/admin/${classname}/"+path;
	}

	@RequestMapping(value= {"/addOK"},method = RequestMethod.POST)
	@ResponseBody
	public R addOK(${className} ${classname}){
		complteMode(${classname});
		${classname}Service.save(${classname});
		return R.ok();
	}

	@RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
	@ResponseBody
	public R delete(@PathVariable Integer id) {
		${classname}Service.delete(id);
		return R.ok();
	}

	public void putEnum(){
	<#list columns as column>
		<#if (column.attrType == "Enum")>
        request().setAttribute("${column.attrname}EnumOptions",enumToDropDwon(${column.attrType}.class));
		</#if>
	</#list>
	}

}
