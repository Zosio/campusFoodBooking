package com.booking.domain;


public class Ordering extends User{

  private long orderId;
  private String orderDetail;
  private double orderPrice;
  private long orderBelongUser;
  private long orderBelongCt;
  private String orderNumber;
  private long orderStatus;



  public long getOrderId() {
    return orderId;
  }

  public void setOrderId(long orderId) {
    this.orderId = orderId;
  }


  public String getOrderDetail() {
    return orderDetail;
  }

  public void setOrderDetail(String orderDetail) {
    this.orderDetail = orderDetail;
  }


  public double getOrderPrice() {
    return orderPrice;
  }

  public void setOrderPrice(double orderPrice) {
    this.orderPrice = orderPrice;
  }


  public long getOrderBelongUser() {
    return orderBelongUser;
  }

  public void setOrderBelongUser(long orderBelongUser) {
    this.orderBelongUser = orderBelongUser;
  }


  public long getOrderBelongCt() {
    return orderBelongCt;
  }

  public void setOrderBelongCt(long orderBelongCt) {
    this.orderBelongCt = orderBelongCt;
  }


  public String getOrderNumber() {
    return orderNumber;
  }

  public void setOrderNumber(String orderNumber) {
    this.orderNumber = orderNumber;
  }


  public long getOrderStatus() {
    return orderStatus;
  }

  public void setOrderStatus(long orderStatus) {
    this.orderStatus = orderStatus;
  }

}
