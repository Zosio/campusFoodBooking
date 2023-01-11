package com.booking.dao;

import com.booking.domain.User;

import java.sql.Connection;
import java.sql.SQLException;

public interface UserDao {
    //得到登录的用户
    public User getLoginUser(Connection connection,String userAccount) throws SQLException;

    //插入注册的用户
    public int setRegisterUser(Connection connection,String name,String account,String password) throws SQLException;
}
