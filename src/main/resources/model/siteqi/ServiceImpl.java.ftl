package com.sitech.prm.scchannel.channel.${classname};


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

@Service("${classname}ServiceImpl")
public class ${className}ServiceImpl  implements ${className}Service {

	@Resource(name="genericDaoImpl")
	private GenericDao genericDao;

	@Resource(name="baseDao")
	private BaseDao baseDao;

	@Resource
	private CommonService commonService;

	private Log logger;

	public ${className}ServiceImpl(){
		logger = LogFactory.getLog(this.getClass());
	}


	@Override
	public PageListVo getPage(HashMap<String, String> inParam, LoginOprVO lvo) {

		int page = Integer.parseInt(inParam.get("page"));// 第几页
		int pageSize = Integer.parseInt(inParam.get("pagesize"));// 每页几行

		StringBuilder conditionSql = new StringBuilder();

		List params = getConditionSql(conditionSql, inParam, lvo);


		StringBuilder countSql = new StringBuilder();
		countSql.append(" select count(1) from (").append(conditionSql).append(")");

		String rowCount = baseDao.findString(countSql.toString(), params.toArray());
		rowCount = Optional.fromNullable(rowCount).or("0");
		if("0".equals(rowCount)){
			return new PageListVo(rowCount, Collections.emptyList());
		}

		StringBuffer pageSql = new StringBuffer();
		pageSql.append("select * from (select rownum rn ,m.*  from ( ")
				.append(conditionSql)
				.append(" ) m where rownum <= " + (page * pageSize) + " ) ")
				.append(" where rn > " + (pageSize * page - pageSize) + "");

		List<Map<String, Object>> list = baseDao.findForList(pageSql.toString(), params.toArray());
		return new PageListVo(rowCount, list);
	}

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


    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = java.lang.Exception.class)
    public Map<String,String> doAdd(HashMap<String, Object> inParam, LoginOprVO lvo){
		String sql = "insert into ${tableName}(<#list columns as column>${column.columnName},</#list>PRI_KEY) values (<#list columns as column>?,</#list>?)";


		String key = getSequenceKey("SEQ_${tableName}");
		ParamsBuilder builder = ParamsBuilder.builder(inParam)
	<#list columns as column>.set("${column.attrname}")</#list>.addParam(key);

		baseDao.updateBySql(sql, builder.getParams().toArray());
		return ParamsBuilder.ok("添加成功");



    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = java.lang.Exception.class)
    public Map<String,String> doUpdate(HashMap<String, String> inParam, LoginOprVO lvo){
		String sql ="update ${tableName} set " +
        " <#list columns as column>${column.columnName} = ?<#if (column_index != columns?size -1 )>,</#if></#list> " +
        " where PRI_KEY=?";

		String priKey = inParam.get("priKey");
		ParamsBuilder builder = ParamsBuilder.builder(inParam)
	<#list columns as column>.set("${column.attrname}")</#list>
    	.addParam(priKey);

		addHisRecord(priKey, "U", lvo);
		baseDao.updateBySql(sql, builder.getParams().toArray());
		return ParamsBuilder.ok("修改成功");

	}



	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = java.lang.Exception.class)
	public Map<String,String> doDelete(HashMap<String, String> inParam, LoginOprVO lvo){
		String priKeys = StringTools.changeNullStr(inParam.get("priKey"));
		if("".equals(priKeys)){
			return ParamsBuilder.error("没有对应的记录");
		}

		String[] split = priKeys.split(",");
		for (String key : split) {
			addHisRecord(key, "D", lvo);
		}

		String ids = Joiner.on("','").join(split);
		String sql = "update ${tableName} set state = '0' where  pri_Key  in ('" + ids+ "')";
		baseDao.updateBySql(sql);

		return ParamsBuilder.ok("删除成功");
	}

	@Override
	public Map<String,String> getEntity(HashMap<String, String> inParam, LoginOprVO lvo){
        Object priKey = inParam.get("priKey");

        String sql = "select <#list columns as column>${column.columnName}<#if (column_index != columns?size -1 )>,</#if></#list> " +
        "from ${tableName} b where  b.PRI_KEY= ?";

        List<Map> list = baseDao.findBySql(sql, new Object[]{priKey});
        if(list.size() == 0 ){
        	return ParamsBuilder.error("没有查到对应的记录");
        }
        return ParamsBuilder.ok().put(list.get(0));

	}

	@Override
	public Map<String, Object> doExport(HashMap<String, String> inParam, LoginOprVO lvo) throws Exception {
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

        List<String[]> result = baseDao.findBySqlReArray(conditionSql.toString().replace(",PRI_KEY",""), params.toArray());

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


	public String getSequenceKey(String seqName){
		String sql = "select " + seqName + ".nextval from dual";
		String key = baseDao.findString(sql);
		return key;
	}

	private boolean addHisRecord(String priKey, String opType, LoginOprVO lvo){
		// 插入修改前的记录到历史表
		String sqlHis = "INSERT INTO ${tableName} (<#list columns as column>${column.columnName},</#list> op_login, op_time,  op_type)" +
		" VALUES (<#list columns as column>?,</#list> ?, sysdate, ?)";
		List<Map> entitys = baseDao.findBySql("select <#list columns as column>${column.columnName}<#if (column_index != columns?size -1 )>,</#if></#list> from ${tableName} where PRI_KEY = ? ", new Object[]{priKey});
		if(entitys.size() == 0 || entitys.size() > 1){
			return false;
		}
		ParamsBuilder builder = ParamsBuilder.builder(entitys.get(0))
<#list columns as column>.set("${column.attrname}")</#list>
		.addParam(lvo.getLoginNo(), opType);

		baseDao.updateBySql(sqlHis,builder.getParams().toArray());
		return true;
	}

}
