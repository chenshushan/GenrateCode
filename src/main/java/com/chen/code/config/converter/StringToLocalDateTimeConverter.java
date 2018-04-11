package com.chen.code.config.converter;

import org.apache.commons.lang3.StringUtils;
import org.springframework.core.convert.converter.Converter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Created by Administrator on 2017/11/27.
 */
public class StringToLocalDateTimeConverter implements Converter<String,LocalDateTime> {
	private DateTimeFormatter dateTimeFormatter =DateTimeFormatter.ofPattern("yyyy-MM-dd HH-mm-ss");
	@Override
	public LocalDateTime convert(String s) {
		if(StringUtils.isEmpty(s)){
			return null;
		}
		s = s.replaceAll("/|:|\\.", "-");
		LocalDateTime localDateTime = LocalDateTime.parse(s, dateTimeFormatter);
		return localDateTime;
	}
}
