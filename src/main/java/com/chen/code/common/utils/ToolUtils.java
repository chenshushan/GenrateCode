package com.chen.code.common.utils;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Administrator on 2017/11/18.
 */
public class ToolUtils {
	private ToolUtils() {
	}
	/**
	 * 获取指定集合的大小；
	 */
	public final static int size(List list) {
		if (isEmpty(list))
			return 0;
		else
			return list.size();
	}
	public final static int size(String str) {
		if (isEmpty(str))
			return 0;
		else
			return str.length();
	}
	public final static int size(Set set) {
		if (isEmpty(set))
			return 0;
		else
			return set.size();
	}
	public final static int size(Map map) {
		if (isEmpty(map))
			return 0;
		else
			return map.size();
	}
	public final static int size(String[] array) {
		if (isEmpty(array))
			return 0;
		else
			return array.length;
	}
	/**
	 * 判断一个对象是否为空；
	 */
	public final static boolean isEmpty(Object o) {
		return (o == null);
	}



	/**
	 * 检测某个字符变量是否为空；<br>
	 * 为空的情况，包括：null，空串或只包含可以被 trim() 的字符；
	 */
	public final static boolean isEmpty(String value) {
		if (value == null || value.trim().length() == 0)
			return true;
		else
			return false;
	}
	public final static boolean isNotEmpty(String value) {
		return !isEmpty(value);
	}
	public final static boolean isNotEmpty(String[] value) {
		return !isEmpty(value);
	}
	public final static boolean isNotEmpty(int[] value) {
		return !isEmpty(value);
	}
	public final static boolean isNotEmpty(StringBuffer value) {
		return !isEmpty(value);
	}
	public final static boolean isNotEmpty(List value) {
		return !isEmpty(value);
	}
	public final static boolean isNotEmpty(Set value) {
		return !isEmpty(value);
	}
	public final static boolean isNotEmpty(Map value) {
		return !isEmpty(value);
	}
	public final static boolean isEmpty(String[] array) {
		if (array == null || array.length == 0)
			return true;
		else
			return false;
	}
	public final static boolean isEmpty(int[] array) {
		if (array == null || array.length == 0)
			return true;
		else
			return false;
	}
	public final static boolean isEmpty(StringBuffer sb) {
		if (sb == null || sb.length() == 0)
			return true;
		else
			return false;
	}
	public final static boolean isEmpty(List list) {
		if (list == null || list.size() == 0)
			return true;
		else
			return false;
	}
	public final static boolean isEmpty(Set set) {
		if (set == null || set.size() == 0)
			return true;
		else
			return false;
	}
	public final static boolean isEmpty(Map map) {
		if (map == null || map.size() == 0)
			return true;
		else
			return false;
	}
	public static boolean isEmpty(Date date) {
		if(date == null){
			return true;
		}else {
			return false;
		}
	}

	/**
	 * 格式化字符串显示；
	 */
	public final static String format(String value) {
		return format(value, "");
	}
	public final static String format(String value, String defaultValue) {
		if (isEmpty(value))
			return defaultValue;
		else
			return value.trim();
	}


	/**
	 * 格式化double型数据为String
	 */
	public final static String format(double value) {
		return format(value, "");
	}
	public final static String format(float value) {
		return format(value, 2);
	}
	public final static String format(float value, int minnum) {
		NumberFormat nbf = NumberFormat.getInstance();
		nbf.setMinimumFractionDigits(minnum);
		nbf.setMaximumFractionDigits(minnum);
		nbf.setGroupingUsed(false);
		return nbf.format(value);
	}
	public final static BigDecimal parseBig(BigDecimal value) {
		return new BigDecimal(format(value, 2, false));
	}
	/**
	 * 将一个bigDecimal的数值，按照固定的小数位进行格式化并返回
	 *
	 * @param value
	 * @param minnum
	 * @return
	 */
	public final static BigDecimal parseBig(BigDecimal value, int minnum) {
		return new BigDecimal(format(value, minnum, false));
	}
	public final static String formatBig(BigDecimal value, int minnum) {
		return format(value, minnum, false);
	}

