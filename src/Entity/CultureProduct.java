package Entity;

import DataBase.DBOperation;

import java.sql.Blob;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CultureProduct {
    private int productID;
    private int teamID;
    private double price;
    private Blob picture;
    private String description;
    private String name;
    private int amount;

    public int getTeamID() {
        return teamID;
    }

    public void setTeamID(int teamID) {
        this.teamID = teamID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getDescription() {
        return description;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Blob getPicture() {
        return picture;
    }

    public void setPicture(Blob picture) {
        this.picture = picture;
    }

    public double getPrice() {
        return price;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public static CultureProduct[] getProduct(String sql){
        try {
            ResultSet rs = DBOperation.getRS(sql);
            return exchangeProduct(rs);
        }
        catch(Exception e){}
        return null;
    }
    public static CultureProduct[] exchangeProduct(ResultSet rs){
        ArrayList<CultureProduct>array=new ArrayList<CultureProduct>();
        try {
            CultureProduct ac=null;
            while (rs.next()) {
                ac=new CultureProduct();
                ac.setPrice(rs.getDouble("product_price"));
                ac.setDescription(rs.getString("product_info"));
                ac.setName(rs.getString("product_name"));
                ac.setTeamID(rs.getInt("product_team_id"));
                ac.setPicture(rs.getBlob("product_img"));
                ac.setProductID(rs.getInt("product_id"));
                ac.setAmount(rs.getInt("product_sales"));
                array.add(ac);
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        CultureProduct[]exchange=new CultureProduct[array.size()];
        for(int i=0;i<array.size();i++){
            exchange[i]=array.get(i);
        }
        return exchange;
    }
}
