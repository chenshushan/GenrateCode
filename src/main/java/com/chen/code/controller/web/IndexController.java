package com.chen.code.controller.web;

import java.util.List;


import com.chen.code.entity.User;
import com.chen.code.service.IUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController   {
	
	@Autowired
	private IUserService userService;
	
	private Logger logger = LoggerFactory.getLogger(getClass());

	public String index(){
		List<User> users = userService.findAll();
		logger.debug(users.toString());
		return "index";
	}
}
