package com.chen.code.entity.enumdo;

import com.chen.code.common.IntegerValuedEnum;

/**
 * Created by Administrator on 2017/11/18.
 */
public enum EnumJavaType implements IntegerValuedEnum{
	String("String",4,"varchar"),
	Intger("Integer",0,"int"),
	Long("Long",1,"bigint"),
	Float("Float",2,"float"),
	BigDecimal("BigDecimal",3,"decimal"),
	Date("Date",5,"datetime"),
	Double("Double",6,"double"),
	Boolean("Boolean",7,"char"),
	Reference("Reference",8,"int"),
	Enum("Enum",9,"bigint")
	;

	// 成员变量
	private String name;

	private int index;

	private String description;

	//构造方法
	private EnumJavaType(String name, int index, String description) {
		this.name = name;
		this.index = index;
		this.description = description;
	}

	// get set 方法
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
