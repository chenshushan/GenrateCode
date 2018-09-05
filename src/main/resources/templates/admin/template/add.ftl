<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title> - 新建模板</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <#include "/admin/common.ftl"/>
</head>


<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>新建模板</h5>
                </div>


                <div class="panel-body">
                    <form id="templateInfoForm" class="form-horizontal">
                        <div class="form-group">


                            <div class="condition-div col-sm-6">
                                <label class="control-label col-sm-4" for="templateName">模板名称:</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="templateName" name="templateName" value="${entity.templateName}">
                                </div>
                            </div>


                            <div class="condition-div col-sm-6">
                                <label class="control-label col-sm-4" for="templatePath">路径:</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" onclick="$('#filePath').click();" readonly  id="templatePath" value="${entity.templatePath}">
                                    <input id="filePath" name="file"  class="form-control"  type="file"  style="display: none" onchange="$(this).prev().val($(this).val())">
                                </div>
                            </div>


                                    <div class="condition-div col-sm-6">
                                        <label class="control-label col-sm-4" for="addUser.addUserId">上传人:</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="addUser.addUserId" name="addUser.addUserId" value="${entity.addUser.addUserId}">
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

<script src="/model/template_info.js"></script>

</body>

</html>
