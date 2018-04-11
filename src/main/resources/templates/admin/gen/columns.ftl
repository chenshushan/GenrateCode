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

</head>

<body >

<div class="panel-body" style="padding-bottom:0px;">
    <div class="panel panel-default">
        <div class="panel-heading">查询条件</div>
        <div class="panel-body">
            <form id="formSearch" class="form-horizontal">
                <div class="form-group" >
                    <label class="control-label col-sm-1" for="txt_search_departmentname">表名:</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" id="txt_search_departmentname">
                    </div>
                    <label class="control-label col-sm-1" for="txt_search_departmentname">类名:</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" id="txt_search_departmentname">
                    </div>
                    <label class="control-label col-sm-1" for="txt_search_departmentname">备注:</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" id="txt_search_departmentname">
                    </div>
                </div>
                <div class="form-group" >
                    <label class="control-label col-sm-1" for="txt_search_departmentname">使用缓存:</label>
                    <div class="col-sm-3">
                        <select class="form-control">
                            <option value="1">是</option>
                            <option value="0">否</option>
                        </select>
                    </div>
                </div>



                <div class="col-sm-4"  >
                    <button type="button"  id="btn_query" class="btn btn-primary">查询</button>
                </div>
            </form>
        </div>
    </div>

    <div id="columnsToolbar" class="btn-group">
        <button id="btn_add" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
        </button>
        <button id="btn_edit" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
        </button>
        <button id="btn_delete" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
        </button>
    </div>
    <table id="columns" class="text-center"></table>
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
        var table = new BSTable("columns", "/gen/getTableColumns", defaultColunms);
        table.setPagination(false);
        table.setQueryParams({tableName:"${tableName}"});
        table.onEditableSave=function (field, row, oldValue, $el) {
//            alert(field+" "+oldValue);
            console.log(row);
            console.log($el);
        };
        table.init();
    });
    function initColumn() {
        var colums= [
            { field: 'columnName',title: '字段名' },
            { field: 'attrName',title: '属性名',editable:true },

            { field: 'dataType',title: '字段类型'},
            { field: 'attrType',title: '属性类型',
                editable:{
                    type: 'select',
                    source:[{value:"0",text:"Integer"},{value:"1",text:"Long"},{value:"2",text:"Float"},{value:"3",text:"BigDecimal"},{value:"4",text:"String"}
                    ,{value:"5",text:"Date"},{value:"6",text:"Double"},{value:"7",text:"Boolean"},{value:"8",text:"Reference"}]
                }
            },
            { field: 'reference',title: '引用类型',editable:true},
            { field: 'columnKey',title: '主键',
                formatter: function(value, row, index) {
                    if(value==1){
                        return "是";
                    }else{
                        return "否";
                    }
                }
            },
            { field: 'ifSearch',title: '是否可搜索',
                editable: {
                    type: 'select',
                    source:[{value:"1",text:"是"},{value:"0",text:"否"}]
                }
            },
            { field: 'ifShow',title: '是否展示',
                editable: {
                    type: 'select',
                    source:[{value:"1",text:"是"},{value:"0",text:"否"}]
                }
            },

            { field: 'columnComment', title: '注释',editable:true},
            { field: 'fieldLength', title: 'fieldLength'}

            ];

        return colums;
    }

</script>
</body>

</html>