	public final static String format(BigDecimal value, int minnum, boolean b) {
		if (value == null) {
			return "0.00";
		}
		NumberFormat nbf = NumberFormat.getInstance();
		nbf.setMinimumFractionDigits(minnum);
		nbf.setMaximumFractionDigits(minnum);
		nbf.setGroupingUsed(b);
		nbf.setRoundingMode(RoundingMode.HALF_UP);
		return nbf.format(value);
	}
	public final static BigDecimal format(BigDecimal big) {
		if (big == null) {
			return BigDecimal.ZERO;
		} else {
			return big;
		}
	}
	/**
	 * 格式化double型数据为String
	 */
	public final static String format(double value, String defaultValue) {
		String v = String.valueOf(value);
		if (isEmpty(v))
			return defaultValue;
		else
			return v.trim();
	}

	/**
	 * 检测变量的值是否为一个整型数据；
	 */
	public final static boolean isInt(String value) {
		if (isEmpty(value))
			return false;
		try {
			Integer.parseInt(value);
		} catch (NumberFormatException e) {
			return false;
		}
		return true;
	}
	/**
	 * 判断变量的值是否为double类型
	 */
	public final static boolean isDouble(String value) {
		if (isEmpty(value))
			return false;
		try {
			Double.parseDouble(value);
		} catch (NumberFormatException e) {
			return false;
		}
		return true;
	}
	/**
	 * 判断变量的值是否为float类型
	 */
	public final static boolean isFloat(String value) {
		if (isEmpty(value))
			return false;
		try {
			Float.parseFloat(value);
		} catch (NumberFormatException e) {
			return false;
		}
		return true;
	}
	/**
	 * 解析一个字符串为整数；
	 */
	public final static int parseInt(String value) {
		if (isInt(value))
			return Integer.parseInt(value);
		return 0;
	}
	public final static int parseInt(String value, int defaultValue) {
		if (isInt(value))
			return Integer.parseInt(value);
		return defaultValue;
	}
	/**
	 * 解析一个字符串为double
	 */
	public final static double parseDouble(String value) {
		if (isDouble(value))
			return Double.parseDouble(value);
		return 0;
	}
	public final static double parseDouble(String value, double defaultValue) {
		if (isDouble(value))
			return Double.parseDouble(value);
		return defaultValue;
	}
	/**
	 * 解析一个字符串为float
	 */
	public final static float parseFloat(String value) {
		if (isFloat(value))
			return Float.parseFloat(value);
		return 0;
	}
	public final static float parseFloat(String value, float defaultValue) {
		if (isFloat(value))
			return Float.parseFloat(value);
		return defaultValue;
	}


	/**
	 * 解析日期
	 *
	 * @param source
	 * @return Date
	 * @throws Exception
	 */
	public final static Date parseDate(String source)  {
		if (isEmpty(source)) {
			return null;
		}
		String dateStr = source.trim().replaceAll("/|:|\\.", "-");
		DateTimeFormatter formatter;
		LocalDateTime localDateTime;
		if (dateStr.length() > 10) {
			formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH-mm-ss");
			localDateTime = LocalDateTime.parse(dateStr, formatter);
		} else {
			formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate localDate = LocalDate.parse(dateStr, formatter);
			localDateTime = localDate.atStartOfDay();
		}
		return localDateTimeToDate(localDateTime);
	}


	// 01. java.util.Date --> java.time.LocalDateTime
	public static LocalDateTime dateToLocalDateTime(Date date) {
		if(date == null){
			return null;
		}
		Instant instant = date.toInstant();
		ZoneId zone = ZoneId.systemDefault();
		LocalDateTime localDateTime = LocalDateTime.ofInstant(instant, zone);
		return localDateTime;
	}
	public static LocalDate dateToLocalDate(Date date) {
		if(date == null){
			return null;
		}
		return dateToLocalDateTime(date).toLocalDate();
	}



	// 04. java.time.LocalDateTime --> java.util.Date
	public static Date localDateTimeToDate(LocalDateTime localDateTime) {
		if(localDateTime == null){
			return null;
		}
		ZoneId zone = ZoneId.systemDefault();
		Instant instant = localDateTime.atZone(zone).toInstant();
		Date date = Date.from(instant);
		return date;
	}
	public static Date localDateToDate(LocalDate localDate) {
		if(localDate == null){
			return null;
		}
		LocalDateTime localDateTime = localDate.atStartOfDay();
		return localDateTimeToDate(localDateTime);
	}




