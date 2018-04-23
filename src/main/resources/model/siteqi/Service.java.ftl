package com.sitech.prm.scchannel.channel.${classname?lower_case};

import com.sitech.prm.sccloud.vo.LoginOprVO;
import com.sitech.prm.sccloud.vo.PageListVo;

import java.util.HashMap;
import java.util.Map;

/**
 * ${comments}服务类
 */
public interface ${className}Service {
	/** 查询${comments}列表
	 * @param inParam
	 * @param lvo
	 * @return
	 */
	PageListVo getPage(HashMap<String, String> obj, LoginOprVO lvo);
   /** 添加${comments}
    * @param inParam
    * @param lvo
    * @return
    */
	Map<String,String> add${className}(HashMap<String, Object> inParam, LoginOprVO lvo);
 	/** 更新${comments} 更新前插入对应历史表  标志为U
    * @param inParam
    * @param lvo
    * @return
    */
	Map<String,String> update${className}(HashMap<String, String> inParam, LoginOprVO lvo);
 	/** 删除${comments}  删除前插入对应历史表  标志为D
    * @param inParam
    * @param lvo
    * @return
    */
	Map<String,String> delete${className}(HashMap<String, String> inParam, LoginOprVO lvo);
  	/** 编辑页面加载单条记录信息
    * @param inParam
    * @param lvo
    * @return
    */
	Map<String,String> getData(HashMap<String, String> inParam, LoginOprVO lvo);
	/** 按查询条件导出${comments} 信息
	* @param inParam
	* @param lvo
	* @return
	* @throws Exception
	*/
	Map<String, Object> export${className}(HashMap<String, String> inParam, LoginOprVO lvo) throws Exception;
}
