package com.chen.code.entity;

import com.chen.code.entity.enumdo.EnumBaseStatus;
import org.hibernate.annotations.Parameter;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Created by Administrator on 2017/11/25.
 */
@Entity
public class Template {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "templateId")
	private Integer templateId;

	private String templateName;

	private String templatePath;

	private User addUser;


	private LocalDate uploadTime;

	private LocalDateTime createdTime;

	private LocalDateTime modifiedTime;

	private Integer modifiedCount;
	@Type(type = "com.chen.code.common.IntegerValuedEnumType",parameters = {@Parameter(name = "enum",value = "com.chen.code.entity.enumdo.EnumBaseStatus")})
	private EnumBaseStatus status;


	public Integer getTemplateId() {
		return templateId;
	}

	public void setTemplateId(Integer templateId) {
		this.templateId = templateId;
	}

	public String getTemplateName() {
		return templateName;
	}

	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}

	public String getTemplatePath() {
		return templatePath;
	}

	public void setTemplatePath(String templatePath) {
		this.templatePath = templatePath;
	}

	public User getAddUser() {
		return addUser;
	}

	public void setAddUser(User addUser) {
		this.addUser = addUser;
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

	public LocalDate getUploadTime() {
		return uploadTime;
	}

	public void setUploadTime(LocalDate uploadTime) {
		this.uploadTime = uploadTime;
	}

	public LocalDateTime getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(LocalDateTime createdTime) {
		this.createdTime = createdTime;
	}

	public LocalDateTime getModifiedTime() {
		return modifiedTime;
	}

	public void setModifiedTime(LocalDateTime modifiedTime) {
		this.modifiedTime = modifiedTime;
	}

	@Override
	public String toString() {
		return "Template{" +
				"templateId=" + templateId +
				", templateName='" + templateName + '\'' +
				", templatePath='" + templatePath + '\'' +
				", addUser=" + addUser +
				", uploadTime=" + uploadTime +
				", createdTime=" + createdTime +
				", modifiedTime=" + modifiedTime +
				", modifiedCount=" + modifiedCount +
				", status=" + status +
				'}';
	}
}
