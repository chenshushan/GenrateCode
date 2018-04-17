


$(function() {
	//公共加载
	prm.frame.init('public');
	doQuery();
});


function doQuery(){
	$("#rptGrid").ligerGrid({
		columns: [
<#list columns as column>
	<#if (column.ifShow == "1")>
            <#if (column.attrType == "String")>
          {display:'${column.comments}',name:'${column.columnName }',align:'center',width:100,ret:true,render:function(row){ return renderRow(row,'${column.columnName }');}  },
            <#else>
			{ display: '${column.comments}', name: '${column.attrname}', width: 80 },
            </#if>
	</#if>
</#list>
			{display:'操作',isSort:false,render:operate,width: 80 }
        ],
        //title:'查询结果',
		url:"/${classname}/getPage",
		parms:[
<#list columns as column>
	<#if (column.ifSearch == "1")>
				{ name: "${column.attrname}", value: $("#${column.attrname}").val() },
	</#if>
</#list>
		       ],
		rownumbers : false,
		loadingMessage : "数据加载中...",
		alternatingRow : false,//是否加奇偶行效果
		delayLoad : false,
		async:true
    });
}
function operate(rowdata, index) {
    var priKey = rowdata.PRI_KEY;
    var h = "&nbsp;<a href=javascript:toEdit('U',"+ priKey +")>编辑</a>&nbsp;&nbsp;<a href=javascript:doDelete("+ priKey +")>删除</a>";
    return h
}

//编辑、新增
function toEdit(updateType,priKey){
    var titles = "";
    if(updateType=="A"){
        titles = "新增${comments }";
    } else {
        titles = "修改${comments }";
    }
    if(!priKey){
        priKey = "";
    }
    $.ligerDialog.open({
        height:640,
        width: 950,
        title : titles,
        url: '${classname}Edit.html',
        showMax: false,
        showToggle: false,
        showMin: false,
        isResize: true,
        slide: false,
        data: {
            updateType:updateType,
            priKey:priKey
        },
        name:"${classname}_edit_frame"
    });
}

function doDelete(priKey){
    $.ligerDialog.confirm("确定删除该记录吗！！","",function (val) {
        if(!val){
            return;
        }
        // 删除
        stc.rest.queryForPost("/${classname}/doDelete", {priKey : priKey}, function(data) {
            var returnCode = data.RETURN_CODE;
            var returnMsg = data.RETURN_MSG;
            if (returnCode == "0") {
                $.ligerDialog.success(returnMsg);
                doQuery();
            } else {
                $.ligerDialog.error(returnMsg);
            }
            $.ligerDialog.closeWaitting();
        }, function(data) {
            var returnMsg = data.RETURN_MSG;
            $.ligerDialog.warn(returnMsg);
            $.ligerDialog.closeWaitting();
        });
    })
}
function doExport() {
	var url = "/businessMixture/doExport?" +
<#list columns as column><#if (column.ifSearch == "1")>"${column.attrname}=" + $("#${column.attrname}").val() +</#if>
</#list> "";
    $("#exportFrame").attr("src", url);
}

function renderRow(row, dataName) {
    var data = row[dataName];
    if(data != undefined && data.length>9){
        return "<span title='"+ data +"'>" + data.substring(0,9) + "...<span>";
    }else{
        return data;
    }
}