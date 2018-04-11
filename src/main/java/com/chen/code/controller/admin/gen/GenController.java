package com.chen.code.controller.admin.gen;

import com.chen.code.common.Query;
import com.chen.code.common.R;
import com.chen.code.common.utils.PageUtils;
import com.chen.code.common.utils.ToolUtils;
import com.chen.code.controller.BaseController;
import com.chen.code.entity.GenField;
import com.chen.code.entity.GenEntity;
import com.chen.code.entity.enumdo.EnumJavaType;
import com.chen.code.entity.enumdo.EnumYesOrNo;
import com.chen.code.service.IFieldService;
import com.chen.code.service.ITableService;
import com.github.wenhao.jpa.Specifications;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

import static com.chen.code.common.gen.BaseGenerator.*;

/**
 * Created by Administrator on 2017/11/13.
 */
@Controller
@RequestMapping("/gen")
public class GenController extends BaseController {

	@Autowired
	ITableService tableService;
	@Autowired
	IFieldService fieldService;

	/**
	 * 生成代码
	 */
	@RequestMapping("/code")
	public void code() throws IOException {
		String ids = request().getParameter("tables");
		String[] split = ids.split(",");
		//获取表名，不进行xss过滤

		byte[] data = tableService.generatorCodeByEntity(split);
		response().reset();
		response().setHeader("Content-Disposition", "attachment; filename=\"code" + System.currentTimeMillis()+ ".zip\"");
		response().addHeader("Content-Length", "" + data.length);
		response().setContentType("application/octet-stream; charset=UTF-8");

		IOUtils.write(data, response().getOutputStream());
	}


	@RequestMapping("/list")
	public String  list(@RequestParam Map<String, Object> params){
		//查询列表数据
		Query query = new Query(params);
		PageUtils<Map> pageUtils = tableService.queryTableList(query);
		request().setAttribute("page",pageUtils);
		return "/admin/gen/index";
	}
	@RequestMapping("/getTableColumns")
	public @ResponseBody R columns(String tableName){
		//查询表的列数据
		List<Map> maps = tableService.queryColumns(tableName);

		Configuration config = getConfig();


		List<Map> rows = maps.stream().map(map -> {
			Map m = new HashMap();
			String columnName = MapUtils.getString(map, "columnName");
			String dataType = MapUtils.getString(map, "dataType");
			String columnComment = MapUtils.getString(map, "columnComment");
			String columnKey = MapUtils.getString(map, "columnKey");
			String length = MapUtils.getString(map, "len");

			m.put("columnName", columnName); //列名
			m.put("attrName", StringUtils.uncapitalize(columnToJava(columnName))); //属性名

			m.put("dataType", dataType);     //列类型
			String attrType = config.getString(dataType, "unknowType");
			EnumJavaType enumJavaType = javaTypeMap.get(attrType);
			m.put("attrType", enumJavaType.getIndex());     //列类型

			m.put("reference", "");     //字段是引用类型时的类型
			int index = EnumYesOrNo.NO.getIndex();
			m.put("ifSearch", index);     //是否是搜索条件
			m.put("ifShow", index);     //是否在列表显示
			//是否主键
			if ("PRI".equalsIgnoreCase(columnKey)) {
				index =EnumYesOrNo.YES.getIndex();
			}
			m.put("columnComment", columnComment); //备注
			m.put("columnKey", index);   //主键
			m.put("fieldLength", Optional.ofNullable(length).orElse("默认"));   //字段长度
			return m;
		}).collect(Collectors.toList());


		return R.ok().put("total",maps.size()).put("rows",rows);
	}
	@RequestMapping("/{path}")
	public String turn(@PathVariable String path){
		return "/admin/gen/"+path;
	}
	@RequestMapping("/columns")
	public String turnColumns(String tableName){
		request().setAttribute("tableName",tableName);
		return "/admin/gen/columns";
	}
	@RequestMapping("/tdata")
	public @ResponseBody R getDepartment(int limit, int offset, String departmentname, String statu){
		Map<String, String[]> parameterMap = request().getParameterMap();
		System.out.println(parameterMap);
		List list=new ArrayList();
		for (int i = 0; i < 50; i++) {
			Map map=new HashMap();
			map.put("ID",System.currentTimeMillis());
			map.put("Name","name"+i);
			map.put("Level",i);
			map.put("Desc","描述信息"+i);
			list.add(map);
		}
		List data = list.subList(offset, offset + limit);
//		bootstraptable js里面初始化的参数 sidePagination: "server" 设置为在服务端分页，那么我们的返回值必须告诉前端总记录的条数和当前页的记录数，
// 		然后前端才知道如何分页。这两个参数的名字必须为total和rows

		return R.ok().put("total",list.size()).put("row",data);
	}


