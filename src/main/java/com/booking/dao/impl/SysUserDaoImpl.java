package com.booking.dao.impl;

import com.booking.dao.BaseDao;
import com.booking.dao.SysUserDao;
import com.booking.domain.Food;
import com.mysql.cj.util.StringUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class SysUserDaoImpl implements SysUserDao {
    public Food getFoodInfos(Connection connection) throws SQLException {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        Food food = null;

        if(connection!=null){
            String sql ="select * from food";
            pstm=connection.prepareStatement(sql);
            rs=pstm.executeQuery();
            if(rs.next()){
                food=new Food();
                food.setFoodId(rs.getInt("foodId"));
                food.setFoodBelong(rs.getInt("foodBelong"));
                food.setFoodDetail(rs.getString("foodDetail"));
                food.setFoodImage(rs.getString("foodImage"));
                food.setFoodName(rs.getString("foodName"));
                food.setFoodPrice(rs.getDouble("foodPrice"));
                food.setFoodType(rs.getString("foodType"));
            }else{
                food=null;
                return food;
            }
        }
        return food;
    }

    public int addFood(Connection connection, String name, String image, double price) throws SQLException {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        Food food = null;
        int i =0;
        int ur=0;

        if(connection!=null){
            String sql0="select count(*) from food";
            pstm=connection.prepareStatement(sql0);
            rs= pstm.executeQuery();
            if(rs.next()){
                i=rs.getInt(1);
                i++;
            }

//            String sql="insert into food(foodId, foodName, foodPrice, foodImage) VALUES ("+i+",\""+name+"\","+price+",\""+image+"\")";
//            String sql="insert into food(foodId, foodName, foodPrice, foodImage) VALUES (?,\"?\",?,\"?\")";
            String sql="insert into food(foodId, foodName, foodDetail, foodType, foodPrice, foodBelong, foodImage) VALUES ("+i+",\""+name+"\",\"detail\",\"type\","+price+","+1+",\""+image+"\")";
//            String sql1="insert into food(foodId, foodName, foodDetail, foodType, foodPrice, foodBelong, foodImage) VALUES (i,"name","detail","type",1,1,"image")";
//            String sql="insert into food(foodId, foodName, foodPrice, foodImage) VALUES (?,"?",?,"?")";
//            Object[] params={i,name,price,image};
            pstm=connection.prepareStatement(sql);
            ur=pstm.executeUpdate();

//            ur=BaseDao.execute(connection,pstm,sql,params);

            BaseDao.closeResouce(null,pstm,rs);
        }
        return ur;
    }

    @Override
    public Food getFoodById(Connection connection, int id) throws SQLException {
        PreparedStatement pstm=null;
        ResultSet rs = null;
        Food food = null;

        if(connection!=null){
            String sql="select * from food where foodId="+id;
//            Object[] params = {id};
//            rs=BaseDao.execute(connection,pstm,rs,sql,params);
            System.out.println(sql);
            pstm=connection.prepareStatement(sql);
            rs=pstm.executeQuery();
            if(rs.next()){
                food=new Food();
                food.setFoodId(rs.getInt("foodId"));
                food.setFoodStatus(rs.getInt("foodStatus"));
                food.setFoodType(rs.getString("foodType"));
                food.setFoodPrice(rs.getDouble("foodPrice"));
                food.setFoodName(rs.getString("foodName"));
                food.setFoodImage(rs.getString("foodImage"));
                food.setFoodDetail(rs.getString("foodDetail"));
                food.setFoodBelong(rs.getInt("foodBelong"));
            }else{
                food=null;
                return food;
            }
            BaseDao.closeResouce(null, pstm, rs);
        }
        return food;
    }

    @Override
    public int modifyFood(Connection connection, String name, double price,int id) throws SQLException {
        PreparedStatement pstm=null;
        ResultSet rs=null;
        int ur=0;

        if(connection!=null){
//            String sql="UPDATE food set foodName='?' , foodPrice=? where foodId=?;";
            String sql="UPDATE food set foodName='"+name+"' , foodPrice="+price+" where foodId="+id+";";
//            Object params[] ={name,price,id};
            System.out.println("Dao"+sql);
//            ur=BaseDao.execute(connection,pstm,sql,params);
            pstm=connection.prepareStatement(sql);
            ur=pstm.executeUpdate();
            BaseDao.closeResouce(null,pstm,rs);

        }
        return ur;
    }

    @Override
    public ArrayList<Food> queryFoodList(Connection connection, String name, String price, int status) throws SQLException {
        PreparedStatement pstm=null;
        ResultSet rs=null;
        Food food=null;
        ArrayList<Food> foodlist = new ArrayList<Food>();


        if(connection!=null){
            StringBuffer sql=new StringBuffer();
            sql.append("select * from food");
            ArrayList<Object> list =new ArrayList<Object>();

            if(!StringUtils.isNullOrEmpty(name)){
                sql.append(" where foodName like");
                sql.append(" '%"+name+"%'");//index0
            }else sql.append(" where foodId like '%%'");
            if(!StringUtils.isNullOrEmpty(price)){
                sql.append(" and foodPrice=");
                sql.append(price);// index1
            }
            if(status==1){
                sql.append(" and foodStatus=1");
            }else if ((status==0)){
                sql.append(" and foodStatus=0");
            }
            System.out.println(sql.toString());
//            Object[] params =list.toArray();

//            rs=BaseDao.execute(connection,pstm,rs,sql.toString(),params);
            pstm=connection.prepareStatement(sql.toString());
            rs=pstm.executeQuery();
            while (rs.next()){
                food=new Food();
                food.setFoodId(rs.getInt("foodId"));
                food.setFoodStatus(rs.getInt("foodStatus"));
                food.setFoodType(rs.getString("foodType"));
                food.setFoodPrice(rs.getDouble("foodPrice"));
                food.setFoodName(rs.getString("foodName"));
                food.setFoodImage(rs.getString("foodImage"));
                food.setFoodDetail(rs.getString("foodDetail"));
                food.setFoodBelong(rs.getInt("foodBelong"));
                foodlist.add(food);
            }
            BaseDao.closeResouce(null,pstm,rs);
        }
        return foodlist;
    }

    @Override
    public boolean updata(Connection connection, Food food) throws SQLException {
        PreparedStatement pstm=null;
        ResultSet rs=null;
//        Food food=null;
        int ur=0;

        if(connection!=null){
            StringBuffer sql=new StringBuffer();
            if(food!=null){

            }else return false;
//            sql.append("insert into food (foodId, foodName, foodDetail, foodType, foodPrice, foodBelong, foodImage) VALUES (");
            //(int,String,String,String,double,int,String)
            sql.append("UPDATE food set foodName=");
//            sql.append(food.getFoodId()+" and foodName=");
            sql.append("'"+food.getFoodName()+"'"+" , foodDetail=");
            sql.append("'"+food.getFoodDetail()+"'"+" , foodType=");
            sql.append("'"+food.getFoodType()+"'"+" , foodPrice=");
            sql.append(food.getFoodPrice()+" , foodBelong=");
            sql.append(food.getFoodBelong()+" , foodImage=");
            sql.append("'"+food.getFoodImage()+"'"+" , foodStatus=");
            sql.append(food.getFoodStatus()+" where foodId=");
            sql.append(food.getFoodId());
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
