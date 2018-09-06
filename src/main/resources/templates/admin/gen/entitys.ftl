<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>实体列表</title>
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


</head>

<body class="gray-bg">
<div class="panel-body" style="padding-bottom:0px;">
    <div class="panel panel-default">
        <div class="panel-heading">查询条件</div>
        <div class="panel-body">
            <form id="formSearch" class="form-horizontal">
                <div class="form-group" style="margin-top:15px">
                    <label class="control-label col-sm-1" for="className">实体名：</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" id="className" name="className">
                    </div>
                    <div class="col-sm-3" >
                        <button type="button" id="btn_query"  class="btn btn-primary">查询</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div id="tb_departmentsToolbar" class="btn-group">
        <button id="btn_add" type="button" class="btn btn-default" onclick="addEntity()">
            <span class="glyphicon glyphicon-plus" aria-hidden="true" ></span>新增
        </button>
        <button id="btn_code" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>生成
        </button>
        <button id="btn_delete" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
        </button>
    </div>
    <table id="entitys" class="text-center"></table>
</div>

    <!-- 全局js -->
    <script src="/assets/js/jquery.min.js?v=2.1.4"></script>
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
            var table = new BSTable("entitys", "/gen/listTable", defaultColunms);
            table.setSortName("tableId");
            table.init();
            $("#btn_query").click(function () {
                var params = {className:$("#className").val()};
                table.refresh({query: params});
            });
            $("#btn_code").click(function () {
                //
                if(!check()){
                    return;
                }
                var selections = getSelections();
                var ids="";
                for (var i = 0;i< selections.length;i++){
                    var selection = selections[i];
                    var tableId = selection.tableId;
                    ids += tableId+",";
                }
                window.location = "/gen/code?tables="+ids;
            });
        });
        function getSelections() {
            var selected = $('#entitys').bootstrapTable('getSelections');
            return selected;
        }

        function check(){
            var selections = getSelections();
            var length = selections.length;
            if (length == 0) {
                alert("请先选中表格中的某一记录！");
                return false;
            } else {
                return true;
            }
        };


        function initColumn() {
            var colums= [{
                checkbox: true
            }, {
                field: 'tableId',
                title: 'id'
            }, {
                field: 'className',
                title: '实体名'
            }, {
                field: 'remark',
                title: '备注'
            },{
                field: 'template.templateName',
                title: '模板名称'
            },  {
                field: 'Desc',
                title: '描述',
                formatter: function(value, row, index) {
                    if(value == 1){
                        return "是";
                    }
                    return "否";
                }
            },{
                field: "empty",
                title:'操作',
                formatter: function(value, row, index) {
                    var str = "<a href='/gen/modiTable?tableId="+row.tableId+"'>编辑</a>";
                    return str;
                }
            } ];
            return colums;
        }

        function addEntity() {
            layer.open({
                type: 2,
                title: '实体添加',
                shadeClose: false,
                area: ['893px', '600px'],
                content: '/gen/add',
                model: true,
                end: function(index){
                    $('#entitys').bootstrapTable("refresh");
                }
            });
        }


    </script>


</body>

</html>
