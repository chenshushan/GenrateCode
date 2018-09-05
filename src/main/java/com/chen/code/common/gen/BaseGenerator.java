package com.chen.code.common.gen;

import com.chen.code.entity.GenField;
import com.chen.code.entity.GenEntity;
import com.chen.code.entity.enumdo.EnumJavaType;
import com.chen.code.entity.vo.ColumnEntity;
import com.chen.code.entity.vo.TableEntity;
import com.google.common.base.CaseFormat;
import com.google.common.io.Files;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.WordUtils;

import java.io.File;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by Administrator on 2017/11/19.
 */
public abstract class BaseGenerator {
	protected static final String PROJECT_PATH = System.getProperty("user.dir");//项目在硬盘上的基础路径

	private static  Configuration configuration = null;

	public static final Map<String,EnumJavaType> javaTypeMap = new HashMap();

	static {
		javaTypeMap.put("Integer", EnumJavaType.Intger);
		javaTypeMap.put("Long", EnumJavaType.Long);
		javaTypeMap.put("Float", EnumJavaType.Float);
		javaTypeMap.put("BigDecimal", EnumJavaType.BigDecimal);
		javaTypeMap.put("String", EnumJavaType.String);
		javaTypeMap.put("Date", EnumJavaType.Date);
		javaTypeMap.put("Double", EnumJavaType.Double);
		javaTypeMap.put("Boolean", EnumJavaType.Boolean);
		javaTypeMap.put("Reference", EnumJavaType.Reference);
		try {
			configuration = new PropertiesConfiguration("generator.properties");
		} catch (ConfigurationException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获取配置信息
	 */
	public static final Configuration getConfig(){
		return configuration;
	}


	public static Map init(GenEntity table){
		// 表信息
		TableEntity tableEntity = new TableEntity();
		// 表名
		String className = table.getClassName();
		// 类名
		tableEntity.setClassName(StringUtils.capitalize(className));
		// 类名首字母小写
		tableEntity.setClassname(StringUtils.uncapitalize(className));
		// 配置信息
		Configuration config = getConfig();
		String tablePrefix = config.getString("tablePrefix");
		String tableName = table.getTableName();
		if(StringUtils.isEmpty(tableName)){
			// 表名
			tableEntity.setTableName(tablePrefix + className);
		}else {
			tableEntity.setTableName(tableName);
		}
		// 备注
		String remark = table.getRemark();
		tableEntity.setComments(remark);
		int index = table.getUseCache().getIndex();
		tableEntity.setIfCache(String.valueOf(index));

		//列信息
		Set<GenField> fields = table.getFields();
		List<ColumnEntity> columsList = fields.stream().map(field -> {
			ColumnEntity columnEntity = new ColumnEntity();
			String fieldName = field.getFieldName();
			// 属性名
			columnEntity.setAttrName(StringUtils.capitalize(fieldName));
			// 属性名首字母小写
			String attrname = StringUtils.uncapitalize(fieldName);
			columnEntity.setAttrname(attrname);
			// 列名
			String columnName = field.getColumnName();
			boolean notEmpty = StringUtils.isNotEmpty(columnName);
			if(notEmpty){
				attrname = columnName;
			}

			columnEntity.setColumnName(attrname);

			EnumJavaType javaFieldType = field.getJavaFieldType();
			columnEntity.setDataType(javaFieldType.getDescription());
			// Java类型
			columnEntity.setAttrType(javaFieldType.getName());
//			引用类型 实体类型
			columnEntity.setReference(field.getReference());

			columnEntity.setComments(field.getDescription());

//			columnEntity.setExtra(extra);

			String fieldLength = field.getFieldLength();
			fieldLength = Optional.ofNullable(fieldLength).orElse("200");
			columnEntity.setFieldLength(fieldLength);

			columnEntity.setIfSearch(field.getIfSearch().getIndex() + "");
			columnEntity.setIfShow(field.getIfShow().getIndex() + "");
			columnEntity.setIfNull(field.getIfNull().getIndex() + "");
			return columnEntity;
		}).collect(Collectors.toList());
		tableEntity.setColumns(columsList);
		return  assemble(tableEntity);
	}



	/** 初始化模板生成所需要的数据
	 * @param table
	 * @param columns
	 */
	public static Map<String, Object> init(Map<String, String> table, List<Map> columns){
		// 配置信息
		Configuration config = getConfig();

		// 表信息
		TableEntity tableEntity = new TableEntity();
		// 表名
		String tableName = table.get("tableName");
		tableEntity.setTableName(tableName);
		// 备注
		String tableComment = table.get("tableComment");
		tableEntity.setComments(tableComment);
		// 表名转换成Java类名
		String className = tableToJava(tableEntity.getTableName(), config.getString("tablePrefix"));
//		类名
		tableEntity.setClassName(className);
//		类名首字母小写
		tableEntity.setClassname(StringUtils.uncapitalize(className));

		String useCache = table.get("useCache");
		tableEntity.setIfCache(useCache);

		//列信息
		List<ColumnEntity> columsList = columns.stream().map(column -> {
			ColumnEntity columnEntity = new ColumnEntity();
//			列名
			String columnName = MapUtils.getString(column, "columnName");
			columnEntity.setColumnName(columnName);
			//列名转换成Java属性名
			String attrName = columnToJava(columnName);
			columnEntity.setAttrName(attrName);
//			属性名首字母小写
			columnEntity.setAttrname(StringUtils.uncapitalize(attrName));

			String dataType = MapUtils.getString(column, "dataType");
			columnEntity.setDataType(dataType);
			String attrType = config.getString(dataType, "unknowType");
			//列的数据类型，转换成Java类型
			columnEntity.setAttrType(attrType);
//			引用类型 实体类型
			String reference = MapUtils.getString(column, "reference");
			columnEntity.setReference(reference);

			String columnComment = MapUtils.getString(column, "columnComment");
			columnEntity.setComments(columnComment);

			String extra = MapUtils.getString(column, "extra");
			columnEntity.setExtra(extra);

			String length = MapUtils.getString(column, "len");
			columnEntity.setFieldLength(length);

			String ifSearch = MapUtils.getString(column, "ifSearch");
			columnEntity.setIfSearch(ifSearch);
			String ifShow = MapUtils.getString(column, "ifShow");
			columnEntity.setIfShow(ifShow);
			String ifNull = MapUtils.getString(column, "ifNull");
			columnEntity.setIfNull(Optional.ofNullable(ifNull).orElse(""));

			//是否主键
			String columnKey = MapUtils.getString(column, "columnKey");
			if ("PRI".equalsIgnoreCase(columnKey) && tableEntity.getPk() == null) {
				tableEntity.setPk(columnEntity);
			}
			return columnEntity;
		}).collect(Collectors.toList());

		tableEntity.setColumns(columsList);

		//没主键，则第一个字段为主键
		if(tableEntity.getPk() == null){
//			构造一个主键
//			tableEntity.setPk(tableEntity.getColumns().get(0));
		}

		//封装模板数据

		return assemble(tableEntity);
	}

	public static Map assemble(TableEntity tableEntity){
		Map<String, Object> map = new HashMap<>();
		map.put("tableName", tableEntity.getTableName());
		map.put("comments", tableEntity.getComments());
		map.put("pk", tableEntity.getPk());
		map.put("className", tableEntity.getClassName());
		map.put("classname", tableEntity.getClassname());
		map.put("columns", tableEntity.getColumns());
		map.put("author", "generator");
		map.put("datetime", LocalDate.now().toString());
		map.put("ifCache",tableEntity.getIfCache());
		return map;
	}

	public static List<String> getTemplates(){
		List<String> templates = new ArrayList();
		templates.add("model/add.html.ftl");
		templates.add("model/Controller.java.ftl");
		templates.add("model/Dao.java.ftl");

		templates.add("model/Entity.java.ftl");
		templates.add("model/info.js.ftl");
		templates.add("model/list.html.ftl");

		templates.add("model/list.js.ftl");
		templates.add("model/menu.sql.ftl");

		templates.add("model/modi.html.ftl");
		templates.add("model/Service.java.ftl");
		templates.add("model/ServiceImpl.java.ftl");

//		templates.add("model/siteqi/Controller.java.ftl");
//		templates.add("model/siteqi/ControllerRS.java.ftl");
//		templates.add("model/siteqi/edit.html.ftl");
//		templates.add("model/siteqi/edit.js.ftl");
//		templates.add("model/siteqi/list.html.ftl");
//		templates.add("model/siteqi/list.js.ftl");
//
//		templates.add("model/siteqi/menu.sql.ftl");
//		templates.add("model/siteqi/Service.java.ftl");
//		templates.add("model/siteqi/ServiceImpl.java.ftl");

		return templates;
	}


	/**
	 * 列名转换成Java属性名
	 */
	public static final String columnToJava(String columnName) {
		return WordUtils.capitalizeFully(columnName, new char[]{'_'}).replace("_", "");
	}

	/**
	 * 表名转换成Java类名
	 */
	public static final String tableToJava(String tableName, String tablePrefix) {
		if(StringUtils.isNotBlank(tablePrefix)){
			tableName = tableName.replace(tablePrefix, "");
		}
		return columnToJava(tableName);
	}


	protected static String tableNameConvertLowerCamel(String tableName) {
		return CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.LOWER_CAMEL, tableName.toLowerCase());
	}

	protected static String tableNameConvertUpperCamel(String tableName) {
		return CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.UPPER_CAMEL, tableName.toLowerCase());

	}

