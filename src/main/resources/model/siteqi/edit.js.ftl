var updateType;

var  ${classname}Info={
    ${classname}Data: {}
}


/**
 * 清除数据
 */
${classname}Info.clearData = function () {
    this.${classname}Data = {};
};

/**
 * 设置对话框中的数据
 *
 * @param key 数据的名称
 * @param val 数据的具体值
 */
${classname}Info.set = function (key, val) {
    this.${classname}Data[key] = (typeof value == "undefined") ? $("#" + key).val() : value;
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
${classname}Info.setData = function (key,val) {
    $("#" + key).val(val)
    return this;
};


/**
 * 收集数据
 */
${classname}Info.collectData = function () {
    this<#list columns as column>.set("${column.attrname}")</#list>;
};


${classname}Info.doAdd = function () {
    this.clearData();
    this.collectData();
    if (!checksubmit(${classname}InfoForm)) {
        return false;
    }
    stc.rest.queryForPost("/${classname}/doAdd", this.${classname}Data, function(data) {
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


        stc.rest.queryForPost("/${classname}/doUpdate", ${classname}Info.${classname}Data, function(data) {
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
${classname}Info.doEdit = function () {
    if(updateType == "A"){// 新增
        this.doAdd();
    }else {// 修改
        this.doUpdate();
    }
}

${classname}Info.loadData = function (priKey) {
    stc.rest.queryForPost("/${classname}/getEntity", {priKey : priKey}, function(data) {
        var returnCode = data.RETURN_CODE;
        var returnMsg = data.RETURN_MSG;
        if (returnCode == "0") {
            <#list columns as column>
            var ${column.attrname} = data.${column.columnName };
            </#list>
            var priKey = data.PRI_KEY;

${classname}Info<#list columns as column>.setData('${column.attrname}', ${column.attrname})</#list>
        .set("priKey",priKey);

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