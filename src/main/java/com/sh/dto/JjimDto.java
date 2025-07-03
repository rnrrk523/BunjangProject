package com.sh.dto;

public class JjimDto {
    private int productIdx;
    private int price;
    private String productName;
    private String productImg1;
    private String saleStartDate;

    public JjimDto() {}

    public JjimDto(int productIdx, int price, String productName, String productImg1, String saleStartDate) {
        this.productIdx = productIdx;
        this.price = price;
        this.productName = productName;
        this.productImg1 = productImg1;
        this.saleStartDate = saleStartDate;
    }

    public int getProductIdx() {
        return productIdx;
    }

    public void setProductIdx(int productIdx) {
        this.productIdx = productIdx;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductImg1() {
        return productImg1;
    }

    public void setProductImg1(String productImg1) {
        this.productImg1 = productImg1;
    }

    public String getSaleStartDate() {
        return saleStartDate;
    }

    public void setSaleStartDate(String saleStartDate) {
        this.saleStartDate = saleStartDate;
    }

}

