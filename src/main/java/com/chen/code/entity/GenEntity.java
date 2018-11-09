package com.chen.code.entity;



import com.alibaba.fastjson.annotation.JSONField;
import com.chen.code.common.utils.EnumUtil;
import com.chen.code.entity.enumdo.EnumBaseStatus;
import com.chen.code.entity.enumdo.EnumYesOrNo;
import org.hibernate.annotations.Parameter;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Set;


/**
 * 系统表
 * @author MDA
 *
 */

@Entity
@Table(name = "gen_table")
public class GenEntity implements Serializable {


	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "table_id")
	private int tableId;
	/**
	 * 实体类名
	 */
	@Column(name = "className")
	private String className;


	/**
	 * 模块名
	 */
	@Column(name = "modelName")
	private String modelName;




	/**
	 * 表名
	 */
	private String tableName;
	/**
	 * 数据库名
	 */
	@Transient
	private String dbName;

	@Transient
	private GenField key;

	@ManyToOne(targetEntity = Template.class)
	@JoinColumn(name = "template_id")
	private Template template;

	public String getModelName() {
		return modelName;
	}

	public void setModelName(String modelName) {
		this.modelName = modelName;
	}

	/**
	 * 显示名称
	 */
	private String remark;

	/**
	 * 是否有缓存
	 */
	@Type(type = "com.chen.code.common.IntegerValuedEnumType",parameters = {@Parameter(name = "enum",value = "com.chen.code.entity.enumdo.EnumYesOrNo")})
	private EnumYesOrNo useCache;

	
	//其他辅助字段 包括 创建时间 修改时间 修改次数 状态  每个类都有

	private Date createdTime;

	private Date modifiedTime;

	private Integer modifiedCount;
	@Type(type = "com.chen.code.common.IntegerValuedEnumType",parameters = {@Parameter(name = "enum",value = "com.chen.code.entity.enumdo.EnumBaseStatus")})
	private EnumBaseStatus status;
	@OneToMany(targetEntity = GenField.class)
	@JoinColumn(name = "table_id")
	@JSONField(serialize=false)
	private List<GenField> fields;

	// 初始化状态集合 每个类都有
	public EnumBaseStatus getStatus() {
		return status;
	}


	public void setStatus(EnumBaseStatus status) {
		this.status = status;
	}
	
	public void setStatus(String status) {
		this.status =  EnumUtil.valueOf(EnumBaseStatus.class, status);
	}


	public GenEntity() {
		// 初始状态为正常 
	}


	public int getTableId() {
		return tableId;
	}

	public void setTableId(int tableId) {
		this.tableId = tableId;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public GenField getKey() {
		return key;
	}

	public void setKey(GenField key) {
		this.key = key;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public EnumYesOrNo getUseCache() {
		return useCache;
	}

	public void setUseCache(EnumYesOrNo useCache) {
		this.useCache = useCache;
	}
	public void setUseCache(String useCache) {
		this.useCache = EnumUtil.valueOf(EnumYesOrNo.class,useCache);
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

	public List<GenField> getFields() {
		return fields;
	}

	public void setFields(List<GenField> fields) {
		this.fields = fields;
	}

	public Integer getModifiedCount() {
		return modifiedCount;
	}

	public void setModifiedCount(Integer modifiedCount) {
		this.modifiedCount = modifiedCount;
	}

	public String getDbName() {
		return dbName;
	}

	public void setDbName(String dbName) {
		this.dbName = dbName;
	}



	public Template getTemplate() {
		return template;
	}

	public void setTemplate(Template template) {
		this.template = template;
	}
}
    

