<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title> - 新建实体</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="favicon.ico">
    <link href="/assets/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="/assets/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="/assets/css/animate.css" rel="stylesheet">
    <link href="/assets/css/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>新建属性</h5>
                </div>


                <div class="panel-body">
                    <form id="templateInfoForm" class="form-horizontal">
                        <div class="form-group">
                            <div class="condition-div col-sm-6">
                                <label class="control-label col-sm-4" for="templateName">属性名:</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="templateName" name="templateName"
                                           value="${entity.templateName}">
                                </div>
                            </div>
                            <div class="condition-div col-sm-6">
                                <label class="control-label col-sm-4" for="templatePath">备注:</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="templatePath" name="templatePath"
                                           value="${entity.templatePath}">
                                </div>
                            </div>
                            <div class="condition-div col-sm-6">
                                <label class="control-label col-sm-4" for="addUser">属性类型:</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="addUser" name="addUser"
                                           value="${entity.addUser}">
                                </div>
                            </div>
                            <div class="condition-div col-sm-6">
                                <label class="control-label col-sm-4" for="uploadTime">上传时间:</label>
                                <div class="col-sm-8">
                                    <input id="uploadTime" name="uploadTime" readonly="readonly"
                                           class="laydate-icon form-control layer-date">

                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-12 text-center">
                                <button id="btn_query" onclick="templateInfo.addSubmit()" class="btn btn-primary">提交
                                </button>&nbsp;
                                <button id="btn_reset" type="reset" class="btn btn-primary">重置</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>


<!-- 全局js -->
<script src="/assets/js/jquery.min.js?v=2.1.4"></script>
<script src="/assets/js/bootstrap.min.js?v=3.3.6"></script>

<!-- 自定义js -->
<script src="/assets/js/content.js?v=1.0.0"></script>

<!-- jQuery Validation plugin javascript-->
<script src="/assets/js/plugins/validate/jquery.validate.min.js"></script>
<script src="/assets/js/plugins/validate/messages_zh.min.js"></script>
<script src="/assets/js/plugins/layer/layer.min.js"></script>
<script src="/assets/js/plugins/layer/laydate/laydate.js"></script>
<script src="/assets/js/user/ice.js"></script>
<script src="/assets/js/user/ajax-object.js"></script>
<script src="/assets/js/plugins/bootstrap-table/bootstrap-table-object.js"></script>
<script src="/model/template_info.js"></script>


</body>

</html>
