package com.booking.dao;

import com.booking.domain.Food;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

public interface SysUserDao {
    public Food getFoodInfos(Connection connection) throws SQLException;

    public int addFood(Connection connection,String name,String image,double price) throws SQLException;

    public  Food getFoodById(Connection connection,int id) throws SQLException;

    public int modifyFood(Connection connection,String name,double price,int id) throws SQLException;

    public ArrayList<Food> queryFoodList(Connection connection, String name, String price, int status) throws SQLException;

    public boolean updata(Connection connection,Food food) throws SQLException;
}
