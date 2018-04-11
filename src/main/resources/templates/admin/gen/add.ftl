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
                        <h5>新建实体</h5>
                    </div>
                    <div class="ibox-content">
                        <form class="form-horizontal m-t" id="frm" method="post">
                        	<input type="hidden" id="id" name="id" value="${user.id}">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">类名：</label>
                                <div class="col-sm-8">
                                    <input id="className" name="className" class="form-control" type="text" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">表名：</label>
                                <div class="col-sm-8">
                                    <input id="tableName" name="tableName" class="form-control" type="text" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">备注：</label>
                                <div class="col-sm-8">
                                    <input id="remark" name="remark" class="form-control" type="text" value="${user.nickName}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">缓存：</label>
                                <div class="col-sm-8">
                                	<select name="useCache" class="form-control">
                                		<option value="0">否</option>
                                		<option value="1">是</option>
                                	</select>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-3">
                                    <button class="btn btn-primary" type="submit">提交</button>
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

	    $("#frm").validate({
    	    rules: {
    	    	className: {
                    required: true,
                    minlength: 4
                  },
    	      	remark: {
                    required: true,
                    minlength: 2
                  }
    	    },
    	    messages: {},
            //重写showErrors
            showErrors: function (errorMap, errorList) {
                var msg = "";
                $.each(errorList, function (i, v) {
                    //msg += (v.message + "\r\n");
                    //在此处用了layer的方法,显示效果更美观
                    layer.tips(v.message, v.element, { time: 2000 });
                    return false;
                });
            },
    	    submitHandler:function(form){
    	    	$.ajax({
   	    		   type: "POST",
   	    		   dataType: "json",
   	    		   url: "/gen/addTableOK",
   	    		   data: $(form).serialize(),
   	    		   success: function(data){
	   	    			layer.msg(data.msg, {time: 2000},function(){
	   	    			    if(data.code == 1){
                                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                parent.layer.close(index);
                            }
	   					});
   	    		   }
   	    		});
            } 
    	});
    });
    </script>

</body>

</html>
