package com.booking.dao.impl;

import com.booking.dao.BaseDao;
import com.booking.domain.User;
import com.mysql.cj.util.StringUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserManagerDaoImpl implements com.booking.dao.UserManagerDao {

    @Override
    public User getUserInfos(Connection connection) throws SQLException {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        User user=null;

        if(connection!=null){
            String sql="select * from user";
            pstm=connection.prepareStatement(sql);
            rs=pstm.executeQuery();
            if(rs.next()){
                user=new User();
                user.setUserId(rs.getInt("userId"));
                user.setUserType(rs.getInt("userType"));
                user.setUserPwd(rs.getString("userPwd"));
                user.setUserStatus(rs.getInt("userStatus"));
                user.setUserPhone(rs.getString("userPhone"));
                user.setUserName(rs.getString("userName"));
                user.setUserAccount(rs.getString("userAccount"));
            }else {
                user=null;
                return user;
            }
        }
        return user;
    }

    @Override
    public int addUser(Connection connection, String name, String account, String pwd, String phone, int status,int role) throws SQLException {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        User user=null;
        int i =0;
        int ur=0;
        if(connection!=null){
            String sql0="select count(*) from user";
            pstm=connection.prepareStatement(sql0);
            rs= pstm.executeQuery();
            if(rs.next()){
                i=rs.getInt(1);
                i++;
            }
            String sql="insert into user(userId, userName, userAccount, userPwd, userPhone, userType, userStatus) VALUES ("+i+",\'"+name+"\',\'"+account+"\',\'"+pwd+"\',\'"+phone+"\',"+role+","+status+");";

            pstm=connection.prepareStatement(sql);
            ur=pstm.executeUpdate();

            BaseDao.closeResouce(null,pstm,rs);
        }
        return ur;
    }

    @Override
    public User getUserById(Connection connection, int id) throws SQLException {
        PreparedStatement pstm=null;
        ResultSet rs = null;
        User user=null;
        if(connection!=null){
            String sql="select * from user where userId="+id;

            System.out.println(sql);
            pstm=connection.prepareStatement(sql);
            rs=pstm.executeQuery();
            if(rs.next()){
                user=new User();
                user.setUserId(rs.getInt("userId"));
                user.setUserType(rs.getInt("userType"));
                user.setUserPwd(rs.getString("userPwd"));
                user.setUserStatus(rs.getInt("userStatus"));
                user.setUserPhone(rs.getString("userPhone"));
                user.setUserName(rs.getString("userName"));
                user.setUserAccount(rs.getString("userAccount"));
            }else {
                user=null;
                return user;
            }
        }
        return user;
    }

    @Override
    public int modifyUser(Connection connection,int id ,String name, String account, String pwd, String phone, int role) throws SQLException {
        PreparedStatement pstm=null;
        ResultSet rs=null;
        int ur=0;

        if(connection!=null){
            String sql="UPDATE user set userName='"+name+"',userAccount='"+account+"',userPwd='"+pwd+"',userPhone='"+phone+"',userType="+role+" where userId="+id;

            pstm=connection.prepareStatement(sql);
            ur=pstm.executeUpdate();
            BaseDao.closeResouce(null,pstm,rs);
        }
        return ur;
    }

    @Override
    public ArrayList<User> queryUserList(Connection connection, String name, String account, String phone, int role,int status) throws SQLException {
        PreparedStatement pstm=null;
        ResultSet rs=null;
        User user=null;
        ArrayList<User> users=new ArrayList<User>();

        if(connection!=null){
            StringBuffer sql=new StringBuffer();
            sql.append("select * from user");

            if(!StringUtils.isNullOrEmpty(name)){
                sql.append(" where userName like");
                sql.append(" '%"+name+"%'");
            }else sql.append(" where userId like '%%'");
            if(!StringUtils.isNullOrEmpty(account)){
                sql.append(" and userAccount=");
                sql.append(account);
            }
            if(!StringUtils.isNullOrEmpty(phone)){
                sql.append(" and userPhone=");
                sql.append(phone);
            }
            if(status==1){
                sql.append(" and userStatus=1");
            }else if (status==0){
                sql.append(" and userStatus=0");
            }
            if(role==1){
                sql.append(" and userType=1");
            }else if(role==2){
                sql.append(" and userType=2");
            }else if(role==3){
                sql.append(" and userType=3");
            }
            System.out.println(sql.toString());

            pstm=connection.prepareStatement(sql.toString());
            rs=pstm.executeQuery();
            while(rs.next()){
                user=new User();
                user.setUserId(rs.getInt("userId"));
                user.setUserType(rs.getInt("userType"));
                user.setUserPwd(rs.getString("userPwd"));
                user.setUserStatus(rs.getInt("userStatus"));
                user.setUserPhone(rs.getString("userPhone"));
                user.setUserName(rs.getString("userName"));
                user.setUserAccount(rs.getString("userAccount"));
                users.add(user);
            }
            BaseDao.closeResouce(null,pstm,rs);
        }
        return users;
    }

    @Override
    public boolean updata(Connection connection, User user) throws SQLException {
        PreparedStatement pstm=null;
        ResultSet rs=null;
        int ur=0;
        if(connection!=null){
            StringBuffer sql=new StringBuffer();
            if(user!=null){
            }else return false;
            sql.append("UPDATE user set userName=");
            sql.append("'"+user.getUserName()+"'"+" , userAccount=");
            sql.append("'"+user.getUserAccount()+"'"+" , userPwd=");
            sql.append("'"+user.getUserPwd()+"'"+" , userPhone=");
            sql.append("'"+user.getUserPhone()+"'"+" , userType=");
            sql.append(user.getUserType()+" , userStatus=");
            sql.append(user.getUserStatus()+" where userId=");
            sql.append(user.getUserId());
            System.out.println(sql);


            pstm=connection.prepareStatement(sql.toString());
            ur=pstm.executeUpdate();

            if(ur>0){
                return true;
            }else return false;
        }
        return false;
    }
}
