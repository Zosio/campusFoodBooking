package com.booking.service;

import com.booking.domain.Ordering;

import java.util.ArrayList;

public interface SysOrderService {
    public ArrayList<Ordering> getOrderList(int id, String number, String account, String phone, int status);

    public Ordering getOrderById(int id);

    public boolean updata(Ordering ordering);

    public boolean addOrder(String number,int UserId,double price,String detail);
}
