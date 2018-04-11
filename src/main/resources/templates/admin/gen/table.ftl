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

<body class="gray-bg">
<div class="panel-body" style="padding-bottom:0px;">
    <div class="panel panel-default">
        <div class="panel-heading">查询条件</div>
        <div class="panel-body">
            <form id="formSearch" class="form-horizontal">
                <div class="form-group" style="margin-top:15px">
                    <label class="control-label col-sm-1" for="txt_search_departmentname">部门名称</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" id="txt_search_departmentname">
                    </div>
                    <label class="control-label col-sm-1" for="txt_search_statu">状态</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" id="txt_search_statu">
                    </div>
                    <div class="col-sm-4" style="text-align:left;">
                        <button type="button" style="margin-left:50px" id="btn_query" class="btn btn-primary">查询</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div id="tb_departmentsToolbar" class="btn-group">
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
    <table id="tb_departments"></table>
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
            var table = new BSTable("tb_departments", "/gen/tdata", defaultColunms);
            table.setSortName("dept");

            table.setQueryParams({sort:"bianhao",status:1});
            table.responseHandler =function (res) {
                return {
                    "rows": res.row,
                    "total": res.total
                };
            };

            table.onEditableSave=function (field, row, oldValue, $el) {
                alert(field+" "+oldValue);
                console.log(row);
                console.log($el);
//                $.ajax({
//                    type: "post",
//                    url: "/Editable/Edit",
//                    data: { strJson: JSON.stringify(row) },
//                    success: function (data, status) {
//                        if (status == "success") {
//                            alert("编辑成功");
//                        }
//                    },
//                    error: function () {
//                        alert("Error");
//                    },
//                    complete: function () {
//
//                    }
//
//                });
            };

            table.init();
            //1.初始化Table
//            var oTable = new TableInit();
//            oTable.Init();

            //2.初始化Button的点击事件
            var oButtonInit = new ButtonInit();
            oButtonInit.Init();

        });

        function initColumn() {
            var colums= [{
                checkbox: true
            }, {
                field: 'Name',
                title: '部门名称',
                editable: {
                    type: 'text',
                    title: '年龄',
                    validate: function (v) {
                        if (isNaN(v)) return '年龄必须是数字';
                        var age = parseInt(v);
                        if (age <= 0) return '年龄必须是正整数';
                    }
                }
            }, {
                field: 'ParentName',
                title: '上级部门',
                editable: {
                    type: 'date',
                    title: '生日'
                },
                formatter: function(value, row, index) {
                    if(value){
                        return value;
                    }
                    return "无值";
                }
            }, {
                field: 'Level',
                title: '部门级别',
                editable: {
                    type: 'select',
                    title: '部门',
                    source:[{value:"1",text:"研发部"},{value:"2",text:"销售部"},{value:"3",text:"行政部"}]
                }
            }, {
                field: 'Desc',
                editable:true,
                title: '描述'
            } ];
            return colums;
        }

        var TableInit = function () {
            var oTableInit = new Object();
            //初始化Table
            oTableInit.Init = function () {
                $('#tb_departments').bootstrapTable({
                    url: '/gen/tdata',         //请求后台的URL（*）
                    method: 'get',                      //请求方式（*）
                    toolbar: '#toolbar',                //工具按钮用哪个容器
                    striped: true,                      //是否显示行间隔色
                    cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                    pagination: true,                   //是否显示分页（*）
                    sortable: true,                     //是否启用排序
                    sortOrder: "desc",                   //排序方式
                    queryParams: oTableInit.queryParams,//传递参数（*）
                    sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                    pageNumber:1,                       //初始化加载第一页，默认第一页
                    pageSize: 10,                       //每页的记录行数（*）
                    pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
                    search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
                    strictSearch: true,
                    showColumns: true,                  //是否显示所有的列
                    showRefresh: true,                  //是否显示刷新按钮
                    minimumCountColumns: 2,             //最少允许的列数
                    clickToSelect: true,                //是否启用点击选中行
                    height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                    uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
                    showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
                    cardView: false,                    //是否显示详细视图
                    detailView: false,                   //是否显示父子表
                    columns: [{
                        checkbox: true
                    }, {
                        field: 'Name',
                        title: '部门名称'
                    }, {
                        field: 'ParentName',
                        title: '上级部门'
                    }, {
                        field: 'Level',
                        title: '部门级别'
                    }, {
                        field: 'Desc',
                        title: '描述'
                    }, ]
                });
            };

            //得到查询的参数
            oTableInit.queryParams = function (params) {
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    limit: params.limit,   //页面大小
                    offset: params.offset,  //页码
                    order: params.order,
                    ordername: params.sort,
                    departmentname: $("#txt_search_departmentname").val(),
                    statu: $("#txt_search_statu").val()
                };
                return temp;
            };
            return oTableInit;
        };


        var ButtonInit = function () {
            var oInit = new Object();
            var postdata = {};

            oInit.Init = function () {
                //初始化页面上面的按钮事件
            };

            return oInit;
        };
    </script>


</body>

</html>
