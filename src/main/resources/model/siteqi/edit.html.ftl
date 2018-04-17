<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html>
<head>
    <title>${comments}编辑</title>
    <meta content="关键字" name="keywords"/>
    <meta content="描述" name="description"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <link rel="stylesheet" href="../frame/cdspui/scyd/css/style_home.css"/><!-- 公共样式 -->
    <script type="text/javascript" src="/nrs/common/plugin/jquery-1.7.2.min.js"></script><!-- 渠道树不能用太高的jquery版本 -->
    <link href="/nrs/common/css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">    STC_RELATIVE_PATH = "../";</script>
    <style type="text/css">
        .querysub {
            height: 40px;
        }

        .inner_line {
            height: 40px;
            padding-top: 0px;
        }

        .l-text-wrapper {
            margin-left: 0px !important;
        }

        .numsInput {
            width: 30px;
            margin-left: 0px;
            margin-right: 20px;
            display: none
        }

    </style>
</head>
<body>
<!-- -------------------------------------------------------------- -->
<!--中间容器开始-->
<div class="c-jx-box" style="padding: 5px;">
    <dl class="c-jx-q-tj">
        <dd style="margin-top: 0px">
            <form id="${classname}InfoForm">
                <fieldset style="margin-right:3px;width:100%;border:1px solid #e1ecf9;">
                    <legend style="margin-left:10px;">${comments}</legend>
                    <div class="tj-box clearfix">
<#assign numsf=0 />
<#assign numsh=1 />
<#list columns as column>

    <#if (numsf % 2 == 0)>
                    <div class="querysub">
    </#if>
                            <div class="inner_line" style="display:inline;width:50%;float:left;">
                                <div class="query_lbl half">
                                    <span>${column.comments}:</span>
                                </div>
                                <div class="query_txt half">
                                    <input class="txt_input <#if (column.ifNull =='0' )>required</#if> " type="text" id="${column.attrname}" name="${column.attrname}" />
                                </div>
                            </div>

    <#if (numsh % 2 == 0)>
              </div>
    </#if>
    <#assign numsf= numsf + 1 />
    <#assign numsh= numsh + 1 />

</#list>

                    </div>
                </fieldset>

                <input type="hidden" id="priKey"/>
            </form>
            <div class="querysub" style="margin-top:5px;margin-bottom:5px;height:15px">
                <div class="inner_line" style="display:inline;width:99.8%;float:left;text-align:center;padding-top:0px;">
                    <button class="s-btn-export mgl-15" id="doUpdate"  onclick="${classname }Info.doEdit()">保存</button>
                    <button class="s-btn-export mgl-15" id="closeWind" onclick="doRefresh(); ">关闭</button>
                </div>
            </div>
        </dd>

    </dl>
</div>
<!--中间容器结束-->

<!-- 公共js -->
<script type="text/javascript" src="../frame/base.js"></script><!-- 基础核心js必须加载 -->
<script type="text/javascript" src="../frame/include4mob.js"></script><!--常用的公共 样式和JS-->
<script type="text/javascript" src="../frame/include4Tree.js"></script><!-- Tree相关包括渠道树、类型树 -->
<script type="text/javascript" src="../common/js/common.js"></script><!-- 一些常用的公共方法 -->

<!-- 非公共部分js -->
<script charset="utf-8" type="text/javascript" src="${classname?lower_case }edit.js"></script>

</body>
</html>