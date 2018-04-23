
package com.sitech.prm.scchannel.channel.${classname?lower_case};

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sitech.prm.sccloud.frame.common.NormalController;
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

/**
 *   ${comments}
 */
@Controller
@RequestMapping(value = "/${classname}")
public class ${className}Controller extends NormalController{
	/**  ${comments}分页查询
	 * @param request
	 * @param locale
	 * @return
	 */
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

	/** 添加 ${comments}
	 * @param request
	 * @param locale
	 * @return
	 */
	@RequestMapping(value = "/add${className}", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Object add${className}(HttpServletRequest request, Locale locale) {
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

	/** 更新 ${comments}
	 * @param request
	 * @param locale
	 * @return
	 */
	@RequestMapping(value = "/update${className}", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Object update${className}(HttpServletRequest request, Locale locale) {
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
	/** 按主键得到单条 ${comments}信息
	 * @param request
	 * @param locale
	 * @return
	 */
	@RequestMapping(value = "/getData", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Object getData(HttpServletRequest request, Locale locale) {
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

	/** 删除 ${comments}
	 * @param request
	 * @param locale
	 * @return
	 */
	@RequestMapping(value = "/delete${className}", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Object delete${className}(HttpServletRequest request, Locale locale) {
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

	/** 导出 ${comments}信息
	 * @param request
	 * @param response
	 * @param locale
	 */

	@RequestMapping(value = "/export${className}", method = { RequestMethod.POST, RequestMethod.GET })
	public void export${className}(HttpServletRequest request, HttpServletResponse response, Locale locale) {
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

			// 文件导出之后按这个flag判断文件是否下载完成
			String fileDownloadedFlag = StringTools.changeNullStr(params.get("fileDownloadedFlag")).trim();
			request.getSession().setAttribute(fileDownloadedFlag, "");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
