CREATE TABLE  "${tableName }"(
<#list columns as column>

    <#if (column.attrType == "String")>
        "${column.columnName}" VARCHAR2(${column.fieldLength }) <#if (column.ifNull  == "0")>NOT NULL ENABLE</#if> ,
    <#elseif (column.attrType == "Integer" || column.attrType == "Long" || column.attrType == "Float" || column.attrType == "BigDecimal" || column.attrType == "Double")>       <#--注意这里没有返回而是在最后面-->
        "${column.columnName}" NUMBER <#if (column.ifNull  == "0")>NOT NULL ENABLE</#if>  ,
    <#elseif (column.attrType == "Date")>
        "${column.columnName}" DATE <#if (column.ifNull  == "0")>NOT NULL ENABLE</#if>  ,
    <#else>
    </#if>
</#list>
	"${classname?upper_case}ID" VARCHAR2(100) NOT NULL ENABLE,
	"STATE" VARCHAR2(100) NOT NULL ENABLE
   );

<#list columns as column>
   COMMENT ON COLUMN  "${tableName }"."${column.columnName}" IS '${column.comments }';
</#list>

CREATE TABLE  "${tableName }HIS"(
<#list columns as column>

    <#if (column.attrType == "String")>
        "${column.columnName}" VARCHAR2(${column.fieldLength }) <#if (column.ifNull  == "0")>NOT NULL ENABLE</#if> ,
    <#elseif (column.attrType == "Integer" || column.attrType == "Long" || column.attrType == "Float" || column.attrType == "BigDecimal" || column.attrType == "Double")>       <#--注意这里没有返回而是在最后面-->
        "${column.columnName}" NUMBER <#if (column.ifNull  == "0")>NOT NULL ENABLE</#if>  ,
    <#elseif (column.attrType == "Date")>
        "${column.columnName}" DATE <#if (column.ifNull  == "0")>NOT NULL ENABLE</#if>  ,
    <#else>
    </#if>
</#list>
    "${classname?upper_case}ID" VARCHAR2(100) NOT NULL ENABLE,
    "STATE" VARCHAR2(100) NOT NULL ENABLE,
    "OP_LOGIN" VARCHAR2(100),
	"OP_TIME" DATE,
	"OP_TYPE" VARCHAR2(20)
   );

<#list columns as column>
   COMMENT ON COLUMN "${tableName }HIS"."${column.columnName}" IS '${column.comments }';
</#list>



create sequence SEQ_${tableName }_KEY
start with 10000
increment by 1;