package com.chen.code.controller.admin.gen;

import com.chen.code.common.Query;
import com.chen.code.common.R;
import com.chen.code.controller.BaseController;
import com.chen.code.entity.Template;
import com.chen.code.service.ITemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * Created by Administrator on 2017/11/25.
 */
@Controller
@RequestMapping("/template")
public class TemplateController extends BaseController {

	@Autowired
	ITemplateService templateService;

	@RequestMapping("/data")
	public @ResponseBody R data(@RequestParam Map<String, Object> params){
		Query query = new Query(params);
		Page<Template> page = templateService.list(query);
		return R.ok().put("rows",page.getContent()).put("total",page.getTotalElements());
	}

	@RequestMapping(value = "/modi/{id}")
	public String edit(@PathVariable Integer id) {
		Template template = templateService.find(id);
		request().setAttribute("entity", template);
		return "/admin/template/modi";
	}


	@RequestMapping(value= {"/modiOK"},method = RequestMethod.POST)
	@ResponseBody
	public R modiOK(Template template){
		template.setTemplateId(2);
		templateService.update(template);
		return R.ok();
	}

	@RequestMapping("/{path}")
	public String turn(@PathVariable String path){
		return "/admin/template/"+path;
	}

	@RequestMapping(value= {"/addOK"},method = RequestMethod.POST)
	@ResponseBody
	public R addOK(Template template){
		templateService.save(template);
		return R.ok();
	}

	@RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
	@ResponseBody
	public R delete(@PathVariable Integer id,ModelMap map) {
		templateService.delete(id);
		return R.ok();
	}



}
