<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>用户列表</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="${ctx!}/assets/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx!}/assets/css/font-awesome.css?v=4.4.0" rel="stylesheet">

    <link href="${ctx!}/assets/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">

    <link href="${ctx!}/assets/css/animate.css" rel="stylesheet">
    <link href="${ctx!}/assets/js/plugins/bootstrap-pagination/paging.css" rel="stylesheet">

    <link href="${ctx!}/assets/css/style.css?v=4.1.0" rel="stylesheet">


</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content  animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox ">
                    <div class="ibox-title">
                        <h5>用户管理</h5>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="ibox float-e-margins">
                                <div class="ibox-content">
                                    <form class="form-horizontal m-t" id="frm" method="post" action="${ctx!}/admin/user/edit">
                                        <div class="row">
                                            <div class="col-lg-12 col-sm-12">

                                                <div class="row">

                                                    <div class="col-lg-3 col-sm-3">
                                                        <div class="input-group">
                                                            <div class="input-group-btn">
                                                                <button data-toggle="dropdown"  class="btn btn-white dropdown-toggle" type="button">字段名
                                                                </button>
                                                            </div>
                                                            <input type="text" class="form-control" readonly />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3 col-sm-3">
                                                        <div class="input-group">
                                                            <div class="input-group-btn">
                                                                <button data-toggle="dropdown"  class="btn btn-white dropdown-toggle" type="button">类属性名
                                                                </button>
                                                            </div>
                                                            <input type="text" class="form-control"  />
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-3 col-sm-3">
                                                        <div class="input-group">
                                                            <div class="input-group-btn">
                                                                <button data-toggle="dropdown"  class="btn btn-white dropdown-toggle" type="button">备注
                                                                </button>
                                                            </div>
                                                            <input type="text" class="form-control" placeholder="备注" value="备注"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3 col-sm-3">
                                                        <div class="input-group">
                                                            <div class="input-group-btn">
                                                                <button data-toggle="dropdown"  class="btn btn-white dropdown-toggle" type="button">长度
                                                                </button>
                                                            </div>
                                                            <input type="text" class="form-control" placeholder="默认" value="默认"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-3 col-sm-3">
                                                        <div class="input-group">
                                                            <div class="input-group-btn">
                                                                <button data-toggle="dropdown"  class="btn btn-white dropdown-toggle" type="button">字段类型
                                                                </button>
                                                            </div>
                                                            <input type="text" class="form-control" placeholder="字段类型" readonly/>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-3 col-sm-3">
                                                        <div class="input-group">
                                                            <div class="input-group-btn">
                                                                <button data-toggle="dropdown"  class="btn btn-white dropdown-toggle" type="button">java类型
                                                                </button>
                                                            </div>
                                                            <select class="form-control">
                                                                <option value="1">1</option>
                                                                <option value="1">2</option>
                                                            </select>

                                                        </div>
                                                    </div>

                                                    <div class="col-lg-3 col-sm-3">
                                                        <div class="input-group">
                                                            <div class="input-group-btn">
                                                                <button data-toggle="dropdown"  class="btn btn-white dropdown-toggle" type="button">引用类型
                                                                </button>
                                                            </div>
                                                            <input type="text" class="form-control" placeholder="引用类型"/>
                                                        </div>
                                                    </div>

                                                </div>




                                                <div class="row">


                                                    <div class="col-lg-2  col-sm-2">
                                                        <div class="input-group">
                                                            <div class="input-group-btn">
                                                                <button data-toggle="dropdown"  class="btn btn-white dropdown-toggle" type="button">查询：
                                                                </button>
                                                            </div>
                                                            <select class="form-control">
                                                                <option value="1">1</option>
                                                                <option value="1">2</option>
                                                            </select>

                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2  col-sm-2">
                                                        <div class="input-group">
                                                            <div class="input-group-btn">
                                                                <button data-toggle="dropdown"  class="btn btn-white dropdown-toggle" type="button">为空：
                                                                </button>
                                                            </div>
                                                            <select class="form-control">
                                                                <option value="1">1</option>
                                                                <option value="1">2</option>
                                                            </select>

                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2  col-sm-2">
                                                        <div class="input-group">
                                                            <div class="input-group-btn">
                                                                <button data-toggle="dropdown"  class="btn btn-white dropdown-toggle" type="button">列表页显示
                                                                </button>
                                                            </div>
                                                            <select class="form-control">
                                                                <option value="1">1</option>
                                                                <option value="1">2</option>
                                                            </select>

                                                        </div>
                                                    </div>


                                                </div>

                                            </div>
                                            <div class="col-lg-2 col-sm-3">
                                                <div class="row">
                                                    <div class="col-lg-12 col-sm-12">

                                                        <button type="button" class="btn btn-primary "
                                                                onclick="MgrUser.search()">
                                                            <i class="fa fa-search"></i>&nbsp;搜索
                                                        </button>


                                                        <button type="button" class="btn btn-primary button-margin"
                                                                onclick="MgrUser.resetSearch()">
                                                            <i class="fa fa-trash"></i>&nbsp;重置
                                                        </button>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="ibox-content">

                        <div class="row row-lg">
		                    <div class="col-sm-12">

		                        <!-- Example Card View -->
		                        <div class="example-wrap">
		                            <div class="example">

                                        <table id="test" class="table text-center">
                                            <caption>基本的表格布局 <i class="glyphicon glyphicon-plus pull-right"></i></caption>
                                            <thead>
                                            <tr>
                                                <th>名称</th>
                                                <th>城市</th>
                                                <th>操作</th>
                                                <th>名称</th>
                                                <th>城市</th>
                                                <th>操作</th>
                                                <th>名称</th>
                                                <th>城市</th>
                                                <th>操作</th>
                                                <th>名称</th>
                                                <th>城市</th>
                                                <th>操作</th>
                                                <th>操作</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td><input type="text" readonly class="form-control" value="Tanmay"></td>
                                                <td><input type="text" readonly class="form-control" value="Bangalore"></td>
                                                <td><input type="text" readonly class="form-control" value="Bangalore"></td>
                                                <td><input type="text" readonly class="form-control" value="Tanmay"></td>
                                                <td><input type="text" readonly class="form-control" value="Bangalore"></td>
                                                <td><input type="text" readonly class="form-control" value="Bangalore"></td>
                                                <td><input type="text" readonly class="form-control" value="Tanmay"></td>
                                                <td><input type="text" readonly class="form-control" value="Bangalore"></td>
                                                <td><input type="text" readonly class="form-control" value="Bangalore"></td>
                                                <td><input type="text" readonly class="form-control" value="Tanmay"></td>
                                                <td><input type="text" readonly class="form-control" value="Bangalore"></td>
                                                <td><input type="text" readonly class="form-control" value="Bangalore"></td>
                                                <td><i class="glyphicon glyphicon-pencil"></i>&nbsp;<i class="glyphicon glyphicon-remove"></i></td>
                                            </tr>
                                            <tr>
                                                <td><input type="text" readonly class="form-control" value="Tanmay"></td>
                                                <td><input type="text" readonly class="form-control" value="Bangalore"></td>
                                                <td><input type="text" readonly class="form-control" value="Bangalore"></td>
                                                <td><input type="text" readonly class="form-control" value="Tanmay"></td>
                                                <td><input type="text" readonly class="form-control" value="Bangalore"></td>
                                                <td><input type="text" readonly class="form-control" value="Bangalore"></td>
                                                <td><input type="text" readonly class="form-control" value="Tanmay"></td>
                                                <td><input type="text" readonly class="form-control" value="Bangalore"></td>
                                                <td><input type="text" readonly class="form-control" value="Bangalore"></td>
                                                <td><input type="text" readonly class="form-control" value="Tanmay"></td>
                                                <td><input type="text" readonly class="form-control" value="Bangalore"></td>
                                                <td><input type="text" readonly class="form-control" value="Bangalore"></td>
                                                <td><i class="glyphicon glyphicon-pencil"></i>&nbsp;<i class="glyphicon glyphicon-remove"></i></td>
                                            </tr>

                                            </tbody>
                                        </table>

                                    </div>
		                        </div>
		                        <!-- End Example Card View -->
		                    </div>
	                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 全局js -->
    <script src="${ctx!}/assets/js/jquery.min.js?v=2.1.4"></script>
    <script src="${ctx!}/assets/js/bootstrap.min.js?v=3.3.6"></script>
	<!-- Bootstrap table -->
    <script src="${ctx!}/assets/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
    <script src="${ctx!}/assets/js/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
    <script src="${ctx!}/assets/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
    <!-- Peity -->
    <script src="${ctx!}/assets/js/plugins/peity/jquery.peity.min.js"></script>
    <script src="${ctx!}/assets/js/plugins/layer/layer.min.js"></script>
    <script src="${ctx!}/assets/js/plugins/bootstrap-pagination/paging.js"></script>
    <!-- 自定义js -->
    <script src="${ctx!}/assets/js/content.js?v=1.0.0"></script>
    <script>
        $(function(){
            var tdTemple='<tr><td><input type="text" class="form-control" value="" placeholder="请输入"></td><td><input type="text" class="form-control" value="" placeholder="请输入"></td><td><i class="glyphicon glyphicon-pencil"></i><i class="glyphicon glyphicon-remove"></i></td></tr>';
            $("#test").on("click",".glyphicon-plus",function(){ //点击添加图标 在表格后面加一行
                $("table tbody").append($(tdTemple));
            });
            $("#test").on("click",".glyphicon-remove",function(){//点击删除图标 删除一整行
                $(this).parent().parent().remove();
            });
            $("#test").on("click",".glyphicon-pencil",function(){  //点击修改图标 解除只读状态
                $(this).parent().parent().find("input").removeAttr("readonly");
                $(this).parent().parent().find("td:nth-child(1) input").focus();
            });
            $("#test").on("blur","input",function(){ //input失去焦点变成只读状态
                $(this).attr("readonly","readonly")
            })

        })
    </script>


</body>

</html>
