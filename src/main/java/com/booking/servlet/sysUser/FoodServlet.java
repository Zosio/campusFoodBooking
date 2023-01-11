package com.booking.servlet.sysUser;

import com.booking.domain.Food;
import com.booking.service.SysUserService;
import com.booking.service.impl.SysUserServiceImpl;
import com.booking.util.ResponseResult;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/food.do")
public class FoodServlet extends HttpServlet {
    SysUserService sysUserService=new SysUserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        PrintWriter out = resp.getWriter();
        resp.setContentType("text/html;charset=utf-8");

        String method=req.getParameter("type");
        String function=req.getParameter("function");

        if(method.compareTo("addfood")==0){
            String name=req.getParameter("name");
            String image=req.getParameter("image");
            String price=req.getParameter("price");
            double price0=Double.valueOf(price);

            int ur=sysUserService.addFood(name,image,price0);


            if(ur!=0){
                out.print("<script language='javascript'>alert('添加成功');window.location.href='product-set.jsp';</script>");
            }else out.print("<script language='javascript'>alert('添加失败');window.location.href='product-set.jsp';</script>");
        }
        if(method.compareTo("query")==0){
            String name=req.getParameter("name");
            String price=req.getParameter("price");
            String status=req.getParameter("isValid");
            int status1=Integer.valueOf(status);
            ArrayList<Food> foodlist=sysUserService.queryFoodList(name,price,status1);
            HttpSession session =req.getSession();
            session.setAttribute("foodlist",foodlist);
            resp.sendRedirect("product-set.jsp");
//            resp.sendRedirect("firstRestaurant.jsp");

        }
        if(method.compareTo("getFoodById")==0){
            String id=req.getParameter("id");
            int i= Integer.valueOf(id);
            Food food=sysUserService.getFoodById(i);
//            String[] foodinf={String.valueOf(food.getFoodId()),food.getFoodImage()};
            ObjectMapper objectMapper = new ObjectMapper();
            resp.setContentType("text/json");
            resp.setCharacterEncoding("utf-8");
            String json=objectMapper.writeValueAsString(ResponseResult.success(food));
            resp.getWriter().println(json);

//            if(food!=null){
//                req.setAttribute("food",food);
////                req.setAttribute("foodinf",foodinf);
//                req.getRequestDispatcher("product-set.jsp").forward(req,resp);
//            }

        }
        if(method.compareTo("modify")==0){
            String name=req.getParameter("name");
            String price =req.getParameter("price");
//            String id=req.getParameter("")

            Double price1=Double.valueOf(price);
            String foodId=req.getParameter("foodId");
            System.out.println(foodId);
            int foodId1=Integer.valueOf(foodId);
            int ur=sysUserService.modifyFood(name,price1,foodId1);

            if(ur!=0){
                out.print("<script language='javascript'>alert('修改成功');window.location.href='product-set.jsp';</script>");
            }else out.print("<script language='javascript'>alert('修改失败');window.location.href='product-set.jsp';</script>");
        }if(method.compareTo("modifyStatus")==0){
            String id = req.getParameter("id");
            int i =Integer.valueOf(id);
            Food food =sysUserService.getFoodById(i);

            if(food.getFoodStatus()==1){
                food.setFoodStatus(0);
            }else {
                food.setFoodStatus(1);
            }
            boolean flag =sysUserService.updata(food);
            ObjectMapper objectMapper = new ObjectMapper();
            resp.setContentType("text/json");
            resp.setCharacterEncoding("utf-8");

            if(flag){
                String json=objectMapper.writeValueAsString(ResponseResult.success(food));
                resp.getWriter().println(json);
            }
        }
//        if(method.compareTo("addToCart")==0){
//            String ii=req.getParameter("id");
//            int id=Integer.valueOf(ii);
//
//            Food food=sysUserService.getFoodById(id);
//        }
    }


}
