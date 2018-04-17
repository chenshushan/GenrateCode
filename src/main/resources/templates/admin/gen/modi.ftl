<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>用户列表</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="/assets/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="/assets/css/font-awesome.css?v=4.4.0" rel="stylesheet">

    <link href="/assets/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">

    <link href="/assets/css/animate.css" rel="stylesheet">
    <link href="/assets/js/plugins/bootstrap-pagination/paging.css" rel="stylesheet">

    <link href="/assets/css/style.css?v=4.1.0" rel="stylesheet">
    <link href="/assets/js/plugins/bootstrap-table/bootstrap3-editable/css/bootstrap-editable.css?v=4.1.0" rel="stylesheet">
    <script src="/assets/js/jquery.min.js?v=2.1.4"></script>
</head>

<body >

<div class="panel-body" style="padding-bottom:0px;">
    <div class="panel panel-default">
        <div class="panel-heading">查询条件</div>
        <div class="panel-body">
            <form id="formSearch" class="form-horizontal" method="post" action="/gen/modiTableOK">
                <input name="tableId" type="hidden" value="${entity.tableId}">
                <div class="form-group" >
                    <label class="control-label col-sm-1" for="className">实体名:</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" id="className" name="className" value="${entity.className}" readonly>
                    </div>
                    <label class="control-label col-sm-1" for="className">表名:</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" id="tableName" name="tableName" value="${entity.tableName}" >
                    </div>
                    <label class="control-label col-sm-1" for="remark">备注:</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" id="remark" name="remark" value="${entity.remark}">
                    </div>　
                </div>

                <div class="form-group" >

                    <label class="control-label col-sm-1" for="txt_search_departmentname">缓存:</label>
                    <div class="col-sm-3">
                        <select class="form-control" name="useCache" id="useCache">
                            <option value="1">是</option>
                            <option value="0">否</option>
                        </select>
                    </div>
                    <script>
                        $("#useCache").val("${entity.useCache.index}");
                    </script>
                </div>

                <div class="col-sm-4"  >
                    <button type="submit"  id="btn_query" class="btn btn-primary">修改</button>
                </div>
            </form>
        </div>
    </div>

    <div id="columnsToolbar" class="btn-group">
        <button id="btn_add" type="button" class="btn btn-default" onclick="addField()">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增字段
        </button>
    </div>
    <table id="fields" class="text-center"></table>
</div>
    <!-- 全局js -->

    <script src="/assets/js/bootstrap.min.js?v=3.3.6"></script>
	<!-- Bootstrap table -->
    <script src="/assets/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
    <script src="/assets/js/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
    <script src="/assets/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>

    <script src="/assets/js/plugins/bootstrap-table/bootstrap-table-object.js"></script>
    <script src="/assets/js/plugins/bootstrap-table/bootstrap3-editable/js/bootstrap-editable.js"></script>
    <script src="/assets/js/plugins/bootstrap-table/editable/bootstrap-table-editable.js"></script>
    <!-- Peity -->
    <script src="/assets/js/plugins/peity/jquery.peity.min.js"></script>
    <script src="/assets/js/plugins/layer/layer.min.js"></script>
    <script src="/assets/js/plugins/bootstrap-pagination/paging.js"></script>
    <!-- 自定义js -->
    <script src="/assets/js/content.js?v=1.0.0"></script>

<script>
    $(function () {
        var defaultColunms = initColumn();
        var table = new BSTable("fields", "/gen/listField", defaultColunms);
        table.setPageSize(100);
        table.setSortName("fieldId");
        table.setQueryParams({tableId:"${entity.tableId}"});
        table.init();
    });
    function initColumn() {
        var colums= [
            { field: 'fieldId',title: 'id'},
            { field: 'fieldName',title: '属性名'},
            { field: 'columnName',title: '列名'},
            { field: 'description', title: '注释'},
            { field: 'javaFieldType',title: '属性类型'  },
            { field: 'reference',title: '引用类型' },
            { field: 'ifSearch',title: '是否可搜索'  },
            { field: 'ifShow',title: '是否展示' },
            { field: 'ifNull',title: '是否可为空' },
            { field: 'fieldLength', title: 'fieldLength'},
            {  field: "empty", title:'操作',
                formatter: function(value, row, index) {
                    var str = "<a href='javascript:void(0)' onclick='modiField(" + row.fieldId + ")'>编辑</a>";
                    return str;
                }
            }
            ];

        return colums;
    }
    function addField() {
        layer.open({
            type: 2,
            title: '实体添加',
            shadeClose: false,
            area: ['893px', '400px'],
            content: '/gen/saveOrUpdateField?tableId='+${entity.tableId},
            model: true,
            end: function(index){
                $('#fields').bootstrapTable("refresh");
            }
        });
    }
    function modiField(fieldId) {
        layer.open({
            type: 2,
            title: '实体添加',
            shadeClose: false,
            area: ['893px', '400px'],
            content: "/gen/saveOrUpdateField?fieldId="+ fieldId +"&tableId=${entity.tableId}",
            model: true,
            end: function(index){
                $('#fields').bootstrapTable("refresh");
            }
        });
    }

</script>
</body>

</html>
