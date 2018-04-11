package com.chen.code.controller;

import com.chen.code.common.DateEditor;
import com.chen.code.common.IntegerValuedEnum;
import com.chen.code.entity.enumdo.EnumBaseStatus;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.beans.PropertyDescriptor;
import java.beans.PropertyEditorSupport;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class BaseController {

	

	@InitBinder
    protected void initBinder(WebDataBinder webDataBinder) {
        webDataBinder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
        webDataBinder.registerCustomEditor(Date.class, new DateEditor(true));

    }

	/**
	 * 获取 HttpServletRequest
	 */
	public static HttpServletResponse response() {
		HttpServletResponse response = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getResponse();
		return response;
	}

	/**
	 * 获取 包装防Xss Sql注入的 HttpServletRequest
	 * @return request
	 */
	public static HttpServletRequest request() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		return request;
	}

	/**
     * 带参重定向
     *
     * @param path
     * @return
     */
    protected String redirect(String path) {
        return "redirect:" + path;
    }

    /**
     * 不带参重定向
     *
     * @param response
     * @param path
     * @return
     */
    protected String redirect(HttpServletResponse response, String path) {
        try {
            response.sendRedirect(path);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * 获取分页请求
     * @return
     */
    protected PageRequest getPageRequest(){
    	int page = 0;
    	int size = 10;
    	Sort sort = null;
    	try {
			String sortName = request().getParameter("sortName");
    		String sortOrder = request().getParameter("sortOrder");
    		if(StringUtils.isNoneBlank(sortName) && StringUtils.isNoneBlank(sortOrder)){
    			if(sortOrder.equalsIgnoreCase("desc")){
    				sort = new Sort(Direction.DESC, sortName);
    			}else{
    				sort = new Sort(Direction.ASC, sortName);
    			}
    		}
    		page = Integer.parseInt(request().getParameter("pageNumber")) - 1;
    		size = Integer.parseInt(request().getParameter("pageSize"));
    	} catch (Exception e) {
    	}
    	PageRequest pageRequest = new PageRequest(page, size, sort);
    	return pageRequest;
    }
    
    /**
     * 获取分页请求
     * @param sort 排序条件
     * @return
     */
    protected PageRequest getPageRequest(Sort sort){
    	int page = 0;
    	int size = 10;
    	try {
    		String sortName = request().getParameter("sortName");
    		String sortOrder = request().getParameter("sortOrder");
    		if(StringUtils.isNoneBlank(sortName) && StringUtils.isNoneBlank(sortOrder)){
    			if(sortOrder.equalsIgnoreCase("desc")){
    				sort.and(new Sort(Direction.DESC, sortName));
    			}else{
    				sort.and(new Sort(Direction.ASC, sortName));
    			}
			}
    		page = Integer.parseInt(request().getParameter("pageNumber")) - 1;
    		size = Integer.parseInt(request().getParameter("pageSize"));
		} catch (Exception e) {
			e.printStackTrace();
		}
    	PageRequest pageRequest = new PageRequest(page, size, sort);
    	return pageRequest;
    }

	protected <T extends IntegerValuedEnum> String enumToDropDwon(Class<T> clazz){
		return enumToDropDwon(clazz,null);
	}
	protected <T extends IntegerValuedEnum> String enumToDropDwon(Class<T> clazz,Integer index){
		T[] enumConstants = clazz.getEnumConstants();
		StringBuilder drop_downText = new StringBuilder();
		for (IntegerValuedEnum theEnum : enumConstants) {
			String selected = "";
			if (index !=null && theEnum.getIndex() == index) {
				selected =" selected";
			}
			drop_downText.append("<option value=" + theEnum.getIndex() + selected + ">" + theEnum.getName() + "</option>\n");
		}
		return drop_downText.toString();
	}

	/**将src的非空属性复制到target中(深克隆)
	 * @param target
	 * @param src
	 */
	public static void copyProperties(Object src,Object target){
		BeanUtils.copyProperties(src,target,getIgnorePropertyNames(src));
	}

	/**得到source的值为null的属性
	 * @param source
	 * @return
	 */
	protected static String[] getIgnorePropertyNames(Object source) {
		final BeanWrapper src = new BeanWrapperImpl(source);
		PropertyDescriptor[] pds = src.getPropertyDescriptors();
		Set<String> emptyNames = new HashSet();
		for(PropertyDescriptor pd : pds) {
			Object srcValue = src.getPropertyValue(pd.getName());
			if (srcValue == null){
				emptyNames.add(pd.getName());
			}
		}
		String[] result = new String[emptyNames.size()];
		return emptyNames.toArray(result);
	}


	public void complteMode(Object model) throws InvocationTargetException, IllegalAccessException {
		org.apache.commons.beanutils.BeanUtils.setProperty(model,"createdTime",new Date());
		org.apache.commons.beanutils.BeanUtils.setProperty(model,"modifiedTime",new Date());
		org.apache.commons.beanutils.BeanUtils.setProperty(model,"modifiedCount",0);
		org.apache.commons.beanutils.BeanUtils.setProperty(model,"status", EnumBaseStatus.NORMAL);
	}


	@RequestMapping("/select")
	public String select(String selectKey,String selectName){
		request().setAttribute("selectKey",selectKey);
		request().setAttribute("selectName",selectName);
		return "/admin/platform/select";
	}

}
