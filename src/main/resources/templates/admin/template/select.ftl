<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>模板列表</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <#include "/admin/common.ftl"/>

</head>

<body class="gray-bg">
<div class="panel-body" style="padding-bottom:0px;">
    <div class="panel panel-default">
        <div class="panel-heading">查询条件</div>
        <div class="panel-body">
            <form id="formSearch" class="form-horizontal">
                <div class="form-group" style="margin-top:15px">

                    <div class="col-sm-4 condition-div">
                        <label class="control-label col-sm-3" for="templateName">模板名称：</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="templateName" name="templateName">
                        </div>
                    </div>


                </div>
                <div class="form-group row">
                    <div class="col-sm-4 text-center">
                        <button type="button" onclick="search()" class="btn btn-primary">查询</button>
                    </div>
                </div>
            </form>

        </div>
    </div>

    <div id="templateToolbar" class="btn-group">
        <button id="btn_add" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
        </button>
        <button id="btn_modi" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
        </button>
        <button id="btn_delete" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
        </button>
    </div>
    <table id="templateTable" class="text-center"></table>
</div>

<input type="hidden" id="index">
<script>

    /**
     * 初始化表格的列
     */
    var defaultColunms = [
        {title: 'id', field: 'templateId', align: 'center', valign: 'middle'},
        {title: '模板路径', field: 'templatePath', align: 'center', valign: 'middle', sortable: true},
        {title: '模板名称', field: 'templateName', align: 'center', valign: 'middle', sortable: true},
        {
            field: "empty",
            title: '选中',
            formatter: function (value, row, index) {
                var str = "<a href=\"javascript:check('" + row.templateId + "','" + row.templateName + "')\">选中</a>";
                return str;
            }
        }
    ];


    var table = new BSTable("templateTable", "/template/data", defaultColunms);
    table.init();

    function check(id, name) {
        var selectKey = parent.document.getElementById('${selectKey}');
        $(selectKey).val(id);
        var selectName = parent.document.getElementById('${selectName}');
        $(selectName).val(name);

        var index = $("#index").val();
        parent.layer.close(index);
    };

    function search() {
        var queryData = {};
        queryData['addUser'] = $("#addUser").val();
        queryData['templateName'] = $("#templateName").val();
        triggerLog.table.refresh({query: queryData});
    };


</script>


</body>

</html>
