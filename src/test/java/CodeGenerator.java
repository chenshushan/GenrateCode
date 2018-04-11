import com.chen.code.entity.vo.ColumnEntity;
import com.chen.code.entity.vo.TableEntity;
import com.google.common.base.CaseFormat;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.WordUtils;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;


/**
 * 代码生成器，根据数据表名称生成对应的Model、Mapper、Service、Controller简化开发。
 */
public class CodeGenerator {

    public static final String BASE_PACKAGE = "com.chen.code";//项目基础包名称，根据自己公司的项目修改

//    需要生成的文件的包名
    public static final String MODEL_PACKAGE = BASE_PACKAGE + ".entity";//Model所在包
    public static final String MAPPER_PACKAGE = BASE_PACKAGE + ".dao";//Mapper所在包
    public static final String SERVICE_PACKAGE = BASE_PACKAGE + ".service";//Service所在包
    public static final String SERVICE_IMPL_PACKAGE = SERVICE_PACKAGE + ".impl";//ServiceImpl所在包
    public static final String CONTROLLER_PACKAGE = BASE_PACKAGE + ".web";//Controller所在包

    public static final String SQL_PACKAGE =  "sql";//sql文件所在包



    //JDBC配置，请修改为你项目的实际配置
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/usk";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "123";
    private static final String JDBC_DIVER_CLASS_NAME = "com.mysql.jdbc.Driver";

    private static final String PROJECT_PATH = System.getProperty("user.dir");//项目在硬盘上的基础路径
    private static final String TEMPLATE_FILE_PATH = PROJECT_PATH + "/src/test/resources/model";//模板位置

    private static final String JAVA_PATH = "/src/main/java"; //java文件路径
    private static final String RESOURCES_PATH = "/src/main/resources";//资源文件路径

//    包名转路径
    private static final String PACKAGE_PATH_SERVICE = packageConvertPath(SERVICE_PACKAGE);//生成的Service存放路径
    private static final String PACKAGE_PATH_MODEL = packageConvertPath(MODEL_PACKAGE);//生成的Service存放路径
    private static final String PACKAGE_PATH_SERVICE_IMPL = packageConvertPath(SERVICE_IMPL_PACKAGE);//生成的Service实现存放路径
    private static final String PACKAGE_PATH_CONTROLLER = packageConvertPath(CONTROLLER_PACKAGE);//生成的Controller存放路径
    private static final String PACKAGE_PATH_SQL = packageConvertPath(SQL_PACKAGE);//生成的SQL存放路径

    private static final String AUTHOR = "CodeGenerator";//@author
    private static final String DATE = new SimpleDateFormat("yyyy/MM/dd").format(new Date());//@date



