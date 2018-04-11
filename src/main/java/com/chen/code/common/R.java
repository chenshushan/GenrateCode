package com.chen.code.common;

import java.util.HashMap;
import java.util.Map;

/**
 * 返回数据
 * Created by 陈书山 on 2017/08/21.
 */
public class R extends HashMap<String, Object> {
	private static final long serialVersionUID = 1L;
	
	private R() {
		put("code", 1);
	}
	
	public static R error() {
		return error(0, "未知异常，请联系管理员");
	}
	
	public static R error(String msg) {
		return error(0, msg);
	}
	
	public static R error(int code, String msg) {
		R r = new R();
		r.put("code", code);
		r.put("msg", msg);
		return r;
	}

	public static R ok(String msg) {
		R r = new R();
		r.put("msg", msg);
		return r;
	}
	
	public static R ok(Map<String, Object> map) {
		R r = new R();
		r.putAll(map);
		return r;
	}
	
	public static R ok() {
		return new R();
	}

	public R put(String key, Object value) {
		super.put(key, value);
		return this;
	}
	public R data(Object value) {
		super.put("data", value);
		return this;
	}
}
