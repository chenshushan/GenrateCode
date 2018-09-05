
package com.chen.code.common.gen;

import cn.hutool.core.convert.Convert;
import cn.hutool.core.io.resource.ClassPathResource;
import com.chen.code.entity.GenEntity;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;
import org.apache.commons.io.IOUtils;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.io.StringWriter;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;


/**
 * 使用freemarker生成
 * 代码生成器，根据数据表名称生成对应的Model、Mapper、Service、Controller简化开发。
 */
public class FreemarkerGen  extends BaseGenerator{


    /**
     * 生成代码
     */
    public static void generatorCode(Map<String, String> table, List<Map> columns, ZipOutputStream zip) {
        Map data = init(table,columns);
        try {
            generator(data,zip);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
    public static void generatorCode(GenEntity table, ZipOutputStream zip) {
        Map data = init(table);
        try {
            generator(data,zip);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    static List<String> getTemplates(File file) {
        File[] files = file.listFiles(tpl -> tpl.getName().endsWith("ftl"));
        return Arrays.stream(files).map(f -> f.getName()).collect(Collectors.toList());
    }

    public static void generator(Map data, ZipOutputStream zip) throws IOException, TemplateException {
        ClassPathResource classPathResource = new ClassPathResource("/");
        String classPath = classPathResource.getAbsolutePath();
        String tplPath = Convert.toStr(data.get("tplPath"), "");

        File tplZip = new File(classPath + tplPath);
        File tplDir = tplZip.getParentFile();
        freemarker.template.Configuration cfg = getFreemarkerConfiguration(tplDir);
        List<String> templates = getTemplates(tplDir);
        for (String template : templates) {

            StringWriter sw = new StringWriter();
            cfg.getTemplate(template).process(data, sw);
            String fileName = getFileName(template, data.get("className").toString(), getConfig().getString("package"));
            zip.putNextEntry(new ZipEntry(fileName));
            IOUtils.write(sw.toString(), zip, "UTF-8");
            IOUtils.closeQuietly(sw);
            zip.closeEntry();
        }
    }



    private static freemarker.template.Configuration getFreemarkerConfiguration(File tplDir) throws IOException {
        freemarker.template.Configuration cfg = new freemarker.template.Configuration(freemarker.template.Configuration.VERSION_2_3_25);
//        cfg.setClassForTemplateLoading(FreemarkerGen.class,"/");
        cfg.setDirectoryForTemplateLoading(tplDir);
        cfg.setDefaultEncoding("UTF-8");
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.IGNORE_HANDLER);
        return cfg;
    }



}
