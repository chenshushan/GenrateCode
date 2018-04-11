package com.chen.code.common;


import java.util.Map;

/**
 * 查询参数
 *
 */
public class Query extends TypeHashMap<String, Object> {
	private  final long serialVersionUID = 1L;
	//当前页码
    private int pageNumber = 1;
    //每页条数
    private int pageSize = 10;

    private int offset;

    public Query(Map<String, Object> params){
        this.putAll(params);

        //分页参数
        Object pageNumberObj = params.get("pageNumber");
        if(pageNumberObj != null){
            this.pageNumber = Integer.parseInt(pageNumberObj.toString());
        }
        Object pageSizeObj = params.get("pageSize");
        if(pageSizeObj != null){
            this.pageSize = Integer.parseInt(pageSizeObj.toString());
        }
        this.offset = (this.pageNumber - 1) * pageSize;
        //防止SQL注入（因为sidx、order是通过拼接SQL实现排序的，会有SQL注入风险）
//        String sidx = params.get("sidx").toString();
//        String order = params.get("order").toString();
//        this.put("sidx", SQLFilter.sqlInject(sidx));
//        this.put("order", SQLFilter.sqlInject(order));
    }

    public int getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(int pageNumber) {
        this.pageNumber = pageNumber;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getOffset() {
        return offset;
    }

    public void setOffset(int offset) {
        this.offset = offset;
    }

}
