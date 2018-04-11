package com.chen.code.common;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.text.ParseException;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;

/**
 * Created by Administrator on 2017/11/26.
 */
public class TypeHashMap<K,V> extends HashMap {
	public  String getString(Object key) {
		Object answer = this.get(key);
		if(answer != null) {
			return answer.toString();
		}
		return null;
	}
	public Date getDate(Object key) {
		LocalDateTime localDateTime = getLocalDateTime(key);
		if(localDateTime == null){
			return null;
		}
		ZoneId zone = ZoneId.systemDefault();
		Instant instant = localDateTime.atZone(zone).toInstant();
		Date date = Date.from(instant);
		return date;
	}
	public LocalDateTime getLocalDateTime(Object key) {
		String answer = getString(key);
		if(answer == null) {
			return null;
		}
		String value = answer.trim().replaceAll("/|:|\\.", "-");
		if(value.length()<10){
			value = new StringBuilder(answer).append(" 00-00-00").toString();
		}
		LocalDateTime localDateTime = LocalDateTime.parse(value, DateTimeFormatter.ofPattern("yyyy-MM-dd HH-mm-ss"));
		return localDateTime;
	}
	public LocalDate getLocalDate(Object key) {
		String answer = getString(key);
		if(answer == null) {
			return null;
		}
		String value = answer.trim().replaceAll("/|:|\\.", "-").substring(0,10);
		LocalDate localDate = LocalDate.parse(value);
		return localDate;
	}


	public  Boolean getBoolean(Object key) {
		Object answer = this.get(key);
		if(answer != null) {
			if(answer instanceof Boolean) {
				return (Boolean)answer;
			}

			if(answer instanceof String) {
				return new Boolean((String)answer);
			}
		}

		return null;
	}

	public  Number getNumber(Object key) {
		Object answer = this.get(key);
		if(answer != null) {
			if(answer instanceof Number) {
				return (Number)answer;
			}

			if(answer instanceof String) {
				try {
					String text = (String)answer;
					return NumberFormat.getInstance().parse(text);
				} catch (ParseException var4) {

				}
			}
		}

		return null;
	}

	public  Byte getByte(Object key) {
		Number answer = getNumber( key);
		return answer == null?null:(answer instanceof Byte?(Byte)answer:new Byte(answer.byteValue()));
	}

	public  Short getShort(Object key) {
		Number answer = getNumber(key);
		return answer == null?null:(answer instanceof Short?(Short)answer:new Short(answer.shortValue()));
	}

	public  Integer getInteger(Object key) {
		Number answer = getNumber(key);
		return answer == null?null:(answer instanceof Integer?(Integer)answer:new Integer(answer.intValue()));
	}

    public  Long getLong(Object key) {
        Number answer = getNumber(key);
        return answer == null?null:(answer instanceof Long?(Long)answer:new Long(answer.longValue()));
    }

    public  Float getFloat(Object key) {
        Number answer = getNumber(key);
        return answer == null?null:(answer instanceof Float?(Float)answer:new Float(answer.floatValue()));
    }

    public  Double getDouble(Object key) {
        Number answer = getNumber(key);
        return answer == null?null:(answer instanceof Double?(Double)answer:new Double(answer.doubleValue()));
    }

	public BigDecimal getBigDecimal(Object key) {
		Number answer = getNumber(key);
		return answer == null?null:(answer instanceof BigDecimal?(BigDecimal)answer:new BigDecimal(answer.toString()));
	}

}
