package com.chen.code.entity.enumdo;


import com.chen.code.common.IntegerValuedEnum;

/**
 * 基本枚举类型，表示信息的状态
 * @author Administrator
 *
 */
public enum EnumYesOrNo  implements IntegerValuedEnum {
	YES("是", 1, "表示是"),NO("否", 0, "表示不是");

	// 成员变量
	private String name;

	private int index;
	
	private String description;
	
	//构造方法
	private EnumYesOrNo(String name, int index, String description) {
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
    

