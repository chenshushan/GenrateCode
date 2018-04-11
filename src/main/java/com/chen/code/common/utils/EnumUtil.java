package com.chen.code.common.utils;


import com.chen.code.common.IntegerValuedEnum;

public class EnumUtil {
	private static <T extends Enum & IntegerValuedEnum> String getDrop_downByEnum(Class<T> enumClass, IntegerValuedEnum defaultEnumObject) {
		if (enumClass == null) {
			return "";
		}
		StringBuffer drop_downText = new StringBuffer();
		for (IntegerValuedEnum theEnum : enumClass.getEnumConstants()) {
			String selected = "";
			if (defaultEnumObject != null && theEnum.getIndex() == defaultEnumObject.getIndex()) {
				selected =" selected";
			}
			drop_downText.append("<option value=" + theEnum.getIndex() + selected + ">" + theEnum.getName() + "</option>\n");
		}
		return drop_downText.toString();
	}
	
	public static <T extends Enum & IntegerValuedEnum> String getDrop_down(Class<T> enumClass, String defaultIndex) {
		if (enumClass == null) {
			return "";
		}
		return getDrop_downByEnum(enumClass, valueOf(enumClass, defaultIndex));
	}
	
	public static <T extends Enum & IntegerValuedEnum> String getDrop_down(Class<T> enumClass) {
		if (enumClass == null) {
			return "";
		}
		return getDrop_downByEnum(enumClass, null);
	}
	

	
	public static <T extends Enum & IntegerValuedEnum> T valueOf(Class<T> enumClass, int index) {
		if (enumClass == null) {
			return null;
		}
		for (IntegerValuedEnum theEnum : enumClass.getEnumConstants()) {
			if (theEnum.getIndex() == index) {
				return (T)theEnum;
			}
		}
		return null;
	}
	
	public static <T extends Enum & IntegerValuedEnum> T valueOf(Class<T> enumClass, String index) {
		if (enumClass == null) {
			return null;
		}
		Integer indexInt = Integer.valueOf(index);
		return valueOf(enumClass, indexInt);
	}
}
    

