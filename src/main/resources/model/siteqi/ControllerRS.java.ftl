package com.sitech.prm.scchannel.channel.${classname?lower_case};

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

/**
 *   ${comments}
 */
@Controller
@RequestMapping(value = "/frame/${classname}")
public class ${className}ControllerRS extends RSController{

	/**  ${comments}分页查询
	 * @param request
	 * @param locale
	 * @return
	 */
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

	/** 添加 ${comments}
	 * @param request
	 * @param locale
	 * @return
	 */
	@RequestMapping(value = "/add${className}", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Object add${className}(HttpServletRequest request, @RequestBody JSONObject json, Locale locale) {
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

	/** 更新 ${comments}
	 * @param request
	 * @param locale
	 * @return
	 */
	@RequestMapping(value = "/update${className}", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Object update${className}(HttpServletRequest request, @RequestBody JSONObject json, Locale locale) {
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

	/** 按主键得到单条 ${comments}信息
	 * @param request
	 * @param locale
	 * @return
	 */
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

	/** 删除 ${comments}
	 * @param request
	 * @param locale
	 * @return
	 */
	@RequestMapping(value = "/delete${className}", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Object delete${className}(HttpServletRequest request, @RequestBody JSONObject json, Locale locale) {
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

	/** 导出 ${comments}信息
	 * @param request
	 * @param response
	 * @param locale
	 */
	@RequestMapping(value = "/export${className}", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Object export${className}(HttpServletRequest request, @RequestBody JSONObject json, Locale locale) {
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
