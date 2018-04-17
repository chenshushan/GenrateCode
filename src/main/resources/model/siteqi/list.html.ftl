<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html>
<head>
    <title>${comments}</title>
    <meta content="${comments}" name="keywords" />
    <meta content="${comments}" name="description" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <link rel="stylesheet" href="../frame/cdspui/scyd/css/style_home.css" /><!-- 公共样式 -->
    <script type="text/javascript"	src="/nrs/common/plugin/jquery-1.7.2.min.js"></script><!-- 渠道树不能用太高的jquery版本 -->
    <script type="text/javascript">	STC_RELATIVE_PATH = "../";</script>
</head>
<body>
<div id="top">
    <div class="c-top">
        <div class="w">

        </div>
    </div>
</div>
<!--STEP1.加载顶部 end-->
<!-- -------------------------------------------------------------- -->

<!--中间容器开始-->
<div class="w mgt-20 clearfix" id="main">

    <div class="c-jx-box">
        <dl class="mgt-10 c-jx-q-tj">
            <dt><h3 class="c-tt">查询条件</h3></dt>
            <dd>
                <div class="tj-box clearfix">
                <div class="querysub">
 <#list columns as column>

     <#if (column.ifSearch == "1")>
                        <div class="inner_line" style="display:inline;width:33%;float:left">
                            <div class="query_lbl half">
                                <span>${column.comments}:&nbsp;&nbsp;</span>
                            </div>
                            <div class="query_txt half">
                                <input type="text" id="${column.attrname}" name="${column.attrname}" class="txt_input"  />
                            </div>
                        </div>
     </#if>

 </#list>
                </div>


                    <div class="mgt-15 tc ">
                        <button class="s-btn-submit " onclick="doQuery()">查询</button>
                        <button class="s-btn-reset mgl-15" onclick="doReset()">重置</button>
                        <button class="s-btn-submit mgl-15" onclick="toEdit('A','')">新增</button>
                        <button class="s-btn-submit mgl-15" onclick="doExport()">导出</button>
                    </div>
                </div>
            </dd>
        </dl>
        <dl class="mgt-25  c-jx-q-tj">
            <dt><h3 class="c-tt">查询结果</h3></dt>
            <dd><div id="rptGrid" style="margin:0; padding:0"></div></dd>
        </dl>

    </div>
</div>
</div>

</div>


<iframe id="exportFrame" src="" style="display: none;"></iframe>
<!-- -------------------------------------------------------------- -->
<!--STEP3.加载底部 begin-->
<div class="c-foot" id="copyright"></div>
<!--STEP3.加载底部 end-->

<!-- 公共js -->
<script type="text/javascript" src="../frame/base.js"></script><!-- 基础核心js必须加载 -->
<script type="text/javascript" src="../frame/include4mob.js"></script><!--常用的公共 样式和JS-->
<script type="text/javascript" src="../frame/include4Tree.js"></script><!-- Tree相关包括渠道树、类型树 -->
<script type="text/javascript" src="../common/js/common.js"></script><!-- 一些常用的公共方法 -->

<!-- 非公共部分js -->
<script charset="utf-8" type="text/javascript" src="${classname?lower_case }list.js"></script>

</body>
</html>