	@RequestMapping("/addTableOK")
	public @ResponseBody R addTableOK(){
		String className = request().getParameter("className");
		String tableName = request().getParameter("tableName");
		String remark = request().getParameter("remark");
		String useCache = request().getParameter("useCache");

		GenEntity tableExist = tableService.findByClassName(className);
		if(tableExist != null){
			return R.error("该实体名已经存在");
		}

		GenEntity genEntity = new GenEntity();
		genEntity.setClassName(className);
		genEntity.setTableName(tableName);
		genEntity.setRemark(remark);
		genEntity.setUseCache(useCache);
		genEntity.setCreatedTime(new Date());
		genEntity.setModifiedCount(0);
		genEntity.setModifiedTime(new Date());
		genEntity.setStatus("1");
		tableService.save(genEntity);
		return R.ok("保存成功");
	}
	@RequestMapping("/listTable")
	public @ResponseBody R listTable(){
		String className = request().getParameter("className");
		Specification<GenEntity> specification = Specifications.<GenEntity>and().like(ToolUtils.isNotEmpty(className), "className", "%" + className + "%").build();
		Page<GenEntity> page = tableService.findAll(specification,getPageRequest());
		return R.ok().put("total",page.getTotalElements()).put("rows",page.getContent());
	}
	@RequestMapping("/modiTable")
	public String modiTable(Integer tableId){
		GenEntity genEntity = tableService.find(tableId);
		request().setAttribute("entity", genEntity);
		return "/admin/gen/modi";
	}
	@RequestMapping("/modiTableOK")
	public String modiTableOK(GenEntity table){
		GenEntity entity = tableService.find(table.getTableId());
		entity.setRemark(table.getRemark());
		entity.setTableName(table.getTableName());
		entity.setUseCache(table.getUseCache());
		entity.setModifiedTime(new Date());
		entity.setModifiedCount(entity.getModifiedCount()+1);
		tableService.update(entity);
		return  redirect("/gen/modiTable?tableId=" + table.getTableId());
	}

	@RequestMapping("/listField")
	public @ResponseBody R listField(){
		String tableId = request().getParameter("tableId");
		Specification<GenField> specification = Specifications.<GenField>and().eq("table.tableId", Integer.valueOf(tableId)).build();
		Page<GenField> page = fieldService.findAll(specification,getPageRequest());
		return R.ok().put("total",page.getTotalElements()).put("rows",page.getContent());
	}

	@RequestMapping("/saveOrUpdateField")
	public String saveOrUpdateField(Integer tableId){
		request().setAttribute("tableId",tableId);
		String dropDwon = enumToDropDwon(EnumYesOrNo.class);
		request().setAttribute("dropDwon",dropDwon);
		String dropDwonType = enumToDropDwon(EnumJavaType.class);
		request().setAttribute("dropDwonType",dropDwonType);

		int fieldId = ToolUtils.parseInt(request().getParameter("fieldId"));
		if(fieldId > 0){
			// 修改
			GenField field = fieldService.find(fieldId);
			request().setAttribute("entity",field);
			request().setAttribute("modi","modi");

		}

		return "/admin/gen/filedForm";
	}
	@RequestMapping("/saveOrUpdateFieldOK")
	public @ResponseBody R saveOrUpdateFieldOK(GenField field){
		Integer fieldId = field.getFieldId();
		field.setModifiedTime(new Date());
		if(fieldId == null || fieldId < 1){
			String fieldName = field.getFieldName();
			Specification<GenField> specification = Specifications.<GenField>and().eq("fieldName", fieldName)
					.eq("table.tableId", field.getTable().getTableId()).build();
			List<GenField> fields = fieldService.findList(specification, new Sort(Sort.Direction.DESC, "fieldId"));
			if(fields.size() > 0){
				return R.error("该属性名在该实体中已存在");
			}

			// 添加
			field.setModifiedCount(0);
			field.setCreatedTime(new Date());
			field.setStatus("1");
			fieldService.save(field);
		}else {
			GenField entity = fieldService.find(fieldId);
			copyProperties(field,entity);
			// 更新
			entity.setModifiedCount(entity.getModifiedCount() + 1);
			fieldService.update(entity);
		}
		return R.ok();
	}

}
