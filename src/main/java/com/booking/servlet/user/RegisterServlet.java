package com.booking.servlet.user;

import com.booking.service.UserService;
import com.booking.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/register.do")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        resp.setContentType("text/html;charset=utf-8");
        System.out.println("RegisterServlet--start......");
        int rs=0;


        //获取注册信息
        String username1 =req.getParameter("firstname");
        String username2 =req.getParameter("lastname");
        String useracoount =req.getParameter("email");
        String password = req.getParameter("password1");
        String pwd =req.getParameter("password2");

        UserService userService =new UserServiceImpl();

        if(password.equals(pwd)){
            rs=userService.register(username1,username2,useracoount,password);
        }

        if(rs==0){
            //注册失败
            out.print("<script language='javascript'>alert('该用户名已存在或密码不一致');window.location.href='register.jsp';</script>");
        }else {
            //注册成功
            resp.sendRedirect("main-customer.jsp");
        }

    }
}
