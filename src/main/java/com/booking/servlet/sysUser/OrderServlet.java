package com.booking.servlet.sysUser;



import com.booking.domain.Ordering;
import com.booking.service.SysOrderService;
import com.booking.service.impl.SysOrderServiceImpl;
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

@WebServlet("/order.do")
public class OrderServlet extends HttpServlet {
    SysOrderService sysOrderService=new SysOrderServiceImpl();

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
            String number=req.getParameter("number");
            String account=req.getParameter("account");
            String phone = req.getParameter("phone");
            String status =req.getParameter("isValid");
            int i =Integer.valueOf(status);

            ArrayList<Ordering> orderings = sysOrderService.getOrderList(0,number,account,phone,i);
            HttpSession session =req.getSession();
            session.setAttribute("order",orderings);
            resp.sendRedirect("order-set.jsp");
        }
        if(method.compareTo("modifyStatus")==0){
            String id=req.getParameter("id");
            int i=Integer.valueOf(id);
            Ordering ordering=sysOrderService.getOrderById(i);

            if(ordering.getOrderStatus()==1){
                ordering.setOrderStatus(0);
            }else {
                ordering.setOrderStatus(1);
            }
            boolean flag =sysOrderService.updata(ordering);
            ObjectMapper objectMapper =new ObjectMapper();
            resp.setContentType("text/json");
            resp.setCharacterEncoding("utf-8");

            if(flag){
                String json=objectMapper.writeValueAsString(ResponseResult.success(ordering));
                resp.getWriter().println(json);
            }
//            resp.sendRedirect("order-set.jsp");
        }
        if(method.compareTo("getOrderById")==0){
            String id =req.getParameter("id");
            int i =Integer.valueOf(id);
            Ordering ordering =sysOrderService.getOrderById(i);
            ObjectMapper objectMapper =new ObjectMapper();
            resp.setContentType("text/json");
            resp.setCharacterEncoding("utf-8");
            String json=objectMapper.writeValueAsString(ResponseResult.success(ordering));
            resp.getWriter().println(json);
        }
        if(method.compareTo("addFoodFromCart")==0){
            String userId=req.getParameter("userId");
            String price=req.getParameter("price");
            String detail=req.getParameter("detail");
            int id=Integer.valueOf(userId);
            double price1=Double.valueOf(price);

            boolean flag=sysOrderService.addOrder("2205171111",id,price1,detail);
            ObjectMapper objectMapper=new ObjectMapper();
            resp.setContentType("text/json");
            resp.setCharacterEncoding("utf-8");
            ArrayList<Ordering> orderings = sysOrderService.getOrderList(0,null,null,null,1);
            HttpSession session =req.getSession();
            session.setAttribute("order",orderings);
            resp.sendRedirect("firstRestaurant.jsp");

            if(flag){
                String json=objectMapper.writeValueAsString(ResponseResult.success());
                resp.getWriter().println(json);
            }
        }
    }
}
