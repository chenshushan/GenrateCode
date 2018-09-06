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
                                <label class="control-label col-sm-3"  for="templateName">模板名称：</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="templateName" name="templateName">
                                </div>
                            </div>




                </div>
                <div class="form-group row">
                    <div class="col-sm-4 text-center" >
                        <button type="button" id="btn_query"  class="btn btn-primary">查询</button>
                    </div>
                </div>
            </form>

        </div>
    </div>

    <div id="templateToolbar" class="btn-group">
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
    <table id="templateTable" class="text-center"></table>
</div>


<script src="/model/template.js"></script>

</body>

</html>
