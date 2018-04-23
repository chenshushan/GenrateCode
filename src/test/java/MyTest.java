import cn.hutool.core.io.FileUtil;
import com.chen.code.entity.Template;
import com.chen.code.entity.User;
import com.chen.code.entity.enumdo.EnumBaseStatus;
import com.google.common.base.CaseFormat;
import com.google.common.base.CharMatcher;
import com.google.common.io.Files;
import org.junit.Test;

import java.io.File;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import static com.chen.code.controller.BaseController.copyProperties;

/**
 * Created by Administrator on 2017/11/20.
 */
public class MyTest {

	@Test
	public void beanTest() {

		String nameWithoutExtension = Files.getNameWithoutExtension("model/siteqi/Controller.java.ftl");
		System.out.println(nameWithoutExtension);

		System.out.println(Arrays.toString("1.1.1".split("\\.")));
//		GenField field = new GenField();
//		field.setCreatedTime(new Date());
//		field.setDescription("123");
//		field.setIfNull("1");
//		GenEntity genEntity = new GenEntity();
//		genEntity.setClassName("231");
//
//		field.setTable(genEntity);
//		GenField genField = new GenField();
//		genField.setIfNull("0");
//		BeanMapper.copy(field,genField);
//		System.out.println(genField);



		Template template = new Template();
		template.setTemplateName("css");
		template.setTemplatePath("path");
		template.setUploadTime(LocalDate.now());
		LocalDateTime now = LocalDateTime.now();
		template.setCreatedTime(now);
		template.setStatus(EnumBaseStatus.NORMAL);
		template.setModifiedCount(0);
		User user = new User();
		user.setId(1);
		template.setAddUser(user);
		Template target = new Template();

		copyProperties(template,target);
		System.out.println(target);

	}

	@Test
	public void charMatcherTest() throws ParseException {
		boolean b = CharMatcher.digit().matchesAllOf("123");
		System.out.println(b);
		b = CharMatcher.digit().matchesAllOf("@");
		System.out.println(b);

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	}

	@Test
	public void test(){
//		Map<String, String> maps = JDBCUtils.queryTable("tb_user");
//		System.out.println(maps);
		String tableName = CaseFormat.UPPER_CAMEL.to(CaseFormat.LOWER_UNDERSCORE, "MyTest");
		System.out.println(tableName);


		Map map=new HashMap();
		String key = (String)map.get("key");
		System.out.println(key);
		map.put("key",1);
		BigDecimal bigDecimal = (BigDecimal) map.get("key");
		System.out.println(bigDecimal);
	}

	/**
	 *   () 是为了提取匹配的字符串。表达式中有几个()就有几个相应的匹配字符串。(\s*)表示连续空格的字符串。
		 []是定义匹配的字符范围。比如 [a-zA-Z0-9] 表示相应位置的字符要匹配英文字符和数字。
		 {}一般用来表示匹配的长度，比如 \s{3} 表示匹配三个空格，\s[1,3]表示匹配一到三个空格。

	 	 \d{4}(\-|\/|.)\d{1,2}\1\d{1,2}   \1必须与小括号配合使用,正则表达式中的小括号"()"。是代表分组的意思。 如果再其后面出现\1则是代表与第一个小括号中要匹配的内容相同
	 */
	@Test
	public void dateTest(){

		String[] split = "1,2,3,".split(",");
		System.out.println(split.length);
		System.out.println(Arrays.toString(split));

	}


}
