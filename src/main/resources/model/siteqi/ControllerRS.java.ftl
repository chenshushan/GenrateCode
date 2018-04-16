package com.sitech.prm.scchannel.channel.${classname};

import com.sitech.prm.sccloud.frame.common.RSController;
import com.sitech.prm.sccloud.service.ServiceUtils;
import com.sitech.prm.sccloud.vo.LoginOprVO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

@Controller
@RequestMapping(value = "/frame/${classname}")
public class ${className}ControllerRS extends RSController{

	@RequestMapping(value = "/getPage", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Object getPage(HttpServletRequest request, @RequestBody JSONObject json, Locale locale) {
		try {
			JSONArray jsonArray = loadParamJSONArray(json);
			Map<?, ?> inParams = getElement(request, jsonArray, 0, HashMap.class);
			LoginOprVO lvo = getElement(request, jsonArray, 1, LoginOprVO.class);
			return ServiceUtils.callDspService(inParams, lvo);
		} catch (Exception e) {
			e.printStackTrace();
			return ServiceUtils.createJsonExceptionReport(e, messageSource, locale);
		}
	}
	@RequestMapping(value = "/doAdd", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Object doAdd(HttpServletRequest request, @RequestBody JSONObject json, Locale locale) {
		try {
			JSONArray jsonArray = loadParamJSONArray(json);
			Map<?, ?> inParams = getElement(request, jsonArray, 0, HashMap.class);
			LoginOprVO lvo = getElement(request, jsonArray, 1, LoginOprVO.class);
			return ServiceUtils.callDspService(inParams, lvo);
		} catch (Exception e) {
			e.printStackTrace();
			return ServiceUtils.createJsonExceptionReport(e, messageSource, locale);
		}
	}
	@RequestMapping(value = "/doUpdate", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Object doUpdate(HttpServletRequest request, @RequestBody JSONObject json, Locale locale) {
		try {
			JSONArray jsonArray = loadParamJSONArray(json);
			Map<?, ?> inParams = getElement(request, jsonArray, 0, HashMap.class);
			LoginOprVO lvo = getElement(request, jsonArray, 1, LoginOprVO.class);
			return ServiceUtils.callDspService(inParams, lvo);
		} catch (Exception e) {
			e.printStackTrace();
			return ServiceUtils.createJsonExceptionReport(e, messageSource, locale);
		}
	}
	@RequestMapping(value = "/getData", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Object getData(HttpServletRequest request, @RequestBody JSONObject json, Locale locale) {
		try {
			JSONArray jsonArray = loadParamJSONArray(json);
			Map<?, ?> inParams = getElement(request, jsonArray, 0, HashMap.class);
			LoginOprVO lvo = getElement(request, jsonArray, 1, LoginOprVO.class);
			return ServiceUtils.callDspService(inParams, lvo);
		} catch (Exception e) {
			e.printStackTrace();
			return ServiceUtils.createJsonExceptionReport(e, messageSource, locale);
		}
	}
	@RequestMapping(value = "/doDelete", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Object doDelete(HttpServletRequest request, @RequestBody JSONObject json, Locale locale) {
		try {
			JSONArray jsonArray = loadParamJSONArray(json);
			Map<?, ?> inParams = getElement(request, jsonArray, 0, HashMap.class);
			LoginOprVO lvo = getElement(request, jsonArray, 1, LoginOprVO.class);
			return ServiceUtils.callDspService(inParams, lvo);
		} catch (Exception e) {
			e.printStackTrace();
			return ServiceUtils.createJsonExceptionReport(e, messageSource, locale);
		}
	}

	@RequestMapping(value = "/doExport", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Object doExport(HttpServletRequest request, @RequestBody JSONObject json, Locale locale) {
		try {
			JSONArray jsonArray = loadParamJSONArray(json);
			Map<?, ?> inParams = getElement(request, jsonArray, 0, HashMap.class);
			LoginOprVO lvo = getElement(request, jsonArray, 1, LoginOprVO.class);
			return ServiceUtils.callDspService(inParams, lvo);
		} catch (Exception e) {
			e.printStackTrace();
			return ServiceUtils.createJsonExceptionReport(e, messageSource, locale);
		}
	}
 }
