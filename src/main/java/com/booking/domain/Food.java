package com.booking.domain;


public class Food {

  private long foodId;
  private String foodName;
  private String foodDetail;
  private String foodType;
  private double foodPrice;
  private long foodBelong;
  private String foodImage;
  private long foodStatus;

  public long getFoodStatus() {
    return foodStatus;
  }

  public void setFoodStatus(long foodStatus) {
    this.foodStatus = foodStatus;
  }

  public long getFoodId() {
    return foodId;
  }

  public void setFoodId(long foodId) {
    this.foodId = foodId;
  }


  public String getFoodName() {
    return foodName;
  }

  public void setFoodName(String foodName) {
    this.foodName = foodName;
  }


  public String getFoodDetail() {
    return foodDetail;
  }

  public void setFoodDetail(String foodDetail) {
    this.foodDetail = foodDetail;
  }


  public String getFoodType() {
    return foodType;
  }

  public void setFoodType(String foodType) {
    this.foodType = foodType;
  }


  public double getFoodPrice() {
    return foodPrice;
  }

  public void setFoodPrice(double foodPrice) {
    this.foodPrice = foodPrice;
  }


  public long getFoodBelong() {
    return foodBelong;
  }

  public void setFoodBelong(long foodBelong) {
    this.foodBelong = foodBelong;
  }


  public String getFoodImage() {
    return foodImage;
  }

  public void setFoodImage(String foodImage) {
    this.foodImage = foodImage;
  }

}
