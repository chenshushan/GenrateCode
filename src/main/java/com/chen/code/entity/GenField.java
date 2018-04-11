package com.chen.code.entity;


import com.chen.code.common.utils.EnumUtil;
import com.chen.code.entity.enumdo.EnumBaseStatus;
import com.chen.code.entity.enumdo.EnumJavaType;
import com.chen.code.entity.enumdo.EnumYesOrNo;
import org.hibernate.annotations.*;

import javax.persistence.*;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * 系统字段
 *
 */
@Entity
@Table(name = "gen_field")
public class GenField implements Serializable{

	// 具体的字段 根据类不同而不同
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "field_id", nullable = false)
	private Integer fieldId;
	/**
	 * 字段名称
	 */
	private String fieldName;
	/**
	 * 列名
	 */
	private String columnName;
	/**
	 * 显示名称
	 */
	private String description;

	/**
	 * 字段类型
	 */
	@Transient
	private String fieldType; 
	/**
	 * java字段类型
	 */
	@Type(type = "com.chen.code.common.IntegerValuedEnumType",
			parameters = {@org.hibernate.annotations.Parameter(name = "enum",value = "com.chen.code.entity.enumdo.EnumJavaType")})
	private EnumJavaType javaFieldType;
	/**
	 * 字段长度
	 */
	private String fieldLength; 
	/**
	 * 引用实体
	 */
	private String reference; 
	/**
	 * 关联类型
	 */
	@Transient
	private String referenceType; 
	/**
	 * 是否可搜索
	 */
	@Type(type = "com.chen.code.common.IntegerValuedEnumType",
			parameters = {@org.hibernate.annotations.Parameter(name = "enum",value = "com.chen.code.entity.enumdo.EnumYesOrNo")})
	private EnumYesOrNo ifSearch;

	/**
	 * 是否展示
	 */
	@Type(type = "com.chen.code.common.IntegerValuedEnumType",
			parameters = {@org.hibernate.annotations.Parameter(name = "enum",value = "com.chen.code.entity.enumdo.EnumYesOrNo")})
	private EnumYesOrNo ifShow;
	/**
	 * 是否为空
	 */
	@Type(type = "com.chen.code.common.IntegerValuedEnumType",
			parameters = {@org.hibernate.annotations.Parameter(name = "enum",value = "com.chen.code.entity.enumdo.EnumYesOrNo")})
	private EnumYesOrNo ifNull;


	/**
	 * 关联系统表
	 */
	@ManyToOne(targetEntity = GenEntity.class)
	@JoinColumn(name = "table_id")
	private GenEntity table;
	
	
	//其他辅助字段 包括 创建时间 修改时间 修改次数 状态  每个类都有

	private Date createdTime;

	private Date modifiedTime;

	private Integer modifiedCount;
	@Type(type = "com.chen.code.common.IntegerValuedEnumType",parameters = {@org.hibernate.annotations.Parameter(name = "enum",value = "com.chen.code.entity.enumdo.EnumBaseStatus")})
	private EnumBaseStatus status;


	public Integer getFieldId() {
		return fieldId;
	}

	public void setFieldId(Integer fieldId) {
		this.fieldId = fieldId;
	}

	public String getFieldName() {
		return fieldName;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}


	
	public String getFieldType() {
		return fieldType;
	}

	public void setFieldType(String fieldType) {

		this.fieldType = fieldType;
	}
	
	
	public String getFieldLength() {
		return fieldLength;
	}

	public void setFieldLength(String fieldLength) {
		this.fieldLength = fieldLength;
	}
	
	
	
	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}
	
	
	
	public String getReferenceType() {
		return referenceType;
	}

	public void setReferenceType(String referenceType) {
		this.referenceType = referenceType;
	}
	
	//get 和 set 方法 每个类都有
	
	public Date getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}

	public Integer getModifiedCount() {
		return modifiedCount;
	}

	public void setModifiedCount(Integer modifiedCount) {
		this.modifiedCount = modifiedCount;
	}

	public Date getModifiedTime() {
		return modifiedTime;
	}

	public void setModifiedTime(Date modifiedTime) {
		this.modifiedTime = modifiedTime;
	}

	public EnumBaseStatus getStatus() {
		return status;
	}

	public void setStatus(EnumBaseStatus status) {
		this.status = status;
	}
	public void setStatus(String status) {
		this.status = EnumUtil.valueOf(EnumBaseStatus.class,status);
	}

	public GenEntity getTable() {
		return table;
	}

	public void setTable(GenEntity table) {
		this.table = table;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public EnumYesOrNo getIfSearch() {
		return ifSearch;
	}

	public void setIfSearch(EnumYesOrNo ifSearch) {
		this.ifSearch = ifSearch;
	}
	public void setIfSearch(String ifSearch) {
		this.ifSearch = EnumUtil.valueOf(EnumYesOrNo.class,ifSearch);
	}

	public EnumYesOrNo getIfShow() {
		return ifShow;
	}

	public void setIfShow(EnumYesOrNo ifShow) {
		this.ifShow = ifShow;
	}
	public void setIfShow(String ifShow) {
		this.ifShow = EnumUtil.valueOf(EnumYesOrNo.class,ifShow);
	}

	public EnumYesOrNo getIfNull() {
		return ifNull;
	}

	public void setIfNull(EnumYesOrNo ifNull) {
		this.ifNull = ifNull;
	}
	public void setIfNull(String ifNull) {
		this.ifNull = EnumUtil.valueOf(EnumYesOrNo.class,ifNull);
	}

	public EnumJavaType getJavaFieldType() {
		return javaFieldType;
	}

	public void setJavaFieldType(EnumJavaType javaFieldType) {
		this.javaFieldType = javaFieldType;
	}
	public void setJavaFieldType(String javaFieldType) {
		this.javaFieldType = EnumUtil.valueOf(EnumJavaType.class,javaFieldType);
	}




	@Override
	public String toString() {
		return "GenField{" +
				"fieldId=" + fieldId +
				", fieldName='" + fieldName + '\'' +
				", description='" + description + '\'' +
				", fieldType='" + fieldType + '\'' +
				", javaFieldType=" + javaFieldType +
				", fieldLength='" + fieldLength + '\'' +
				", reference='" + reference + '\'' +
				", referenceType='" + referenceType + '\'' +
				", ifSearch=" + ifSearch +
				", ifShow=" + ifShow +
				", ifNull=" + ifNull +
				", table=" + table +
				", createdTime=" + createdTime +
				", modifiedTime=" + modifiedTime +
				", modifiedCount=" + modifiedCount +
				", status=" + status +
				'}';
	}
}
    

