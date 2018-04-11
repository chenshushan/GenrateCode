<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title> - 新建${comments}</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    ${'<#include "/admin/common.ftl"/>'}
</head>


<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>新建${comments}</h5>
                </div>


                <div class="panel-body">
                    <form id="${classname}InfoForm" class="form-horizontal">
                        <div class="form-group">
                        <#list columns as column>

                                <#if (column.attrType == "Reference")>
                                    <div class="condition-div col-sm-6">
                                        <label class="control-label col-sm-4" for="${column.attrname}.${column.attrname}Id">${column.comments}:</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="${column.attrname}.${column.attrname}Id" name="${column.attrname}.${column.attrname}Id" value="${'$'}{entity.${column.attrname}.${column.attrname}Id}">
                                        </div>
                                    </div>
                                <#elseif (column.attrType == "Enum")>
                                    <div class="condition-div col-sm-6">
                                        <label class="control-label col-sm-4" for="${column.attrname}">${column.comments}:</label>
                                        <div class="col-sm-8">
                                            <select name="${column.attrname}" id="${column.attrname}"  class="form-control ">
                                                <option value="">所有</option>
                                                ${'$'}{${column.attrname}EnumOptions}
                                            </select>
                                        </div>
                                    </div>
                                <#else>
                                    <div class="condition-div col-sm-6">
                                        <label class="control-label col-sm-4" for="${column.attrname}">${column.comments}:</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="${column.attrname}" name="${column.attrname}" value="${'$'}{entity.${column.attrname}}">
                                        </div>
                                    </div>

                                </#if>
                        </#list>

                        </div>

                        <div class="form-group">
                            <div class="col-sm-12 text-center">
                                <button id="btn_query" onclick="${classname}Info.addSubmit()" class="btn btn-primary">提交
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

<script src="/model/${classname}Info.js"></script>

</body>

</html>
