
/**
* 通知管理初始化
*/
var template = {
	id: "templateTable",	//表格id
	seItem: null,		//选中的条目
	table: null,
	layerIndex: -1
};

/**
* 初始化表格的列
*/
template.initColumn = function () {
	return [
		{field: 'selectItem', radio: true},
		{title: 'id', field: 'templateId', visible: false, align: 'center', valign: 'middle'},
    	{title: '模板路径', field: 'templatePath', align: 'center', valign: 'middle', sortable: true},
    	{title: '上传人', field: 'addUser', align: 'center', valign: 'middle', sortable: true},
    	{title: '模板名称', field: 'templateName', align: 'center', valign: 'middle', sortable: true},
	];
};

/**
* 检查是否选中
*/
template.check = function () {
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
* 点击添加模板
*/
template.openAddtemplate = function () {
	var index = layer.open({
		type: 2,
		title: '添加模板',
		area: ['800px', '420px'], //宽高
		fix: false, //不固定
		maxmin: true,
		content: '/template/add'
	});
	this.layerIndex = index;
};

/**
* 打开查看模板详情
*/
template.opentemplateDetail = function () {
	if (this.check()) {
		var index = layer.open({
			type: 2,
			title: '模板详情',
			area: ['800px', '420px'], //宽高
			fix: false, //不固定
			maxmin: true,
			content: '/template/modi/' + this.seItem.templateId
		});
		this.layerIndex = index;
	}
};

/**
* 删除通知
*/
template.delete = function () {
	if (this.check()) {
		var operation = function(){
			var ajax = new $ax("/template/delete/" + template.seItem.templateId, function (data) {
				ice.success("删除成功!");
				template.table.refresh();
			}, function (data) {
				ice.error("删除失败!" + data.responseJSON.message + "!");
			});
			ajax.start();
		};
		ice.confirm("是否删除该模板?", operation);
	}
};

/**
* 查询通知列表
*/
template.search = function () {
	var queryData = {};
    queryData['addUser'] = $("#addUser").val();
    queryData['templateName'] = $("#templateName").val();

	template.table.refresh({query: queryData});
};

$(function () {
	var defaultColunms = template.initColumn();
	var table = new BSTable(template.id, "/template/data", defaultColunms);
	template.table = table.init();
	$("#btn_add").click(function () {
		template.openAddtemplate();
	});
	$("#btn_modi").click(function () {
		template.opentemplateDetail();
	});
	$("#btn_delete").click(function () {
		template.delete();
	});
	$("#btn_query").click(function () {
		template.search();
	});
});
