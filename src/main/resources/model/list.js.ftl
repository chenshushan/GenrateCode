
/**
* 通知管理初始化
*/
var ${classname} = {
	id: "${classname}Table",	//表格id
	seItem: null,		//选中的条目
	table: null,
	layerIndex: -1
};

/**
* 初始化表格的列
*/
${classname}.initColumn = function () {
	return [
		{field: 'selectItem', radio: true},
		{title: 'id', field: '${classname}Id', visible: false, align: 'center', valign: 'middle'},
<#list columns as column>
	<#if (column.ifShow == "1")>
    	{title: '${column.comments}', field: '${column.attrname}', align: 'center', valign: 'middle', sortable: true},
	</#if>
</#list>
	];
};

/**
* 检查是否选中
*/
${classname}.check = function () {
	var selected = $('#' + this.id).bootstrapTable('getSelections');
	if (selected.length == 0) {
		ice.info("请先选中表格中的某一记录！");
		return false;
	} else {
		this.seItem = selected[0];
		return true;
	}
};

/**
* 点击添加${comments}
*/
${classname}.openAdd${classname} = function () {
	var index = layer.open({
		type: 2,
		title: '添加${comments}',
		area: ['800px', '420px'], //宽高
		fix: false, //不固定
		maxmin: true,
		content: '/${classname}/add'
	});
	this.layerIndex = index;
};

/**
* 打开查看${comments}详情
*/
${classname}.open${classname}Detail = function () {
	if (this.check()) {
		var index = layer.open({
			type: 2,
			title: '${comments}详情',
			area: ['800px', '420px'], //宽高
			fix: false, //不固定
			maxmin: true,
			content: '/${classname}/modi/' + this.seItem.${classname}Id
		});
		this.layerIndex = index;
	}
};

/**
* 删除通知
*/
${classname}.delete = function () {
	if (this.check()) {
		var operation = function(){
			var ajax = new $ax("/${classname}/delete/" + ${classname}.seItem.${classname}Id, function (data) {
				ice.success("删除成功!");
				${classname}.table.refresh();
			}, function (data) {
				ice.error("删除失败!" + data.responseJSON.message + "!");
			});
			ajax.start();
		};
		ice.confirm("是否删除该${comments}?", operation);
	}
};

/**
* 查询通知列表
*/
${classname}.search = function () {
	var queryData = {};
<#list columns as column>
	<#if (column.ifSearch == "1")>
    queryData['${column.attrname}'] = $("#${column.attrname}").val();
	</#if>
</#list>

	${classname}.table.refresh({query: queryData});
};

$(function () {
	var defaultColunms = ${classname}.initColumn();
	var table = new BSTable(${classname}.id, "/${classname}/data", defaultColunms);
	${classname}.table = table.init();
	$("#btn_add").click(function () {
		${classname}.openAdd${classname}();
	});
	$("#btn_modi").click(function () {
		${classname}.open${classname}Detail();
	});
	$("#btn_delete").click(function () {
		${classname}.delete();
	});
	$("#btn_query").click(function () {
		${classname}.search();
	});
});
