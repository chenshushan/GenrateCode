package com.chen.code.common.gen;

import java.util.List;
import java.util.Map;
import java.util.zip.ZipOutputStream;

/**
 * 代码生成器   工具类
 * 使用velocity生成
 */
public class VelocityGen extends BaseGenerator {

	/**
	 * 生成代码
	 */
	public static void generatorCode(Map<String, String> table,List<Map> columns, ZipOutputStream zip){
//		Map map = init(table,columns);
//		//设置velocity资源加载器
//		Properties prop = new Properties();
//		prop.put("file.resource.loader.class", "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");
//		Velocity.init(prop);
//		VelocityContext context = new VelocityContext(map);
//        //获取模板列表
//		List<String> templates = getTemplates();
//		for(String template : templates){
//			//渲染模板
//			StringWriter sw = new StringWriter();
//			Template tpl = Velocity.getTemplate(template, "UTF-8");
//			tpl.merge(context, sw);
//			try {
//				//添加到zip
//				zip.putNextEntry(new ZipEntry(getFileName(template,map.get("className").toString(), getConfig().getString("package"))));
//				IOUtils.write(sw.toString(), zip, "UTF-8");
//				IOUtils.closeQuietly(sw);
//				zip.closeEntry();
//			} catch (IOException e) {
//				throw new RuntimeException("渲染模板失败，表名：" + map.get("tableName").toString(), e);
//			}
//		}
	}
}
