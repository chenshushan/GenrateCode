/**
* 角色详情对话框（可用于添加和修改对话框）
*/
var ${classname}Info = {
	${classname}InfoData: {},
	validator: null,
	rules: {
<#list columns as column>
	<#if (column.ifNull == "0")>
		${column.attrname}: {
				required: true
		},
	</#if>
</#list>
	}
};

/**
* 清除数据
*/
${classname}Info.clearData = function () {
	this.${classname}InfoData = {};
};

/**
* 设置对话框中的数据
*
* @param key 数据的名称
* @param val 数据的具体值
*/
${classname}Info.set = function (key, val) {
	this.${classname}InfoData[key] = (typeof value == "undefined") ? $("#" + key).val() : value;
	return this;
};

/**
* 设置对话框中的数据
*
* @param key 数据的名称
* @param val 数据的具体值
*/
${classname}Info.get = function (key) {
	return $("#" + key).val();
};

/**
* 关闭此对话框
*/
${classname}Info.close = function () {
	parent.layer.close(window.parent.${classname}.layerIndex);
};

/**
* 收集数据
*/
${classname}Info.collectData = function () {
	this
<#list columns as column>
	.set('${column.attrname}')
</#list>
	;
};

/**
* 验证数据是否为空
*/
${classname}Info.validate = function () {
	return this.validator.form();
};

/**
* 提交添加用户
*/
${classname}Info.addSubmit = function () {

	this.clearData();
	this.collectData();

	if (!this.validate()) {
		return;
	}

	//提交信息
	var ajax = new $ax("/${classname}/addOK", function (data) {
		ice.success("添加成功!");
		window.parent.${classname}.table.refresh();
		${classname}Info.close();
	}, function (data) {
		ice.error("添加失败!" + data.responseJSON.message + "!");
	});
	ajax.set(this.${classname}InfoData);
	ajax.start();
};



<#list columns as column>
	<#if (column.attrType == "Reference")>
${classname}Info.select${column.attrName} = function () {
    layer.open({
		type: 2,
		title: '选择平台',
		area: ['80%', '95%'], //宽高
		fix: false, //不固定
		maxmin: true,
		content: '/${column.attrname}/select?selectKey=${column.attrname}Id&selectName=${column.attrname}Name',
		success: function(layero, index){
			var body = layer.getChildFrame('body',index);//建立父子联系
			var indexInput = body.find("input[id = 'index']");
			$(indexInput).val(index);
		}
    });
};
	</#if>
</#list>





/**
* 提交修改
*/
${classname}Info.editSubmit = function () {

	this.clearData();
	this.collectData();

	if (!this.validate()) {
		return;
	}
	this.set('${classname}Id');
	//提交信息
	var ajax = new $ax("/${classname}/modiOK", function (data) {
		ice.success("修改成功!");
		window.parent.${classname}.table.refresh();
		${classname}Info.close();
	}, function (data) {
		ice.error("修改失败!" + data.responseJSON.message + "!");
	});
	ajax.set(this.${classname}InfoData);
	ajax.start();
};

$(function () {
	var validator = ice.initJQValidator("${classname}InfoForm", ${classname}Info.rules);
	${classname}Info.validator = validator;
	//执行一个laydate实例
<#list columns as column>
	<#if (column.attrType == "Date")>
    laydate.render({
    	elem: '#${column.attrname}' //指定元素
    });
	</#if>
</#list>

});
