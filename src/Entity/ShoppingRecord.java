package Entity;

import DataBase.DBOperation;

import java.sql.Blob;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ShoppingRecord {
    private int productID;
    private int userID;
    private int amount;
    private double price;
    private Blob picture;
    private String name;
    private int teamID;
    private String teamName;
    private String address;
private int record_id;

    public int getRecord_id() {
        return record_id;
    }
    public void setRecord_id(int record_id) {
        this.record_id = record_id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getTeamID() {
        return teamID;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamID(int teamID) {
        this.teamID = teamID;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
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

    public static ShoppingRecord[] getRecord(String sql){
        try {
            ResultSet rs = DBOperation.getRS(sql);
            return exchangeRecord(rs);
        }
        catch(Exception e){}
        return null;
    }
    public static ShoppingRecord[] exchangeRecord(ResultSet rs){
        ArrayList<ShoppingRecord> array=new ArrayList<ShoppingRecord>();
        try {
            ShoppingRecord ac=null;
            while (rs.next()) {
                ac=new ShoppingRecord();
                ac.setPrice(rs.getDouble("product_price"));
                ac.setName(rs.getString("product_name"));
                ac.setProductID(rs.getInt("product_id"));
                ac.setAmount(rs.getInt("amount"));
                ac.setUserID(rs.getInt("user_id"));
                ac.setTeamID(rs.getInt("team_id"));
                ac.setTeamName(rs.getString("team_name"));
                ac.setRecord_id(rs.getInt("record_id"));
               // ac.setAddress(rs.getString("shopping_address"));
                array.add(ac);
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        ShoppingRecord[]exchange=new ShoppingRecord[array.size()];
        for(int i=0;i<array.size();i++){
            exchange[i]=array.get(i);
        }
        return exchange;
    }
}
