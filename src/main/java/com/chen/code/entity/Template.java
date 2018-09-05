package com.chen.code.entity;

import com.chen.code.common.utils.EnumUtil;
import com.chen.code.entity.enumdo.EnumBaseStatus;
import org.hibernate.annotations.Parameter;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Date;



/**
* 模板
*/
@Entity
public class Template {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "templateId")
	private Integer templateId;


	// 模板路径

	private String templatePath;

	// 上传人

	@ManyToOne(targetEntity = User.class)
	private User addUser;

	// 模板名称

	private String templateName;


	private Date createdTime;

	private Date modifiedTime;

	private Integer modifiedCount;

	@Type(type = "com.chen.code.common.IntegerValuedEnumType",parameters = {@Parameter(name = "enum",value = "com.chen.code.entity.enumdo.EnumBaseStatus")})
	private EnumBaseStatus status;



	public Integer getTemplateId() {
		return templateId;
	}

	public void setTemplateId(Integer templateId) {
		this.templateId = templateId;
	}




    /**
    * 设置：模板路径
    */
    public void setTemplatePath(String templatePath) {
	    this.templatePath = templatePath;
    }




    /**
    * 获取：模板路径
    */
    public String getTemplatePath() {
    	return templatePath;
    }




    /**
    * 设置：上传人
    */
    public void setAddUser(User addUser) {
    	this.addUser = addUser;
    }





    /**
    * 获取：上传人
    */
    public User getAddUser() {
    	return addUser;
    }





    /**
    * 设置：模板名称
    */
    public void setTemplateName(String templateName) {
	    this.templateName = templateName;
    }




    /**
    * 获取：模板名称
    */
    public String getTemplateName() {
    	return templateName;
    }


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
