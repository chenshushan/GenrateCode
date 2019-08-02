package com.chen.code.common.utils;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

/**
 * Created by 陈书山 on 2017/2/22.
 */
public class PinyinTool {
	private static HanyuPinyinOutputFormat format = null;
	public static enum Type {
		UPPERCASE,              //全部大写
		LOWERCASE,              //全部小写
		FIRSTUPPER              //首字母大写
	}

	static {
		format = new HanyuPinyinOutputFormat();
		format.setCaseType(HanyuPinyinCaseType.UPPERCASE);
		format.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
	}

	public static String toPinYinUpper(String str) throws BadHanyuPinyinOutputFormatCombination {
		return toPinYin(str, "", Type.UPPERCASE);
	}
	public static String toPinYinLower(String str) throws BadHanyuPinyinOutputFormatCombination {
		return toPinYin(str, "", Type.LOWERCASE);
	}
	public static String toPinYinFirstUpper(String str) throws BadHanyuPinyinOutputFormatCombination {
		return toPinYin(str, "", Type.FIRSTUPPER);
	}

	public static String toPinYin(String str,String spera) throws BadHanyuPinyinOutputFormatCombination{
		return toPinYin(str, spera, Type.UPPERCASE);
	}

	/**
	 * 将str转换成拼音，如果不是汉字或者没有对应的拼音，则不作转换
	 * 如： 明天 转换成 MINGTIAN
	 * @param str
	 * @param spera
	 * @return
	 * @throws BadHanyuPinyinOutputFormatCombination
	 */
	public static String toPinYin(String str, String spera, Type type) throws BadHanyuPinyinOutputFormatCombination {
		if(str == null || str.trim().length()==0)
			return "";
		if(type == Type.UPPERCASE)
			format.setCaseType(HanyuPinyinCaseType.UPPERCASE);
		else
			format.setCaseType(HanyuPinyinCaseType.LOWERCASE);

		String py = "";
		String temp = "";
		String[] t;
		for(int i=0;i<str.length();i++){
			char c = str.charAt(i);
			if((int)c <= 128)
				py += c;
			else{
				t = PinyinHelper.toHanyuPinyinStringArray(c, format);
				if(t == null)
					py += c;
				else{
					temp = t[0];
					if(type == Type.FIRSTUPPER)
						temp = t[0].toUpperCase().charAt(0)+temp.substring(1);
					py += temp+(i==str.length()-1?"":spera);
				}
			}
		}
		return py.trim();
	}

	/**
	 * 获取汉字串拼音首字母，英文字符不变
	 * @param chinese 汉字串
	 * @return 汉语拼音首字母
	 */
	public static   String getFirstSpell(String chinese) {
		StringBuffer pybf = new StringBuffer();
		char[] arr = chinese.toCharArray();
		for (int i = 0; i < arr.length; i++) {
			if (arr[i] > 128) {
				try {
					String[] temp = PinyinHelper.toHanyuPinyinStringArray(arr[i], format);
					if (temp != null) {
						pybf.append(temp[0].charAt(0));
					}
				} catch (BadHanyuPinyinOutputFormatCombination e) {
					e.printStackTrace();
				}
			} else {
				pybf.append(arr[i]);
			}
		}
		return pybf.toString().replaceAll("\\W", "").trim();
	}

	public static void main(String[] args) throws BadHanyuPinyinOutputFormatCombination {
		System.out.println(PinyinTool.toPinYinLower("单期报表-国联广告2017-10-19-18-02-13.rar"));
		System.out.println(PinyinTool.toPinYin("陈书山","_"));
		System.out.println(PinyinTool.toPinYin("      负债及所有者权益（或股东权益）总计", "_", Type.FIRSTUPPER));
		System.out.println(PinyinTool.getFirstSpell("陈书山"));
	}

}
