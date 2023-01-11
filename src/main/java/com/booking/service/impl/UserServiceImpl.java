package com.booking.service.impl;

import com.booking.dao.BaseDao;
import com.booking.dao.UserDao;
import com.booking.dao.impl.UserDaoImpl;
import com.booking.domain.User;
import com.booking.service.UserService;
import org.junit.Test;

import java.sql.Connection;
import java.sql.SQLException;

public class UserServiceImpl implements UserService {

    //业务层都会调用Dao层，所以我们要引入Dao层
    private UserDao userDao;
    public UserServiceImpl(){
        userDao=new UserDaoImpl();
    }

    public User login(String userAccount, String password) {
        Connection connection=null;
        User user= null;

        try {
            connection = BaseDao.getConnection();
            //通过业务层调用具体的数据库操作
            user=userDao.getLoginUser(connection,userAccount);
            if(user!=null){
                if(user.getUserPwd().equals(password)&&user.getUserStatus()==1);
                else return null;
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeResouce(connection,null,null);
        }
        return user;
    }

    public int register(String firstname, String lastname, String account, String password) {
        Connection connection=null;
        String name =firstname+lastname;
        User user=null;
        int rs=0;

        try {
            connection=BaseDao.getConnection();
            user=userDao.getLoginUser(connection,account);
            if(user!=null){
                return 0;
            }else {
                rs=userDao.setRegisterUser(connection,name,account,password);
            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeResouce(connection,null,null);
        }
        return rs;
    }

    @Test
    public void test(){
        UserServiceImpl userService=new UserServiceImpl();
//        User user=userService.login("asd@163.com","huang");
//        System.out.println(user);
//        System.out.println(user.getUserPwd());
        int rs =userService.register("xu","qi","xuqi@163.com","xuqi");
//        int rs1 =userService.register("zheng","yi","zhengyi@163.com","zhengyi");
//        int i =1;
//        String name ="xuqi";
//        String account="xuqi@163.com";
//        String password="xuqi";
//        String sql = "insert into user(userId, userName, userAccount, userPwd, userPhone, userType, userStatus) VALUES (" +i+",\""+name+"\",\""+account+"\",\""+password+"\",\""+"123456789012"+"\","+2+","+1+")";
//        System.out.println(sql);
        System.out.println(rs);
//        System.out.println(rs1);
    }

}
