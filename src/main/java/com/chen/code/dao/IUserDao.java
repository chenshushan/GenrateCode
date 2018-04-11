package com.chen.code.dao;


import com.chen.code.dao.support.IBaseDao;
import com.chen.code.entity.User;
import org.springframework.stereotype.Repository;

@Repository
public interface IUserDao extends IBaseDao<User, Integer> {

	User findByUserName(String username);

}
