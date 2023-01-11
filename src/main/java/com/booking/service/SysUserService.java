package com.booking.service;

import com.booking.domain.Food;

import java.util.ArrayList;

public interface SysUserService {
    public Food getFood();

    public int addFood(String name,String image,double price);

    public Food getFoodById(int id);

    public int modifyFood(String name,double price,int id);

    public ArrayList<Food> queryFoodList(String name, String price, int status);

    public boolean updata(Food food);
}
