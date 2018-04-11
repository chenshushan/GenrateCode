package com.chen.code.entity;

import javax.persistence.*;

/**
 * Created by Administrator on 2017/11/23.
 */

@Entity
@Table(name = "tb_test")
@org.hibernate.annotations.Table(appliesTo = "tb_test",comment="表注释")
public class Test {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id")
	private int id;
	/**
	 * 实体类名
	 */
	@Column(name = "name", columnDefinition="varchar(255) COMMENT '实体类名'")
	private String name;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
