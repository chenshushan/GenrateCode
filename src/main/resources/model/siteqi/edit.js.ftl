var updateType;

var  ${classname}Info={
    // 发送请求的数据
    ${classname}Data: {}
}


/**
 * 清除${classname}Data数据
 */
${classname}Info.clearData = function () {
    this.${classname}Data = {};
};

/**
 * 设置${classname}Data得值，默认设置id为key的dom元素的值。
 * 如果传入val，则将该值设置成val
 * @param key 数据的名称
 * @param val 数据的具体值
 */
${classname}Info.set = function (key, val) {
    if(val){
        this.${classname}Data[key] = val;
    }else {
        this.${classname}Data[key] =  $("#" + key).val() ;
    }
    return this;
};

/**
 * 得到id为key的dom元素的值。
 *
 * @param key 数据的名称
 * @param val 数据的具体值
 */
${classname}Info.get = function (key) {
    return $("#" + key).val();
};
// 将值设置到id为key的dom元素中
${classname}Info.setData = function (key,val) {
    $("#" + key).val(val)
    return this;
};


/**
 * 收集页面上表单的数据，将其设置到${classname}Data中，作为请求参数
 */
${classname}Info.collectData = function () {
    this<#list columns as column>.set("${column.attrname}")</#list>;
};

// 添加
${classname}Info.doAdd = function () {
    this.clearData();
    this.collectData();
    if (!checksubmit(${classname}InfoForm)) {
        return false;
    }
    $.ligerDialog.waitting("等待中。。。。");
    stc.rest.queryForPost("/${classname}/add${className}", this.${classname}Data, function(data) {
        var returnCode = data.RETURN_CODE;
        var returnMsg = data.RETURN_MSG;
        if (returnCode == "0") {
            $.ligerDialog.success(returnMsg, {}, function() {
                doRefresh();
            });
        } else {
            $.ligerDialog.error(returnMsg);
        }
        $.ligerDialog.closeWaitting();
    }, function(data) {
        var returnMsg = data.RETURN_MSG;
        $.ligerDialog.warn(returnMsg);
        $.ligerDialog.closeWaitting();
    });
};



// 修改
${classname}Info.doUpdate = function () {
    this.clearData();
    this.collectData();
    if (!checksubmit(${classname}InfoForm)) {
        return false;
    }
    var priKey = $("#priKey").val();
    if(!priKey){
        $.ligerDialog.error("没有对应的记录");
        return;
    }
    this.${classname}Data['priKey'] = priKey;

    $.ligerDialog.confirm("确定修改吗", "",function (val) {

        if(!val){
            return;
        }

        $.ligerDialog.waitting("等待中。。。。");
        stc.rest.queryForPost("/${classname}/update${className}", ${classname}Info.${classname}Data, function(data) {
            var returnCode = data.RETURN_CODE;
            var returnMsg = data.RETURN_MSG;
            if (returnCode == "0") {
                $.ligerDialog.success(returnMsg, {}, function() {
                    location.reload();
                });
            } else {
                $.ligerDialog.error(returnMsg);
            }
            $.ligerDialog.closeWaitting();
        }, function(data) {
            var returnMsg = data.RETURN_MSG;
            $.ligerDialog.warn(returnMsg);
            $.ligerDialog.closeWaitting();
        });


    });

};
// 根据updateType判断是新增还是修改
${classname}Info.doEdit = function () {
    if(updateType == "A"){// 新增
        this.doAdd();
    }else {// 修改
        this.doUpdate();
    }
}
// 编辑页面加载数据
${classname}Info.loadData = function (priKey) {
    stc.rest.queryForPost("/${classname}/getData", {priKey : priKey}, function(data) {
        var returnCode = data.RETURN_CODE;
        var returnMsg = data.RETURN_MSG;
        if (returnCode == "0") {
            <#list columns as column>
            var ${column.attrname} = data.${column.columnName?upper_case };
            </#list>
            var priKey = data.${classname?upper_case}ID;

${classname}Info<#list columns as column>.setData('${column.attrname}', ${column.attrname})</#list>
        .setData("priKey",priKey);

        } else {
            $.ligerDialog.error(returnMsg);
        }
        $.ligerDialog.closeWaitting();
    }, function(data) {
        var returnMsg = data.RETURN_MSG;
        $.ligerDialog.warn(returnMsg);
        $.ligerDialog.closeWaitting();
    });
}

$(function () {
    var dialog = frameElement.dialog; //调用页面的dialog对象(ligerui对象)
    var dialogData = dialog.get('data');//获取data参数
    updateType = dialogData.updateType;
    var priKey = dialogData.priKey;
    if("A" != updateType){
        // 修改时加载数据
        ${classname}Info.loadData(priKey);
    }
})