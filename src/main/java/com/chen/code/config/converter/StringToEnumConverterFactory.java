package com.chen.code.config.converter;

import com.chen.code.common.IntegerValuedEnum;
import com.chen.code.common.utils.EnumUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.convert.converter.ConverterFactory;

/**
 * Created by 陈书山 on 2016/12/1.
 *
 * Spring在注入参数时会检查到IntegerValuedEnum类型，检查到之后到这里来获取Converter
 * 自定义Converter将String参数转化成对应的枚举即可
 */
public final class StringToEnumConverterFactory implements ConverterFactory<String, IntegerValuedEnum> {

	public <T extends IntegerValuedEnum> Converter<String, T> getConverter(Class<T> targetType) {
		return new StringToEnum(targetType);
	}

	private class StringToEnum<T extends Enum<?> & IntegerValuedEnum> implements Converter<String, T> {

		private final Class<T> enumType;

		public StringToEnum(Class<T> enumType) {
			this.enumType = enumType;
		}

		public  T convert(String source) {
			if (StringUtils.isEmpty(source)) {
				return null;
			}
			return EnumUtil.valueOf(enumType, source);
		}
	}

}