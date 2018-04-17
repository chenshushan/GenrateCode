package com.sitech.prm.scchannel.channel.${classname};

import com.sitech.prm.sccloud.vo.LoginOprVO;
import com.sitech.prm.sccloud.vo.PageListVo;

import java.util.HashMap;
import java.util.Map;

public interface ${className}Service {

	PageListVo getPage(HashMap<String, String> obj, LoginOprVO lvo);

	Map<String,String> doAdd(HashMap<String, Object> inParam, LoginOprVO lvo);

	Map<String,String> doUpdate(HashMap<String, String> inParam, LoginOprVO lvo);

	Map<String,String> doDelete(HashMap<String, String> inParam, LoginOprVO lvo);

	Map<String,String> getEntity(HashMap<String, String> inParam, LoginOprVO lvo);

    Map<String, Object> doExport(HashMap<String, String> inParam, LoginOprVO lvo) throws Exception;
}
