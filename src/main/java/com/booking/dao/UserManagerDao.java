package com.booking.dao;

import com.booking.domain.User;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

public interface UserManagerDao {
    public User getUserInfos(Connection connection) throws SQLException;

    public int addUser(Connection connection,String name,String account,String pwd,String phone,int status,int role) throws SQLException;

    public  User getUserById(Connection connection,int id) throws SQLException;

    public int modifyUser(Connection connection,int id,String name,String account,String pwd,String phone,int role) throws SQLException;

    public ArrayList<User> queryUserList(Connection connection,String name,String account,String phone,int role,int status) throws SQLException;

    public boolean updata(Connection connection,User user) throws SQLException;

}
