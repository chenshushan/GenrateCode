package com.chen.code.config.converter;

import org.apache.commons.lang3.StringUtils;
import org.springframework.core.convert.converter.Converter;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 * Created by Administrator on 2017/11/27.
 */
public class StringToLocalDateConverter implements Converter<String,LocalDate> {
	private DateTimeFormatter dateTimeFormatter =DateTimeFormatter.ofPattern("yyyy-MM-dd");
	@Override
	public LocalDate convert(String s) {
		if(StringUtils.isEmpty(s)){
			return null;
		}
		LocalDate localDate = LocalDate.parse(s, dateTimeFormatter);
		return localDate;
	}
}
