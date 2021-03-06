package com.sitech.prm.scchannel.channel.${classname?lower_case};


import com.google.common.base.Joiner;
import com.google.common.base.Optional;
import com.sitech.prm.scchannel.common.CommonService;
import com.sitech.prm.sccloud.frame.common.BaseDao;
import com.sitech.prm.sccloud.frame.service.jdbc.GenericDao;
import com.sitech.prm.sccloud.util.ParamsBuilder;
import com.sitech.prm.sccloud.util.StringTools;
import com.sitech.prm.sccloud.vo.LoginOprVO;
import com.sitech.prm.sccloud.vo.PageListVo;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;

/**
 * ${comments}服务类
 */
@Service("${classname}ServiceImpl")
public class ${className}ServiceImpl  implements ${className}Service {

	@Resource(name="genericDaoImpl")
	private GenericDao genericDao;

	@Resource(name="baseDao")
	private BaseDao baseDao;

	@Resource
	private CommonService commonService;

	private static String dbString= "";


	private Log logger;

	public ${className}ServiceImpl(){
		logger = LogFactory.getLog(this.getClass());
	}
	/** 查询${comments}列表
	 * @param inParam
	 * @param lvo
	 * @return
	 */
	@Override
	public PageListVo getPage(HashMap<String, String> inParam, LoginOprVO lvo) {

		int page = Integer.parseInt(inParam.get("page"));// 第几页
		int pageSize = Integer.parseInt(inParam.get("pagesize"));// 每页几行

		StringBuilder conditionSql = new StringBuilder();

		List params = getConditionSql(conditionSql, inParam, lvo);


		StringBuilder countSql = new StringBuilder();
		countSql.append(" select count(1) from (").append(conditionSql).append(")");

		String rowCount = baseDao.findString(countSql.toString(), params.toArray(), dbString);
		rowCount = Optional.fromNullable(rowCount).or("0");
		if("0".equals(rowCount)){
			return new PageListVo(rowCount, Collections.emptyList());
		}

		StringBuffer pageSql = new StringBuffer();
		pageSql.append("select * from (select rownum rn ,m.*  from ( ")
				.append(conditionSql)
				.append(" ) m where rownum <= " + (page * pageSize) + " ) ")
				.append(" where rn > " + (pageSize * page - pageSize) + "");

		List<Map<String, Object>> list = baseDao.findForList(pageSql.toString(), params.toArray(), dbString);
		return new PageListVo(rowCount, list);
	}
	/** 按条件得到查询sql
	 * @param conditionSql 最终拼接完成的sql
	 * @param inParam 传入的相关参数
	 * @param lvo 登录信息
	 * @return
	 */
	private List getConditionSql(StringBuilder conditionSql, Map<String, String> inParam, LoginOprVO lvo){
		List<String> params = new ArrayList();
		conditionSql.append("select * from ${tableName } b where 1=1 ");

		<#list columns as column>
			<#if (column.ifSearch == "1" )>
		String ${column.attrname} = StringTools.changeNullStr(inParam.get("${column.attrname}"));
		if (!"".equals(${column.attrname})) {
			conditionSql.append(" AND b.${column.columnName} = ? ");
			params.add(${column.attrname});
		}
			</#if>
		</#list>
		return params;
    }

    /** 添加${comments}
    * @param inParam
    * @param lvo
    * @return
    */
    @Override
    public Map<String,String> add${className}(HashMap<String, Object> inParam, LoginOprVO lvo){
		String sql = "insert into ${tableName}(<#list columns as column>${column.columnName},</#list>${classname}Id,state) values (<#list columns as column>?,</#list>?,'1')";


    	long key = baseDao.getSeq("SEQ_DCHNBASICSTATION_KEY", dbString);
		ParamsBuilder builder = ParamsBuilder.builder(inParam)
	<#list columns as column>.set("${column.attrname}")</#list>.addParam(String.valueOf(key));

		baseDao.updateBySql(sql, builder.getParams().toArray(), dbString);
		return ParamsBuilder.ok("添加成功");



    }
    /** 更新${comments} 更新前插入对应历史表  标志为U
    * @param inParam
    * @param lvo
    * @return
    */
    @Override
    public Map<String,String> update${className}(HashMap<String, String> inParam, LoginOprVO lvo){
		String sql ="update ${tableName} set " +
        " <#list columns as column>${column.columnName} = ?<#if (column_index != columns?size -1 )>,</#if></#list> " +
        " where ${classname}Id=?";

		String priKey = inParam.get("priKey");
		ParamsBuilder builder = ParamsBuilder.builder(inParam)
	<#list columns as column>.set("${column.attrname}")</#list>
    	.addParam(priKey);

		addHisRecord(priKey, "U", lvo);
		baseDao.updateBySql(sql, builder.getParams().toArray(), dbString);
		return ParamsBuilder.ok("修改成功");

	}

