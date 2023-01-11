package com.booking.service.impl;

import com.booking.dao.BaseDao;
import com.booking.dao.SysUserDao;
import com.booking.dao.impl.SysUserDaoImpl;
import com.booking.domain.Food;
import com.booking.service.SysUserService;
import org.junit.Test;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

public class SysUserServiceImpl implements SysUserService {
    private SysUserDao sysUserDao;
    public SysUserServiceImpl(){
        sysUserDao=new SysUserDaoImpl();
    }
    public Food getFood() {
        Connection connection=null;
        Food food=null;


        try {
            connection = BaseDao.getConnection();
            food= sysUserDao.getFoodInfos(connection);


        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeResouce(connection,null,null);
        }
        return food;
    }

    public int addFood(String name, String image, double price) {
        Connection connection=null;
        Food food=null;
        int ur=0;

        try {

            connection=BaseDao.getConnection();

            ur=sysUserDao.addFood(connection,name,image,price);

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeResouce(connection,null,null);
        }
        return ur;
    }

    @Override
    public Food getFoodById(int id) {
        Connection connection=null;
        Food food=null;

        try {
            connection=BaseDao.getConnection();
            food= sysUserDao.getFoodById(connection,id);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeResouce(connection,null,null);
        }
        return food;
    }

    @Override
    public int modifyFood(String name, double price, int id) {
        Connection connection=null;
        int ur=0;

        try {
            connection=BaseDao.getConnection();
            ur=sysUserDao.modifyFood(connection,name,price,id);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeResouce(connection,null,null);
        }
        return ur;
    }

    @Override
    public ArrayList<Food> queryFoodList(String name, String price, int status) {
        Connection connection=null;
        ArrayList<Food> foodlist=null;

        try {
            connection=BaseDao.getConnection();
            foodlist=sysUserDao.queryFoodList(connection,name,price,status);

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeResouce(connection,null,null);
        }
        return foodlist;
    }

    @Override
    public boolean updata(Food food) {
        Connection connection=null;
        boolean flag =false;
        try {
            connection=BaseDao.getConnection();
            flag=sysUserDao.updata(connection,food);

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeResouce(connection,null,null);
        }
        return flag;
    }

    @Test
    public void test(){
        SysUserServiceImpl sysUserService=new SysUserServiceImpl();
//        ArrayList<Food> foodlist=sysUserService.queryFoodList("鸡","",1);
//        int ur=sysUserService.addFood("123","123",123);

//        System.out.println(ur);
//        System.out.println(foodlist.get(0).getFoodName());
//        System.out.println(foodlist.get(1).getFoodName());
        int ur = sysUserService.modifyFood("鸡蛋",1.0,1);
        System.out.println(ur);
//        Food food =null;
//        food =sysUserService.getFoodById(1);
//        food.setFoodStatus(1);
//        sysUserService.updata(food);
    }
}
