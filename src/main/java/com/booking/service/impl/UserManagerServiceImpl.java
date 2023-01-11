package com.booking.service.impl;

import com.booking.dao.BaseDao;
import com.booking.dao.UserManagerDao;
import com.booking.dao.impl.UserManagerDaoImpl;
import com.booking.domain.User;
import com.booking.service.UserManagerService;
import org.junit.Test;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserManagerServiceImpl implements UserManagerService {

    private UserManagerDao userManagerDao;
    public UserManagerServiceImpl(){
        userManagerDao=new UserManagerDaoImpl();
    }

    @Override
    public User getUser() {
        Connection connection=null;
        User user=null;

        try {
            connection= BaseDao.getConnection();
            user=userManagerDao.getUserInfos(connection);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeResouce(connection,null,null);
        }
        return user;
    }

    @Override
    public int addUser(String name, String account, String pwd, String phone, int status, int role) {
        Connection connection=null;
        User user=null;
        int ur=0;

        try {
            connection=BaseDao.getConnection();
            ur=userManagerDao.addUser(connection,name,account,pwd,phone,status,role);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeResouce(connection,null,null);
        }
        return ur;
    }

    @Override
    public User getUserById(int id) {
        Connection connection=null;
        User user=null;

        try {
            connection=BaseDao.getConnection();
            user=userManagerDao.getUserById(connection,id);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeResouce(connection,null,null);
        }
        return user;
    }

    @Override
    public int modifyUser(int id ,String name, String account, String pwd, String phone, int role) {
        Connection connection=null;
        int ur=0;

        try {
            connection=BaseDao.getConnection();
            ur=userManagerDao.modifyUser(connection,id,name,account,pwd,phone,role);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeResouce(connection,null,null);
        }
        return ur;
    }

    @Override
    public ArrayList<User> queryUserList(String name, String account, String phone,int role, int status) {
        Connection connection=null;
        ArrayList<User> users=new ArrayList<User>();

        try {
            connection=BaseDao.getConnection();
            users=userManagerDao.queryUserList(connection,name,account,phone,role,status);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeResouce(connection,null,null);
        }
        return users;
    }

    @Override
    public boolean updata(User user) {
        Connection connection=null;
        boolean flag=false;

        try {
            connection=BaseDao.getConnection();
            flag=userManagerDao.updata(connection,user);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeResouce(connection,null,null);
        }
        return flag;
    }

    @Test
    public void test(){
        UserManagerServiceImpl userManagerService=new UserManagerServiceImpl();

//        int ur =userManagerService.addUser("zhongqing","zhongqing@163.com","zhongqing","11111111111",1,3);

//        System.out.println(ur);
//        User user=userManagerService.getUserById(1);
//        if(user.getUserStatus()==1){
//            user.setUserStatus(0);
//        }else {
//            user.setUserStatus(1);
//        }
//
//        boolean flag =userManagerService.updata(user);
//
//        System.out.println(flag);
        userManagerService.addUser("吴迪","wudi@163.com","wudi","18818881882",1,3);
    }
}
