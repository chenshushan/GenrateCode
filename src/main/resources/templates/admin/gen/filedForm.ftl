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
                        <form id="frm" class="form-horizontal">
                            <div class="form-group" >
                                <label class="control-label col-sm-2" for="fieldName">属性名:</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="fieldName" name="fieldName"
                                           <#if (modi == 'modi')> readonly</#if>
                                           value="${entity.fieldName}">
                                </div>
                                <label class="control-label col-sm-2" for="description">备注:</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="description" name="description" value="${entity.description}">
                                </div>
                            </div>


                            <div class="form-group" >
                                <label class="control-label col-sm-2" for="fieldName">列名:</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="columnName" name="columnName" value="${entity.columnName}">
                                </div>

                            </div>



                            <div class="form-group" >
                                <label class="control-label col-sm-2" for="javaFieldType">属性类型:</label>
                                <div class="col-sm-4">
                                    <select name="javaFieldType" id="javaFieldType"  class="form-control" >
                                        ${dropDwonType}
                                    </select>
                                </div>
                                <label class="control-label col-sm-2" for="reference">引用类型:</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="reference" name="reference" placeholder="引用类型时可不填写" value="${entity.reference}">
                                </div>
                            </div>
                            <div class="form-group" >
                                <label class="control-label col-sm-2" for="fieldLength">字段长度:</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="fieldLength" name="fieldLength" placeholder="可不填，生成默认长度" value="${entity.fieldLength}">
                                </div>
                                <label class="control-label col-sm-2" for="ifShow">是否展示:</label>
                                <div class="col-sm-4">
                                    <select name="ifShow" id="ifShow"  class="form-control" >
                                        ${dropDwon}
                                    </select>
                                </div>
                            </div>
                            <div class="form-group" >
                                <label class="control-label col-sm-2" for="ifSearch">是否可搜索:</label>
                                <div class="col-sm-4">
                                    <select name="ifSearch" id="ifSearch"  class="form-control" >
                                        ${dropDwon}
                                    </select>
                                </div>
                                <label class="control-label col-sm-2" for="ifNull">是否可为空:</label>
                                <div class="col-sm-4">
                                    <select name="ifNull" id="ifNull"  class="form-control" >
                                        ${dropDwon}
                                    </select>
                                </div>
                            </div>
                            <input type="hidden" name="table.tableId" value="${tableId}" id="tableId">
                            <input type="hidden" name="fieldId" value="${entity.fieldId}" id="fieldId">
                            <div class="form-group" >
                                <div class="col-sm-offset-6"  >
                                    <button  id="btn_query" type="submit" class="btn btn-primary">提交</button>&nbsp;
                                    <button  id="btn_reset" type="reset" class="btn btn-primary">重置</button>
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
    <script type="text/javascript">
    $(document).ready(function () {
        $("#ifNull").val(${entity.ifNull.index});
        $("#ifShow").val(${entity.ifShow.index});
        $("#ifSearch").val(${entity.ifSearch.index});
        $("#javaFieldType").val(${entity.javaFieldType.index});
        var fieldId = $("#fieldId").val();

	    $("#frm").validate({
    	    rules: {
                fieldName: {
                    required: true
                  },
                description: {
                    required: true,
                    minlength: 2
                  }
    	    },
    	    messages: {},
    	    submitHandler:function(form){
    	    	$.ajax({
   	    		   type: "POST",
   	    		   dataType: "json",
   	    		   url: "/gen/saveOrUpdateFieldOK",
   	    		   data: $(form).serialize(),
   	    		   success: function(data){
                       if(data.code == 1 ){
                           layer.msg("操作成功");
                           if(fieldId){
                               return;
                           }
                           $("#btn_reset").click();
                       }else{
                           layer.msg(data.msg);
                       }
   	    		   }
   	    		});
            } 
    	});
    });
    </script>

</body>

</html>
