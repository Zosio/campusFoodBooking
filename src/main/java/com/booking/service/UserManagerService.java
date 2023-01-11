package com.booking.service;

import com.booking.domain.User;

import java.util.ArrayList;

public interface UserManagerService {
    public User getUser();

    public int addUser(String name,String account,String pwd,String phone,int status,int role);

    public User getUserById(int id);

    public int modifyUser(int id,String name,String account,String pwd,String phone,int role);

    public ArrayList<User> queryUserList(String name,String account,String phone,int role,int status);

    public boolean updata(User user);
}
