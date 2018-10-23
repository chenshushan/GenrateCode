package com.chen.code.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class AdminIndexController  {
	@RequestMapping(value ={"/admin/", "/admin/index", "/","/index"})
	public String index(){
		
		return "admin/index";
	}
	
	@RequestMapping(value = {"/admin/welcome"})
	public String welcome(){

		return "admin/welcome";
	}
}
