package com.booking.service.impl;

import com.booking.dao.BaseDao;
import com.booking.dao.SysOrderDao;
import com.booking.dao.impl.SysOrderDaoImpl;
import com.booking.domain.Ordering;
import com.booking.service.SysOrderService;
import org.junit.Test;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

public class SysOrderServiceImpl implements SysOrderService {
    private SysOrderDao sysOrderDao;
    public SysOrderServiceImpl(){
        sysOrderDao=new SysOrderDaoImpl();
    }


    @Override
    public ArrayList<Ordering> getOrderList(int id, String number, String account, String phone, int status) {
        Connection connection=null;
        ArrayList<Ordering> orderings=null;

        try {
            connection= BaseDao.getConnection();
            orderings=sysOrderDao.getOrderList(connection,id,number,account,phone,status);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeResouce(connection,null,null);
        }
        return orderings;
    }

    @Override
    public Ordering getOrderById(int id) {
        Connection connection=null;
        Ordering ordering=null;

        try {
            connection=BaseDao.getConnection();
            ordering=sysOrderDao.getOrderById(connection,id);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeResouce(connection,null,null);
        }
        return ordering;
    }

    @Override
    public boolean updata(Ordering ordering) {
        Connection connection=null;
        boolean flag =false;

        try {
            connection=BaseDao.getConnection();
            flag=sysOrderDao.updata(connection,ordering);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeResouce(connection,null,null);
        }
        return flag;
    }

    @Override
    public boolean addOrder(String number, int UserId, double price, String detail) {
        Connection connection=null;
        boolean flag=false;

        try {
            connection=BaseDao.getConnection();
            flag=sysOrderDao.addOrder(connection,number,UserId,price,detail);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeResouce(connection,null,null);
        }
        return flag;
    }


    @Test
    public void test(){
        SysOrderService sysOrderService=new SysOrderServiceImpl();

        ArrayList<Ordering> orderings=new ArrayList<Ordering>();

//        orderings=sysOrderService.getOrderList(0,null,null,null,-1);
//        System.out.println(orderings.get(0).getOrderBelongUser());
//        System.out.println(orderings.get(0).getOrderId());
//        System.out.println(orderings.get(1).getOrderBelongUser());
//        System.out.println(orderings.get(1).getOrderId());
        sysOrderService.addOrder("1231231231",6,10.0,"鸡腿*10");


    }
}