	/**
	 * 格式化日期时间字符串显示；
	 */
	public final static String formatDate(Date date) {
		return formatDateTime("yyyy-MM-dd", date, null);
	}
	public final static String formatDate(Date date, String defaultValue) {
		return formatDateTime("yyyy-MM-dd", date, defaultValue);
	}
	public final static String formatDateTime(Date date) {
		return formatDateTime("yyyy-MM-dd HH:mm:ss", date, null);
	}
	public final static String formatDateTime(String style, Date date) {
		return formatDateTime(style, date, null);
	}
	public final static String formatDateTime(String style, Date date, String defaultValue) {
		if (isEmpty(style) || isEmpty(date))
			return defaultValue;
		LocalDateTime localDateTime = dateToLocalDateTime(date);
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern(style);
		return localDateTime.format(dateTimeFormatter);
	}


	/**
	 * 生成一个随机数字；
	 */
	public final static int getRandomNumber(int max) {
		return getRandomNumber(0, max);
	}
	public final static int getRandomNumber(int min, int max) {
		if (min > max) {
			int k = min;
			min = max;
			max = k;
		}
		Random random = new Random();
		return (random.nextInt(max - min) + min);
	}
	/**
	 * 从指定的字符列表中生成随机字符串
	 */
	public final static String getRandomString(int length) {
		final String[] s = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "m", "n", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "D", "E", "F", "G", "H", "J", "L", "M", "N", "Q", "R", "T", "Y"};
		if (length < 1)
			return "";
		StringBuffer sb = new StringBuffer(length);
		for (int i = 0; i < length; i++) {
			int position = getRandomNumber(s.length - 1);
			Collections.shuffle(Arrays.asList(s));
			sb.append(s[position]);
		}
		return sb.toString();
	}


	/**
	 * 判断一个字符串是否是数字
	 *
	 * @param string
	 * @return boolean
	 */
	public static boolean isLong(String string) {
		try {
			long l = Long.parseLong(string);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	/**
	 * 任意类型转换BigDecimal类型
	 */
	public static BigDecimal parseBigDecimal(String num) {
		BigDecimal bd =BigDecimal.ZERO;
		try {
			num = ToolUtils.format(num);
			if (num == null || num.equals("")) {
				return bd;
			}
			bd = new BigDecimal(ToolUtils.formatBig(new BigDecimal(num), 2));
		} catch (RuntimeException e) {
			return bd;
		}
		return bd;
	}
	public static BigDecimal parseBigDecimal(int num) {
		BigDecimal bd = BigDecimal.ZERO;
		try {
			bd = new BigDecimal(ToolUtils.formatBig(new BigDecimal(num), 2));
		} catch (RuntimeException e) {
			return bd;
		}
		return bd;
	}
	public static BigDecimal parseBigDecimal(double num) {
		BigDecimal bd = BigDecimal.ZERO;
		try {
			bd = new BigDecimal(ToolUtils.formatBig(new BigDecimal(num), 2));
		} catch (RuntimeException e) {
			return bd;
		}
		return bd;
	}
	public static BigDecimal parseBigDecimal(float num) {
		BigDecimal bd = BigDecimal.ZERO;
		try {
			bd = new BigDecimal(ToolUtils.formatBig(new BigDecimal(num), 2));
		} catch (RuntimeException e) {
			return bd;
		}

		return bd;
	}
	public static BigDecimal parseBigDecimal(long num) {
		BigDecimal bd = BigDecimal.ZERO;
		try {
			bd = new BigDecimal(ToolUtils.formatBig(new BigDecimal(num), 2));
		} catch (RuntimeException e) {
			return bd;
		}
		return bd;
	}

	/**
	 * 计算出一个字符串公式的结果
	 *
	 * @param expression
	 * @return
	 * @throws ScriptException
	 */
	public static String caculate(String expression) throws ScriptException {
		ScriptEngineManager manager = new ScriptEngineManager();
		ScriptEngine engine = manager.getEngineByName("js");
		Object result = engine.eval(expression);
		return String.valueOf(result);
	}
	/**
	 * 数字金额大写转换，思想先写个完整的然后将如零拾替换成零
	 * 要用到正则表达式
	 */
	public static String moneyToUppercase(double n) {
		String fraction[] = {"角", "分"};
		String digit[] = {"零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖"};
		String unit[][] = {{"元", "万", "亿"},
				{"", "拾", "佰", "仟"}};
		String head = n < 0 ? "负" : "";
		n = Math.abs(n);
		String[] split = Double.valueOf(n).toString().split("\\.");
		String s = "";
		if(split.length<2){
			s = "整";
		}else{
			String decimal = split[1];//小数部分
			//如果小数部分小于10
			if(decimal.startsWith("0")){
				s=digit[Integer.valueOf(decimal)]+"分";
			}else {
				String str = digit[Integer.valueOf(decimal.substring(0, 1))];
				if(decimal.length()>1){
					s=new StringBuilder(str).append("角").append(digit[Integer.valueOf(decimal.substring(1,2))]).append("分").toString();
				}else{
					s=new StringBuilder(str).append("角").toString();
				}
			}
		}
		if("零分".equals(s)){
			s = "整";
		}
		int integerPart = (int) Math.floor(n);
		for (int i = 0; i < unit[0].length && integerPart > 0; i++) {
			String p = "";
			for (int j = 0; j < unit[1].length && n > 0; j++) {
				p = digit[integerPart % 10] + unit[1][j] + p;
				integerPart = integerPart / 10;
			}
			s = p.replaceAll("(零.)*零$", "").replaceAll("^$", "零") + unit[0][i] + s;
		}
		return head + s.replaceAll("(零.)*零元", "元").replaceFirst("(零.)+", "").replaceAll("(零.)+", "零").replaceAll("^整$", "零元整");
	}
	public static boolean isContainChinese(String str) {
		Pattern p = Pattern.compile("[\u4e00-\u9fa5]");
		Matcher m = p.matcher(str);
		if (m.find()) {
			return true;
		}
		return false;
	}
	/** 根据路径创建目录或者文件
	 * @param path
	 * @throws IOException
	 */
	public static File createFileOrDir(String path) throws IOException {
		File file = new File(path);
		File dir;
//      如果是文件 则得到所在目录
		if(file.isDirectory()){
			dir=file;
		}else{
			dir = file.getParentFile();
		}
		if(!dir.exists()){
			dir.mkdirs();
		}
		if(file.isFile()){
			file.createNewFile();
		}
		return file;
	}

	/**
	 * 将驼峰式命名的字符串转换为下划线大写方式。如果转换前的驼峰式命名的字符串为空，则返回空字符串。</br>
	 * 例如：HelloWorld->HELLO_WORLD
	 * @param name 转换前的驼峰式命名的字符串
	 * @return 转换后下划线大写方式命名的字符串
	 */
	public static String underscoreName(String name) {
		StringBuilder result = new StringBuilder();
		if (name != null && name.length() > 0) {
			// 将第一个字符处理成大写
			result.append(name.substring(0, 1).toUpperCase());
			// 循环处理其余字符
			for (int i = 1; i < name.length(); i++) {
				String s = name.substring(i, i + 1);
				// 在大写字母前添加下划线
				if (s.equals(s.toUpperCase()) && !Character.isDigit(s.charAt(0))) {
					result.append("_");
				}
				// 其他字符直接转成大写
				result.append(s.toUpperCase());
			}
		}
		return result.toString();
	}

	/**
	 * 将下划线大写方式命名的字符串转换为驼峰式。如果转换前的下划线大写方式命名的字符串为空，则返回空字符串。</br>
	 * 例如：HELLO_WORLD->HelloWorld
	 * @param name 转换前的下划线大写方式命名的字符串
	 * @return 转换后的驼峰式命名的字符串
	 */
	public static String camelName(String name) {
		StringBuilder result = new StringBuilder();
		// 快速检查
		if (name == null || name.isEmpty()) {
			// 没必要转换
			return "";
		} else if (!name.contains("_")) {
			// 不含下划线，仅将首字母小写
			return name.substring(0, 1).toLowerCase() + name.substring(1);
		}
		// 用下划线将原始字符串分割
		String camels[] = name.split("_");
		for (String camel :  camels) {
			// 跳过原始字符串中开头、结尾的下换线或双重下划线
			if (camel.isEmpty()) {
				continue;
			}
			// 处理真正的驼峰片段
			if (result.length() == 0) {
				// 第一个驼峰片段，全部字母都小写
				result.append(camel.toLowerCase());
			} else {
				// 其他的驼峰片段，首字母大写
				result.append(camel.substring(0, 1).toUpperCase());
				result.append(camel.substring(1).toLowerCase());
			}
		}
		return result.toString();
	}

}

