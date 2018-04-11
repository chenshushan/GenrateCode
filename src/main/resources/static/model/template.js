/**
 * Created by Administrator on 2017/11/26.
 */
/**
 * 通知管理初始化
 */
var template = {
    id: "templates",	//表格id
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
        {title: '名称', field: 'templateName', align: 'center', valign: 'middle', sortable: true},
        {title: '路径', field: 'templatePath', align: 'center', valign: 'middle', sortable: true},
        {title: '上传人', field: 'addUser', align: 'center', valign: 'middle', sortable: true},
        {title: '上传时间', field: 'uploadTime', align: 'center', valign: 'middle', sortable: true}
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
        template.seItem = selected[0];
        return true;
    }
};

/**
 * 点击添加通知
 */
template.openAddTemplate = function () {
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
 * 打开查看通知详情
 */
template.openTemplateDetail = function () {
    if (this.check()) {
        var index = layer.open({
            type: 2,
            title: '通知详情',
            area: ['800px', '420px'], //宽高
            fix: false, //不固定
            maxmin: true,
            content: '/template/modi/' + template.seItem.templateId
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
            var ajax = new $ax("/notice/delete", function (data) {
                ice.success("删除成功!");
                template.table.refresh();
            }, function (data) {
                ice.error("删除失败!" + data.responseJSON.message + "!");
            });
            ajax.set("noticeId", template.seItem.id);
            ajax.start();
        };

        ice.confirm("是否删除通知 " + template.seItem.title + "?", operation);
    }
};

/**
 * 查询通知列表
 */
template.search = function () {
    var queryData = {};
    queryData['templateName'] = $("#templateName").val();
    template.table.refresh({query: queryData});
};

$(function () {
    var defaultColunms = template.initColumn();
    var table = new BSTable(template.id, "/template/data", defaultColunms);
    template.table = table.init();
    $("#btn_add").click(function () {
        template.openAddTemplate();
    });
    $("#btn_modi").click(function () {
        template.openTemplateDetail();
    });
    $("#btn_delete").click(function () {
        template.delete();
    });
    $("#btn_query").click(function () {
        template.search();
    });
});
