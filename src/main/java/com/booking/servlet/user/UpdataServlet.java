package com.booking.servlet.user;

import com.booking.domain.User;
import com.booking.service.UserManagerService;
import com.booking.service.impl.UserManagerServiceImpl;
import com.booking.util.Constants;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/user.do")
public class UpdataServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        resp.setContentType("text/html;charset=utf-8");
        UserManagerServiceImpl userManagerService=new UserManagerServiceImpl();
        String userId=req.getParameter("userId");
        int id=Integer.valueOf(userId);
        String name=req.getParameter("name");
        String account =req.getParameter("email");
        String pwd1=req.getParameter("pwd1");
        String pwd2=req.getParameter("pwd2");
        User user =null;
        boolean flag=false;

        if(pwd1.equals(pwd2)){
            user=userManagerService.getUserById(id);
            user.setUserName(name);
            user.setUserAccount(account);
            user.setUserPwd(pwd1);
            flag=userManagerService.updata(user);
            req.getSession().setAttribute(Constants.USER_SESSION,user);
        }else {
            out.print("<script language='javascript'>alert('两次输入的密码不一致');window.location.href='pCenter.jsp';</script>");
        }
        if(flag){
            out.print("<script language='javascript'>alert('更新成功');window.location.href='pCenter.jsp';</script>");
        }else out.print("<script language='javascript'>alert('更新失败');window.location.href='pCenter.jsp';</script>");
    }
}
