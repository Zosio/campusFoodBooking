package com.booking.listener;

import com.booking.dao.BaseDao;
import com.booking.domain.Food;
import com.booking.domain.Ordering;
import com.booking.domain.User;
import com.booking.util.Constants;
import com.booking.service.SysOrderService;
import com.booking.service.UserManagerService;
import com.booking.service.impl.SysOrderServiceImpl;
import com.booking.service.impl.UserManagerServiceImpl;
import org.junit.Test;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

@WebListener
public class SysUserContextListerner implements ServletContextListener {

    public void contextInitialized(ServletContextEvent sce) {
        PreparedStatement pstm = null;
        Connection connection = BaseDao.getConnection();
        ResultSet rs = null;
        Food food = null;
        ArrayList<Food> foodlist = new ArrayList<Food>();

        if(connection!=null){
            String sql ="select * from food";
            try {
                pstm=connection.prepareStatement(sql);
                rs=pstm.executeQuery();
                while (rs.next()){
                    food=new Food();
                    food.setFoodId(rs.getInt("foodId"));
                    food.setFoodBelong(rs.getInt("foodBelong"));
                    food.setFoodDetail(rs.getString("foodDetail"));
                    food.setFoodImage(rs.getString("foodImage"));
                    food.setFoodName(rs.getString("foodName"));
                    food.setFoodPrice(rs.getDouble("foodPrice"));
                    food.setFoodType(rs.getString("foodType"));
                    foodlist.add(food);
                }
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
        ServletContext application = sce.getServletContext();
        application.setAttribute("foodlist",foodlist);
//        foodlist.get(1).getFoodStatus()

        SysOrderService sysOrderService=new SysOrderServiceImpl();
        ArrayList<Ordering> orderings=new ArrayList<Ordering>();
        orderings=sysOrderService.getOrderList(0,null,null,null,-1);
        application.setAttribute("order",orderings);

        UserManagerService userManagerService=new UserManagerServiceImpl();
        ArrayList<User> users=new ArrayList<User>();
        users=userManagerService.queryUserList(null,null,null,-1,-1);
        application.setAttribute("users",users);

        application.setAttribute("user",Constants.USER_SESSION);

    }

    public void contextDestroyed(ServletContextEvent sce) {

    }

    @Test
    public void test() {
        SysOrderService sysOrderService = new SysOrderServiceImpl();
        ArrayList<Ordering> orderings = new ArrayList<Ordering>();
        orderings = sysOrderService.getOrderList(0, null, null, null, -1);
        System.out.println(orderings.get(0).getOrderId());
        System.out.println(orderings.get(1).getOrderId());
    }
}
