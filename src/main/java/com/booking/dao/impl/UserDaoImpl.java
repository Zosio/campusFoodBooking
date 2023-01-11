package com.booking.dao.impl;

import com.booking.dao.BaseDao;
import com.booking.dao.UserDao;
import com.booking.domain.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDaoImpl implements UserDao {
    public User getLoginUser(Connection connection, String userAccount) throws SQLException {

        PreparedStatement pstm = null;
        ResultSet rs = null;
        User user = null;

        if (connection != null) {
            String sql = "select * from user where userAccount=?";
            Object[] params = {userAccount};

            rs = BaseDao.execute(connection, pstm, rs, sql, params);
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("userID"));
                user.setUserAccount(rs.getString("userAccount"));
                user.setUserName(rs.getString("userName"));
                user.setUserPhone(rs.getString("userPhone"));
                user.setUserPwd(rs.getString("userPwd"));
                user.setUserStatus(rs.getInt("userStatus"));
                user.setUserType(rs.getInt("userType"));
            } else {
                user = null;
                return user;
            }

            BaseDao.closeResouce(null, pstm, rs);

        }
        return user;
    }

    public int setRegisterUser(Connection connection, String name, String account, String password) throws SQLException {

        PreparedStatement pstm = null;
        ResultSet rs = null;
        User user = null;
        int i = 0;
        int ur=0;



        if(connection!=null){

            String sql0="select count(*) from user";
            pstm=connection.prepareStatement(sql0);
            rs= pstm.executeQuery();
            if(rs.next()){
                i=rs.getInt(1);
                i++;
            }

            String sql = "insert into user(userId, userName, userAccount, userPwd, userPhone, userType, userStatus) VALUES (" +i+",\""+name+"\",\""+account+"\",\""+password+"\",\""+"12345678901"+"\","+1+","+1+")";

            pstm=connection.prepareStatement(sql);
            ur=pstm.executeUpdate();

            BaseDao.closeResouce(null,pstm,rs);

        }
        return ur;

    }


}

