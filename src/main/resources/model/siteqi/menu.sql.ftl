CREATE TABLE "CHNCLOUD"."${tableName }"(
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
	"PRI_KEY" VARCHAR2(50) NOT NULL ENABLE
   )

<#list columns as column>
   COMMENT ON COLUMN "CHNCLOUD"."${tableName }"."${column.columnName}" IS '${column.comments }';
</#list>

CREATE TABLE "CHNCLOUD"."${tableName }His"(
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
    "OP_LOGIN" VARCHAR2(20),
	"OP_TIME" VARCHAR2(50),
	"OP_TYPE" VARCHAR2(20)
   )

<#list columns as column>
   COMMENT ON COLUMN "CHNCLOUD"."${tableName }His"."${column.columnName}" IS '${column.comments }';
</#list>
