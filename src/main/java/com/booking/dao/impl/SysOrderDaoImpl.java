package com.booking.dao.impl;

import com.booking.dao.BaseDao;
import com.booking.dao.SysOrderDao;
import com.booking.domain.Ordering;
import com.mysql.cj.util.StringUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class SysOrderDaoImpl implements SysOrderDao {
    @Override
    public ArrayList<Ordering> getOrderList(Connection connection, int id, String number, String account, String phone, int status) throws SQLException {
        PreparedStatement pstm=null;
        ResultSet rs=null;
        Ordering ordering=null;
        ArrayList<Ordering> orderings= new ArrayList<Ordering>();

        if(connection!=null){
            StringBuffer sql=new StringBuffer();
            sql.append("select orderId,orderNumber,orderDetail,userPhone,userAccount,orderStatus,orderBelongUser,orderPrice from ordering inner join user on ordering.orderBelongUser = user.userId");
            if(id==0){
                sql.append(" where orderId like '%%'");
            }else sql.append(" where orderId="+id);
            if(!StringUtils.isNullOrEmpty(number)){
                sql.append(" and orderNumber="+"'"+number+"'");
            }
            if(!StringUtils.isNullOrEmpty(account)){
                sql.append(" and userAccount="+"'"+account+"'");
            }
            if(!StringUtils.isNullOrEmpty(phone)){
                sql.append(" and userPhone="+"'"+phone+"'");
            }
            if(status==1){
                sql.append(" and orderStatus=1");
            }else if ((status==0)){
                sql.append(" and orderStatus=0");
            }
            System.out.println(sql.toString());

            pstm=connection.prepareStatement(sql.toString());
            rs=pstm.executeQuery();
            while(rs.next()){
                ordering=new Ordering();
                ordering.setOrderBelongUser(rs.getInt("orderBelongUser"));
                ordering.setOrderId(rs.getInt("orderId"));
                ordering.setOrderNumber(rs.getString("orderNumber"));
                ordering.setOrderDetail(rs.getString("orderDetail"));
                ordering.setOrderStatus(rs.getInt("orderStatus"));
                ordering.setUserAccount(rs.getString("userAccount"));
                ordering.setUserPhone(rs.getString("userPhone"));
                ordering.setOrderPrice((rs.getInt("orderPrice")));
                orderings.add(ordering);
            }
            BaseDao.closeResouce(null,pstm,rs);
        }
        return orderings;
    }

    @Override
    public Ordering getOrderById(Connection connection, int id) throws SQLException {
        PreparedStatement pstm=null;
        ResultSet rs=null;
        Ordering ordering=null;

        if(connection!=null){
            String sql="select orderId,orderNumber,orderDetail,userPhone,userAccount,orderStatus,orderPrice from ordering inner join user on ordering.orderBelongUser = user.userId where orderId="+id;
            System.out.println(sql);
            pstm=connection.prepareStatement(sql);
            rs=pstm.executeQuery();
            if(rs.next()){
                ordering=new Ordering();
                ordering.setOrderId(rs.getInt("OrderId"));
                ordering.setOrderNumber(rs.getString("orderNumber"));
                ordering.setOrderDetail(rs.getString("orderDetail"));
                ordering.setOrderStatus(rs.getInt("orderStatus"));
                ordering.setUserAccount(rs.getString("userAccount"));
                ordering.setUserPhone(rs.getString("userPhone"));
                ordering.setOrderPrice(rs.getInt("orderPrice"));
            }else {
                ordering = null;
                return ordering;
            }
            BaseDao.closeResouce(null,pstm,rs);
        }
        return ordering;
    }

    @Override
    public boolean updata(Connection connection, Ordering ordering) throws SQLException {
        PreparedStatement pstm=null;
        ResultSet rs=null;
        int ur=0;

        if(connection!=null){
            StringBuffer sql=new StringBuffer();
            if(ordering!=null){

            }else return false;

            sql.append("UPDATE ordering set orderStatus="+ordering.getOrderStatus()+" where orderId="+ordering.getOrderId());
            System.out.println(sql);

            pstm=connection.prepareStatement(sql.toString());
            ur=pstm.executeUpdate();

            BaseDao.closeResouce(null,pstm,rs);

            if(ur>0){
                return true;
            }else return false;
        }
        return false;
    }

    @Override
    public boolean addOrder(Connection connection, String number, int UserId, double price, String detail) throws SQLException {
        PreparedStatement pstm=null;
        ResultSet rs=null;
        int ur=0;
        int i =0;

        if(connection!=null){
            String sql0="select count(*) from ordering";
            pstm=connection.prepareStatement(sql0);
            rs=pstm.executeQuery();
            if(rs.next()){
                i=rs.getInt(1);
                i++;
            }
            StringBuffer sql=new StringBuffer();
            sql.append("insert into ordering (orderId, orderDetail, orderPrice, orderBelongUser, orderBelongCt, orderNumber, orderStatus) VALUES");
            sql.append("("+i+", '"+detail+"',"+price+","+UserId+", "+1+", '"+number+"', "+1+")");

            System.out.println(sql);

            pstm=connection.prepareStatement(sql.toString());
            ur=pstm.executeUpdate();

            BaseDao.closeResouce(null,pstm,rs);

            if(ur>0){
                return true;
            }else return false;

        }
        return false;
    }
}
