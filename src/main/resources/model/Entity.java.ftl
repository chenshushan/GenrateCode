package com.chen.code.entity;

import com.chen.code.entity.enumdo.EnumBaseStatus;
import org.hibernate.annotations.Parameter;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Date;



/**
* ${comments}
*/
@Entity
public class ${className} {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "${classname}Id")
	private Integer ${classname}Id;


<#list columns as column>
	// ${column.comments}

		<#if (column.attrType == "Reference")>
	@ManyToOne(targetEntity = ${column.reference}.class)
	private ${column.reference} ${column.attrname};
		<#elseif (column.attrType == "Enum")>
	@Type(type = "com.chen.code.common.IntegerValuedEnumType",parameters = {@Parameter(name = "enum",value = "com.chen.code.entity.enumdo.${column.reference}")})
	private ${column.reference} ${column.attrname};
		<#else>
	private ${column.attrType} ${column.attrname};
		</#if>

</#list>

	private Date createdTime;

	private Date modifiedTime;

	private Integer modifiedCount;

	@Type(type = "com.chen.code.common.IntegerValuedEnumType",parameters = {@Parameter(name = "enum",value = "com.chen.code.entity.enumdo.EnumBaseStatus")})
	private EnumBaseStatus status;



	public Integer get${className}Id() {
		return ${classname}Id;
	}

	public void set${className}Id(Integer ${classname}Id) {
		this.${classname}Id = ${classname}Id;
	}

<#list columns as column>


	<#if (column.attrType == "Reference")>

    /**
    * 设置：${column.comments}
    */
    public void set${column.attrName}(${column.reference} ${column.attrname}) {
    	this.${column.attrname} = ${column.attrname};
    }

	<#elseif (column.attrType == "Enum")>

    /**
    * 设置：${column.comments}
    */
    public void set${column.attrName}(${column.reference} ${column.attrname}) {
    	this.${column.attrname} = ${column.attrname};
    }

    public void set${column.attrName}(String ${column.attrname}) {
    	this.${column.attrname} = EnumUtil.valueOf(${column.reference}.class, ${column.attrname});
    }

	<#else>

    /**
    * 设置：${column.comments}
    */
    public void set${column.attrName}(${column.attrType} ${column.attrname}) {
	    this.${column.attrname} = ${column.attrname};
    }
	</#if>



	<#if (column.attrType== "Reference" || column.attrType== "Enum")>

    /**
    * 获取：${column.comments}
    */
    public ${column.reference} get${column.attrName}() {
    	return ${column.attrname};
    }

	<#else>

    /**
    * 获取：${column.comments}
    */
    public ${column.attrType} get${column.attrName}() {
    	return ${column.attrname};
    }
	</#if>

</#list>

	public Integer getModifiedCount() {
		return modifiedCount;
	}

	public void setModifiedCount(Integer modifiedCount) {
		this.modifiedCount = modifiedCount;
	}

	public EnumBaseStatus getStatus() {
		return status;
	}

	public void setStatus(EnumBaseStatus status) {
		this.status = status;
	}

	public void setStatus(String status) {
		this.status = EnumUtil.valueOf(EnumBaseStatus.class, status);
	}

	public Date getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}

	public Date getModifiedTime() {
		return modifiedTime;
	}

	public void setModifiedTime(Date modifiedTime) {
		this.modifiedTime = modifiedTime;
	}


}
