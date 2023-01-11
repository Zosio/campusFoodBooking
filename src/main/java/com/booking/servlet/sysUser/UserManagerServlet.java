package com.booking.servlet.sysUser;

import com.booking.domain.User;
import com.booking.service.UserManagerService;
import com.booking.service.impl.UserManagerServiceImpl;
import com.booking.util.ResponseResult;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/userManager.do")
public class UserManagerServlet extends HttpServlet {

    UserManagerService userManagerService =new UserManagerServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        resp.setContentType("text/html;charset=utf-8");

        String method=req.getParameter("type");

        if(method.compareTo("query")==0){
            String r=req.getParameter("role");
            int role =Integer.valueOf(r);
            String name=req.getParameter("name");
            String account=req.getParameter("account");
            String phone =req.getParameter("phone");
            String status=req.getParameter("isValid");
            int i=Integer.valueOf(status);

            ArrayList<User> users=userManagerService.queryUserList(name,account,phone,role,i);
            HttpSession session=req.getSession();
            session.setAttribute("users",users);
            resp.sendRedirect("user-set.jsp");
        }
        if(method.compareTo("addManagerUser")==0){
            String name=req.getParameter("name");
            String account =req.getParameter("account");
            String pwd=req.getParameter("password");
            String phone =req.getParameter("phone");
            String email=req.getParameter("email");
            int role =Integer.valueOf(email);

            int ur =userManagerService.addUser(name,account,pwd,phone,1,role);

            if(ur!=0){
                out.print("<script language='javascript'>alert('添加成功');window.location.href='user-set.jsp';</script>");
            }else out.print("<script language='javascript'>alert('添加失败');window.location.href='user-set.jsp';</script>");
        }
        if(method.compareTo("getUserById")==0){
            String id=req.getParameter("id");
            int i=Integer.valueOf(id);
            User user= userManagerService.getUserById(i);

            ObjectMapper objectMapper=new ObjectMapper();
            resp.setCharacterEncoding("utf-8");
            resp.setContentType("text/json");
            String json=objectMapper.writeValueAsString(ResponseResult.success(user));
            resp.getWriter().println(json);
        }
        if(method.compareTo("modify")==0){
            String id=req.getParameter("" +
                    "");
            int id1=Integer.valueOf(id);
            String name=req.getParameter("name");
            String email=req.getParameter("email");
            String pwd=req.getParameter("password");
            String role=req.getParameter("role");
            int i=Integer.valueOf(role);
            String phone =req.getParameter("phone");

            int ur=userManagerService.modifyUser(id1,name,email,pwd,phone,i);
            if(ur!=0){
                out.print("<script language='javascript'>alert('修改成功');window.location.href='user-set.jsp';</script>");
            }else out.print("<script language='javascript'>alert('修改失败');window.location.href='user-set.jsp';</script>");
        }
        if(method.compareTo("modifyStatus")==0){
            String id=req.getParameter("id");
            int i=Integer.valueOf(id);
            User user= userManagerService.getUserById(i);

            if(user.getUserStatus()==1){
                user.setUserStatus(0);
            }else {
                user.setUserStatus(1);
            }

            boolean flag=userManagerService.updata(user);
            ObjectMapper objectMapper = new ObjectMapper();
            resp.setContentType("text/json");
            resp.setCharacterEncoding("utf-8");
            if(flag){
                String json=objectMapper.writeValueAsString(ResponseResult.success(user));
                resp.getWriter().println(json);
            }
        }

    }
}
