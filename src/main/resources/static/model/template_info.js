/**
 * 角色详情对话框（可用于添加和修改对话框）
 */
var templateInfo = {
    templateInfoData: {},
    validator: null,
    rules: {
        templateName: {
            required: true
        },
        templatePath: {
            required: true
        },
        uploadTime: {
            required: true
        },
        addUser: {
            required: true
        }
    }
};

/**
 * 清除数据
 */
templateInfo.clearData = function () {
    this.templateInfoData = {};
};

/**
 * 设置对话框中的数据
 *
 * @param key 数据的名称
 * @param val 数据的具体值
 */
templateInfo.set = function (key, val) {
    this.templateInfoData[key] = (typeof value == "undefined") ? $("#" + key).val() : value;
    return this;
};

/**
 * 设置对话框中的数据
 *
 * @param key 数据的名称
 * @param val 数据的具体值
 */
templateInfo.get = function (key) {
    return $("#" + key).val();
};

/**
 * 关闭此对话框
 */
templateInfo.close = function () {
    parent.layer.close(window.parent.template.layerIndex);
};

/**
 * 收集数据
 */
templateInfo.collectData = function () {
    this.set('templateName').set('templatePath').set('createdTime').set('uploadTime').set('status');
};

/**
 * 验证数据是否为空
 */
templateInfo.validate = function () {
    return this.validator.form();
};

/**
 * 提交添加用户
 */
templateInfo.addSubmit = function () {

    this.clearData();
    this.collectData();

    if (!this.validate()) {
        return;
    }

    //提交信息
    var ajax = new $ax("/template/addOK", function (data) {
        ice.success("添加成功!");
        window.parent.template.table.refresh();
        templateInfo.close();
    }, function (data) {
        ice.error("添加失败!" + data.responseJSON.message + "!");
    });
    ajax.set(this.templateInfoData);
    ajax.start();
};

/**
 * 提交修改
 */
templateInfo.editSubmit = function () {

    this.clearData();
    this.collectData();

    if (!this.validate()) {
        return;
    }

    //提交信息
    var ajax = new $ax("/template/modiOK", function (data) {
        ice.success("修改成功!");
        window.parent.template.table.refresh();
        templateInfo.close();
    }, function (data) {
        ice.error("修改失败!" + data.responseJSON.message + "!");
    });
    ajax.set(this.templateInfoData);
    ajax.start();
};

$(function () {
    var validator = ice.initJQValidator("templateInfoForm", templateInfo.rules);
    templateInfo.validator =validator;
    //执行一个laydate实例
    laydate.render({
        elem: '#uploadTime' //指定元素
    });

});