    /** 删除${comments}  删除前插入对应历史表  标志为D
    * @param inParam
    * @param lvo
    * @return
    */
	@Override
	public Map<String,String> delete${className}(HashMap<String, String> inParam, LoginOprVO lvo){
		String priKeys = StringTools.changeNullStr(inParam.get("priKey"));
		if("".equals(priKeys)){
			return ParamsBuilder.error("没有对应的记录");
		}

		String[] split = priKeys.split(",");
		for (String key : split) {
			addHisRecord(key, "D", lvo);
		}

		String ids = Joiner.on("','").join(split);
		String sql = "update ${tableName} set state = '0' where  ${classname}Id  in ('" + ids+ "')";
		baseDao.updateBySql(sql, dbString);

		return ParamsBuilder.ok("删除成功");
	}
    /** 编辑页面加载单条记录信息
    * @param inParam
    * @param lvo
    * @return
    */
	@Override
	public Map<String,String> getEntity(HashMap<String, String> inParam, LoginOprVO lvo){
        Object priKey = inParam.get("priKey");

        String sql = "select <#list columns as column>${column.columnName}<#if (column_index != columns?size -1 )>,</#if></#list>,${classname}Id " +
        "from ${tableName} b where  b.${classname}Id= ?";

        List<Map> list = baseDao.findBySql(sql, new Object[]{priKey}, dbString);
        if(list.size() == 0 ){
        	return ParamsBuilder.error("没有查到对应的记录");
        }
        return ParamsBuilder.ok().put(list.get(0));

	}
	/** 按查询条件导出${comments} 信息
	* @param inParam
	* @param lvo
	* @return
	* @throws Exception
	*/
	@Override
	public Map<String, Object> export${className}(HashMap<String, String> inParam, LoginOprVO lvo) throws Exception {
		StringBuilder conditionSql = new StringBuilder();
		List params = getConditionSql(conditionSql, inParam, lvo);

		List<String[]> list = new ArrayList<String[]>();

		String [] head = new String [${columns?size}];
		<#list columns as column>
		head[${column_index}] ="${column.comments}";
		</#list>
		List<String[]> headList = new ArrayList();
		headList.add(head);

		list.addAll(headList);

        List<String[]> result = baseDao.findBySqlReArray(conditionSql.toString().replace(",${classname}Id",""), params.toArray(), dbString);

        list.addAll(result);
		Map<String, Object> retMap = new HashMap();

		//水印信息
		Map<String,String> waterMarkInfo = commonService.getWarterMark(inParam, lvo);
		waterMarkInfo.put("loginNo", lvo.getUser().getLoginNo());
		waterMarkInfo.put("loginName", lvo.getUser().getLoginName());

		Date date = new Date();
		String fileName = DateFormatUtils.format(date, "yyyyMMdd") + "_"
		+ "_" + lvo.getLoginNo()
		+ "_${comments}明细";

		retMap.put("fName", fileName);
		retMap.put("sheetName", "${comments}明细");
		retMap.put("waterMarkInfo", waterMarkInfo);
		retMap.put("valueList", list);


		return retMap;
	}


	/** 添加历史表信息
	* @param priKey
	* @param opType
	* @param lvo
	* @return
	*/
	private boolean addHisRecord(String priKey, String opType, LoginOprVO lvo){
		// 插入修改前的记录到历史表
		String sqlHis = "INSERT INTO ${tableName}HIS (<#list columns as column>${column.columnName},</#list> op_login, op_time,  op_type,${classname}Id,state)" +
		" VALUES (<#list columns as column>?,</#list> ?, sysdate, ?, ?, ?)";
		List<Map> entitys = baseDao.findBySql("select <#list columns as column>${column.columnName}<#if (column_index != columns?size -1 )>,</#if></#list>,${classname}Id,state from ${tableName} where ${classname}Id = ? ", new Object[]{priKey}, dbString);
		if(entitys.size() == 0 || entitys.size() > 1){
			return false;
		}
		ParamsBuilder builder = ParamsBuilder.builder(entitys.get(0))
<#list columns as column>.set("${column.columnName}")</#list>
		.addParam(lvo.getLoginNo(), opType).addParam(priKey).set("STATE");

		baseDao.updateBySql(sqlHis,builder.getParams().toArray());
		return true;
	}

}
