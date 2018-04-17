package com.chen.code.controller.admin.gen;

import com.chen.code.common.Query;
import com.chen.code.common.R;
import com.chen.code.common.utils.UploadUtils;
import com.chen.code.controller.BaseController;
import com.chen.code.entity.Template;
import com.chen.code.service.ITemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
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
	public String addOK(@RequestParam("file") MultipartFile file, Template template){

		if(file.isEmpty()){
			throw new RuntimeException("调整文件不可为空");
		}
		String fileName = file.getOriginalFilename();
//		if(!fileName.endsWith("xls")){
//			throw new RuntimeException("调整文件格式必须为xls");
//		}
		String templatePath = "/upload/template";
		String path = request().getSession().getServletContext().getRealPath(templatePath);

		File upload = null;
		try {
			upload = UploadUtils.upload(file, path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		String fpath = templatePath + File.separator + upload.getName();
		template.setTemplatePath(fpath);
		templateService.save(template);
		return "/admin/template/add";
	}

	@RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
	@ResponseBody
	public R delete(@PathVariable Integer id,ModelMap map) {
		templateService.delete(id);
		return R.ok();
	}



}
