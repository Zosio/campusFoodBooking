package com.booking.service;

import com.booking.domain.User;

public interface UserService {
    //用户登录
    public User login(String userAccount,String password);

    //用户注册
    public int register(String firtname,String lastname, String account, String password);
}