    /** freemarker配置
     * @return
     * @throws IOException
     */
    private static freemarker.template.Configuration getFreemarkerConfiguration() {
        freemarker.template.Configuration cfg = new freemarker.template.Configuration(freemarker.template.Configuration.VERSION_2_3_23);
        try {
            cfg.setDirectoryForTemplateLoading(new File(TEMPLATE_FILE_PATH));
        } catch (IOException e) {

        }
        cfg.setDefaultEncoding("UTF-8");
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.IGNORE_HANDLER);
        return cfg;
    }


    /** 生成代码
     * @param tableName
     */
    public void generatorCode(String tableName){
        Map<String, String> table = JDBCUtils.queryTable(tableName);
        List<Map> columns = JDBCUtils.queryColumns(tableName);
        Map data = init(table,columns);
        String className = data.get("className").toString();
//        PROJECT_PATH + JAVA_PATH + PACKAGE_PATH_MODEL + className + ".java"
        // 生成文件的路径
        StringBuilder filePath = new StringBuilder(PROJECT_PATH).append(JAVA_PATH).append(PACKAGE_PATH_MODEL).append(className).append(".java");
        //1 生成类文件
        genCodeFile(data,filePath.toString(),"Entity.java.ftl");

        filePath = new StringBuilder(PROJECT_PATH).append(RESOURCES_PATH).append(PACKAGE_PATH_SQL).append(className).append(".sql");
        genCodeFile(data,filePath.toString(),"menu.sql.ftl");
    }

    /**文件
     * @param data 数据
     * @param filePath 生成路径
     * @param modelName 模板名
     */
    private void genCodeFile(Map data,String filePath,String modelName){
        File file = new File(filePath);
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
        freemarker.template.Configuration cfg = getFreemarkerConfiguration();
        try {
            cfg.getTemplate(modelName).process(data,new FileWriter(file));
        } catch (TemplateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        new CodeGenerator().generatorCode("gen_table");
    }

    /**
     * 配置文件 配置数据和类型的对应关系
     */
    private static Properties config = new Properties();

    static {
        try {
            InputStream is = Thread.currentThread().getContextClassLoader().getResourceAsStream("generator.properties");
            config.load(is);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /** 根据表和列的信息装配模板所需的信息
     * @param table
     * @param columns
     * @return
     */
    private Map init(Map<String, String> table, List<Map> columns) {
        //表信息
        TableEntity tableEntity = new TableEntity();
//		表名
        String tableName = table.get("tableName");
        tableEntity.setTableName(tableName);
//		备注
        String tableComment = table.get("tableComment");
        tableEntity.setComments(tableComment);
        //表名转换成Java类名
        String className = tableToJava(tableEntity.getTableName(), config.getProperty("tablePrefix"));
//		类名
        tableEntity.setClassName(className);
//		类名首字母小写
        tableEntity.setClassname(org.apache.commons.lang.StringUtils.uncapitalize(className));

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
            columnEntity.setAttrname(org.apache.commons.lang.StringUtils.uncapitalize(attrName));

            String dataType = MapUtils.getString(column, "dataType");
            columnEntity.setDataType(dataType);
            String attrType = config.getProperty(dataType, "unknowType");
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
            columnEntity.setIfSearch(Optional.ofNullable(ifSearch).orElse(""));
            String ifShow = MapUtils.getString(column, "ifShow");
            columnEntity.setIfShow(Optional.ofNullable(ifShow).orElse(""));
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
        Map<String, Object> map = new HashMap<>();
        map.put("tableName", tableEntity.getTableName());
        map.put("comments", tableEntity.getComments());
        map.put("pk", tableEntity.getPk());
        map.put("className", tableEntity.getClassName());
        map.put("classname", tableEntity.getClassname());
        map.put("columns", tableEntity.getColumns());
        map.put("package", config.getProperty("package"));
        map.put("author", "generator");
        map.put("datetime", LocalDate.now().toString());
        return map;
    }



    /** 将表名去下划线并驼峰命名后首字母小写
     * @param tableName
     * @return
     */
    private static String tableNameConvertLowerCamel(String tableName) {
        return CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.LOWER_CAMEL, tableName.toLowerCase());
    }

    /** 将表名去下划线并驼峰命名后首字母大写
     * @param tableName
     * @return
     */
    private static String tableNameConvertUpperCamel(String tableName) {
        return CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.UPPER_CAMEL, tableName.toLowerCase());
    }

    /** 将表名中的下划线分割成路径 tb_user_class==>/tb/user/class
     * @param tableName
     * @return
     */
    private static String tableNameConvertMappingPath(String tableName) {
        tableName = tableName.toLowerCase();//兼容使用大写的表名
        return "/" + (tableName.contains("_") ? tableName.replaceAll("_", "/") : tableName);
    }

    /** 将类名按驼峰命名分割成路径 TbUser==>/tb/user
     * @param modelName
     * @return
     */
    private static String modelNameConvertMappingPath(String modelName) {
        String tableName = CaseFormat.UPPER_CAMEL.to(CaseFormat.LOWER_UNDERSCORE, modelName);
        return tableNameConvertMappingPath(tableName);
    }

    /** 将包名转换成路径   com.company.project==>/com/company/project/
     * @param packageName
     * @return
     */
    private static String packageConvertPath(String packageName) {
        return String.format("/%s/", packageName.contains(".") ? packageName.replaceAll("\\.", "/") : packageName);
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
        if(org.apache.commons.lang.StringUtils.isNotBlank(tablePrefix)){
            tableName = tableName.replace(tablePrefix, "");
        }
        return columnToJava(tableName);
    }
}