	protected static String tableNameConvertMappingPath(String tableName) {
		tableName = tableName.toLowerCase();//兼容使用大写的表名
		return "/" + (tableName.contains("_") ? tableName.replaceAll("_", "/") : tableName);
	}

	protected static String modelNameConvertMappingPath(String modelName) {
		String tableName = modelNameToLowerUnderscore(modelName);
		return tableNameConvertMappingPath(tableName);
	}

	protected static String modelNameToLowerUnderscore(String modelName) {
		String tableName = CaseFormat.UPPER_CAMEL.to(CaseFormat.LOWER_UNDERSCORE, modelName);
		return tableName;
	}

	protected static String packageConvertPath(String packageName) {
		return String.format("/%s/", packageName.contains(".") ? packageName.replaceAll("\\.", "/") : packageName);
	}


	/**
	 * 获取文件名
	 */
	public static String getFileName(String template, String className, String packageName){
		String packagePath = "java" + File.separator;
		if(StringUtils.isNotBlank(packageName)){
			packagePath += packageName.replace(".", File.separator) + File.separator;
		}

		String[] split = Files.getNameWithoutExtension(template).split("\\.");
		if(template.contains(".java")){
			String s = "java" + File.separator + className + split[0] + ".java";
			return s;
		}else {
			return "webapp" + File.separator   + "page"+ File.separator + className.toLowerCase() + split[0] + "." + split[1];
		}

//		if(template.contains("Controller.java")){
//			return packagePath + "controller" + File.separator + className + "Controller.java";
//		}
//
//		if(template.contains("Dao.java")){
//			return packagePath + "dao" + File.separator + className + "Dao.java";
//		}
//
//		if(template.contains("Entity.java")){
//			return packagePath + "entity" + File.separator + className + "Entity.java";
//		}
//
//		if(template.contains("Service.java")){
//			return packagePath + "service" + File.separator + className + "Service.java";
//		}
//
//		if(template.contains("ServiceImpl.java")){
//			return packagePath + "service" + File.separator + "impl" + File.separator + className + "ServiceImpl.java";
//		}
//
//		if(template.contains("list.html")){
//			return "webapp" + File.separator   + "page"+ File.separator + className.toLowerCase() + "List.ftl";
//		}
//
//		if(template.contains("add.html")){
//			return "webapp" + File.separator   + "page"+ File.separator + className.toLowerCase() + "Add.ftl";
//		}
//
//		if(template.contains("modi.html")){
//			return "webapp" + File.separator   + "page"+ File.separator + className.toLowerCase() + "Modi.ftl";
//		}
//
//		if(template.contains("list.js")){
//			return "webapp" + File.separator + "js" + File.separator + className.toLowerCase() + ".js";
//		}
//
//		if(template.contains("info.js")){
//			return "webapp" + File.separator + "js" + File.separator + className.toLowerCase() + "Info.js";
//		}
//
//		if(template.contains("menu.sql")){
//			return className.toLowerCase() + "_menu.sql";
//		}

//		return null;
	}


}
