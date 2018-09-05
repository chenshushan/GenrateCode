<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>${comments}列表</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    ${'<#include "/admin/common.ftl"/>'}

</head>

<body class="gray-bg">
<div class="panel-body" style="padding-bottom:0px;">
    <div class="panel panel-default">
        <div class="panel-heading">查询条件</div>
        <div class="panel-body">
            <form id="formSearch" class="form-horizontal">
                <div class="form-group" style="margin-top:15px">


                <#list columns as column>
                    <#if (column.ifSearch == "1")>

                        <#if (column.attrType == "Reference")>
                            <div class="col-sm-4 condition-div">
                                <label class="control-label col-sm-3"  for="${column.attrname}.${column.attrname}Id">${column.comments}：</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="${column.attrname}.${column.attrname}Id" name="${column.attrname}.${column.attrname}Id">
                                </div>
                            </div>
                        <#elseif (column.attrType == "Enum")>
                            <div class="col-sm-4 condition-div">
                                <label class="control-label col-sm-3"  for="${column.attrname}">${column.comments}：</label>
                                <div class="col-sm-9">
                                    <select name="${column.attrname}" id="${column.attrname}"  class="form-control ">
                                        <option value="">所有</option>
                                        ${'$'}{${column.attrname}EnumOptions}
                                    </select>
                                </div>
                            </div>
                        <#elseif (column.attrType == "String")>
                            <div class="col-sm-4 condition-div">
                                <label class="control-label col-sm-3"  for="${column.attrname}">${column.comments}：</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="${column.attrname}" name="${column.attrname}">
                                </div>
                            </div>
                        <#else>
                            <div class="col-sm-4 condition-div">
                                <label class="control-label col-sm-3">${column.comments}：</label>
                                <div class="col-sm-9">
                                    <span class="col-sm-5 rang-search">
                                        <input type="text" class="form-control " id="${column.attrname}Begin" name="${column.attrname}Begin">
                                    </span>
                                    <label class="control-label col-sm-2 rang-search" style="text-align: center">至</label>
                                    <span class="col-sm-5 rang-search">
                                        <input type="text" class="form-control "  id="${column.attrname}End" name="${column.attrname}End">
                                    </span>
                                </div>
                            </div>

                        </#if>

                    </#if>

                </#list>


                </div>
                <div class="form-group row">
                    <div class="col-sm-4 text-center" >
                        <button type="button" onclick="search()"   class="btn btn-primary">查询</button>
                    </div>
                </div>
            </form>

        </div>
    </div>

    <div id="${classname}Toolbar" class="btn-group">
        <button id="btn_add" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-plus" aria-hidden="true" ></span>新增
        </button>
        <button id="btn_modi" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
        </button>
        <button id="btn_delete" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
        </button>
    </div>
    <table id="${classname}Table" class="text-center"></table>
</div>

<input type="hidden" id="index">
<script>
    var defaultColunms = [
        {title: 'id', field: 'platformId', visible: false, align: 'center', valign: 'middle'},
        {title: '平台token', field: 'token', align: 'center', valign: 'middle', sortable: true},
        {title: '平台名称', field: 'platformName', align: 'center', valign: 'middle', sortable: true},
        {
            field: "empty",
            title:'选中',
            formatter: function(value, row, index) {
                var str = "<a href=\"javascript:check(" +row.platformId+",'"+ row.platformName +"')\">选中</a>";
                return str;
            }
        }
    ];


    /**
     * 初始化表格的列
     */
    var defaultColunms = [
            {title: 'id', field: '${classname}Id', visible: false, align: 'center', valign: 'middle'},
        <#list columns as column>
            <#if (column.ifShow == "1")>
                {title: '${column.comments}', field: '${column.attrname}', align: 'center', valign: 'middle', sortable: true},
            </#if>
        </#list>
            {
                field: "empty",
                title:'选中',
                formatter: function(value, row, index) {
                    var str = "<a href=\"javascript:check(" +row.'${classname}Id'+",'"+ row.'${classname}Name' +"')\">选中</a>";
                    return str;
                }
            }
        ];


    var table = new BSTable("${classname}Table", "/${classname}/data", defaultColunms);
    table.init();
    function check(id,name) {
        var selectKey = parent.document.getElementById('${'$'}{selectKey}');
        $(selectKey).val(id);
        var selectName = parent.document.getElementById('${'$'}{selectName}');
        $(selectName).val(name);

        var index = $("#index").val();
        parent.layer.close(index);
    };

    function search() {
        var queryData = {};
    <#list columns as column>
        <#if (column.ifSearch == "1")>
        queryData['${column.attrname}'] = $("#${column.attrname}").val();
        </#if>
    </#list>
        triggerLog.table.refresh({query: queryData});
    };



</script>


</body>

</html>
