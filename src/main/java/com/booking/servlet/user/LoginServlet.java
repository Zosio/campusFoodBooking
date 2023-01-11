package com.booking.servlet.user;

import com.booking.domain.User;
import com.booking.service.UserService;
import com.booking.service.impl.UserServiceImpl;
import com.booking.util.Constants;
import com.booking.util.ResponseResult;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {

    //servlet：控制层调用业务层代码


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        resp.setContentType("text/html;charset=utf-8");
        System.out.println("LoginServlet--start......");


        //获取用户名和密码
        String username=req.getParameter("name");
        String password=req.getParameter("pwd");

        //和数据库很难过的密码进行对比，调用业务层;
        UserService userService =new UserServiceImpl();
        User user=userService.login(username,password); //这里以及把登录的人给查出来了

        if(user!=null){
            //查有此人,将用户的信息放到session中，
            req.getSession().setAttribute(Constants.USER_SESSION,user);
            //跳转到内部主页
            if(user.getUserType()==1){
                resp.sendRedirect("main-customer.jsp");
            }else if (user.getUserType()==2){
                resp.sendRedirect("main-manager.jsp");
            }
        }else {
            //查无此人，转发回登录页面，随便提示用户名活着密码错误
            out.print("<script language='javascript'>alert('用户名或密码不存在');window.location.href='login.html';</script>");

        }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
