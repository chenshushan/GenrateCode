
package com.sitech.prm.scchannel.channel.${classname};

import com.fasterxml.jackson.core.type.TypeReference;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sitech.prm.sccloud.frame.common.NormalController;
import com.sitech.prm.sccloud.service.JsonReportUtils;
import com.sitech.prm.sccloud.service.ServiceUtils;
import com.sitech.prm.sccloud.util.ExcelUtils;
import com.sitech.prm.sccloud.vo.LoginOprVO;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@Controller
@RequestMapping(value = "/${classname}")
public class ${className}Controller extends NormalController{

	@RequestMapping(value = "/getPage", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Object getPage(HttpServletRequest request, Locale locale) {
		try {
			Map<String, String> params = loadParam2Map(request);
			// 获取登陆信息
			LoginOprVO lvo = getLoginOprVo(request);

			JSONObject result = ServiceUtils.callDspServiceLimitary(params, lvo);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return ServiceUtils.createJsonExceptionReport(e, messageSource, locale);
		}
	}


	@RequestMapping(value = "/doAdd", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Object doAdd(HttpServletRequest request, Locale locale) {
		try {
			Map<String, String> params = loadParam2Map(request);
			// 获取登陆信息
			LoginOprVO lvo = getLoginOprVo(request);

			Object result = ServiceUtils.callDspServiceLimitary(params, lvo);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return ServiceUtils.createJsonExceptionReport(e, messageSource, locale);
		}
	}


	@RequestMapping(value = "/doUpdate", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Object doUpdate(HttpServletRequest request, Locale locale) {
		try {
			Map<String, String> params = loadParam2Map(request);
			// 获取登陆信息
			LoginOprVO lvo = getLoginOprVo(request);
			Object result = ServiceUtils.callDspServiceLimitary(params, lvo);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return ServiceUtils.createJsonExceptionReport(e, messageSource, locale);
		}
	}

	@RequestMapping(value = "/getEntity", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Object getEntity(HttpServletRequest request, Locale locale) {
		try {
			Map<String, String> params = loadParam2Map(request);
			// 获取登陆信息
			LoginOprVO lvo = getLoginOprVo(request);
			Object result = ServiceUtils.callDspServiceLimitary(params, lvo);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return ServiceUtils.createJsonExceptionReport(e, messageSource, locale);
		}
	}


	@RequestMapping(value = "/doDelete", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Object doDelete(HttpServletRequest request, Locale locale) {
		try {
			Map<String, String> params = loadParam2Map(request);
			// 获取登陆信息
			LoginOprVO lvo = getLoginOprVo(request);

			Object result = ServiceUtils.callDspServiceLimitary(params, lvo);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return ServiceUtils.createJsonExceptionReport(e, messageSource, locale);
		}
	}



	@RequestMapping(value = "/doExport", method = { RequestMethod.POST, RequestMethod.GET })
	public void doExport(HttpServletRequest request, HttpServletResponse response, Locale locale) {
		try {
			Map<String, String> params = loadParam2Map(request);
			LoginOprVO lvo = getLoginOprVo(request);
			JSONObject responseJson = ServiceUtils.callDspServiceLimitary(params, lvo);

			String fileName = (String) responseJson.get("fName");
			String sheetName = (String) responseJson.get("sheetName");
			Map<String,String> waterMarkInfo = (Map<String,String>)responseJson.get("waterMarkInfo");
			waterMarkInfo.put("rootPath", request.getSession().getServletContext().getRealPath("/"));

			Object obj = responseJson.get("valueList");

			Gson gson = new Gson();

			TypeToken<List<String[]>> listType = new TypeToken<List<String[]>>() {};

			List<String[]> o = gson.fromJson(obj.toString(), listType.getType());

			// 导出文件
			ExcelUtils.exportXls(fileName, sheetName, response, o, waterMarkInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
