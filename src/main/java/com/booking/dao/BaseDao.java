package com.booking.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class BaseDao {

    private static String driver;
    private static String url;
    private static String username;
    private static String password;

    //静态代码块，类加载的时候就初始化
    static {
        Properties properties=new Properties();
        //通过类加载器读取资源
        InputStream is=BaseDao.class.getClassLoader().getResourceAsStream("db.properties");

        try {
            properties.load(is);
        } catch (IOException e) {
            e.printStackTrace();
        }

        driver =properties.getProperty("driver");
        url =properties.getProperty("url");
        username =properties.getProperty("username");
        password =properties.getProperty("password");

    }

    //获取数据库的链接
    public static Connection getConnection(){
        Connection connection=null;
        try {
            Class.forName(driver);
            connection=DriverManager.getConnection(url,username,password);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }

    //编写查询公共方法
    public static ResultSet execute(Connection connection,PreparedStatement preparedStatement,ResultSet resultSet,String sql,Object[] params) throws SQLException {
        //预编译的sql在后面直接执行就可以
        preparedStatement =connection.prepareStatement(sql);

        for (int i =0;i<params.length;i++){
            //Object占位符从1开始，但是数组从0开始
            preparedStatement.setObject(i+1,params[i]);
        }
        resultSet=preparedStatement.executeQuery();
        return  resultSet;
    }

    public static ResultSet execute(Connection connection,PreparedStatement preparedStatement,ResultSet resultSet,String sql) throws SQLException {
        //预编译的sql在后面直接执行就可以
        preparedStatement =connection.prepareStatement(sql);
        resultSet=preparedStatement.executeQuery();
        return  resultSet;
    }

    //编写增删改公共方法
    public static int execute(Connection connection,PreparedStatement preparedStatement,String sql,Object[] params) throws SQLException {
        preparedStatement =connection.prepareStatement(sql);

        for (int i =0;i<params.length;i++){
            //Object占位符从1开始，但是数组从0开始
            preparedStatement.setObject(i+1,params[i]);
        }
        int updateRows=preparedStatement.executeUpdate();
        return  updateRows;
    }

    //统计数据库


    //释放资源
    public static boolean closeResouce(Connection connection,PreparedStatement preparedStatement,ResultSet resultSet){

        boolean flag =true;
        if (resultSet!=null){
            try {
                resultSet.close();
                resultSet=null;
            } catch (SQLException throwables) {
                throwables.printStackTrace();
                flag =false;
            }
        }
        if (connection!=null){
            try {
                connection.close();
                connection=null;
            } catch (SQLException throwables) {
                throwables.printStackTrace();
                flag =false;
            }
        }
        if (preparedStatement!=null){
            try {
                preparedStatement.close();
                preparedStatement=null;
            } catch (SQLException throwables) {
                throwables.printStackTrace();
                flag =false;
            }
        }
        return flag;
    }

}
