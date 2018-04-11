-- 菜单SQL
INSERT INTO `sys_menu` (`parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
    VALUES ('1', '${comments}', 'generator/${classname}.html', NULL, '1', 'fa fa-file-code-o', '6');

-- 按钮父菜单ID
set @parentId = @@identity;

-- 菜单对应按钮SQL
INSERT INTO `sys_menu` (`parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
    SELECT @parentId, '查看', null, '${classname}:list,${classname}:info', '2', null, '6';
INSERT INTO `sys_menu` (`parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
    SELECT @parentId, '新增', null, '${classname}:save', '2', null, '6';
INSERT INTO `sys_menu` (`parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
    SELECT @parentId, '修改', null, '${classname}:update', '2', null, '6';
INSERT INTO `sys_menu` (`parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
    SELECT @parentId, '删除', null, '${classname}:delete', '2', null, '6';


create table ${tableName}(
    ${classname}Id int IDENTITY (1,1) PRIMARY KEY ,


    <#list columns as column>

        <#if (column.ifNull== "1")>
            <#assign isNull="if"/>
        <#elseif (column.ifNull== "0")>       <#--注意这里没有返回而是在最后面-->
            <#assign isNull="elseif"/>
        <#else>
            <#assign isNull="else"/>
        </#if>
        ${column.columnName} ${column.dataType} ${isNull},
    </#list>


createdTime datetime null,
modifiedTime datetime null,
modifiedCount int default 0,
status int null,
)