package com.booking.dao;

import com.booking.domain.Ordering;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

public interface SysOrderDao {
    public ArrayList<Ordering> getOrderList(Connection connection, int id, String number, String account, String phone, int status) throws SQLException;

    public Ordering getOrderById(Connection connection,int id) throws SQLException;

    public boolean updata(Connection connection,Ordering ordering) throws SQLException;

    public boolean addOrder(Connection connection,String number,int UserId,double price,String detail) throws SQLException;


}
