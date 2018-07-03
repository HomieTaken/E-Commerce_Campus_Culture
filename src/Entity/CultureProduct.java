package Entity;

import java.sql.Blob;
import java.util.ArrayList;

public class CultureProduct {
    private int productID;
    private int teamID;
    private double price;
    private ArrayList<Blob> pictures;
    private String description;
    private String name;

    public CultureProduct(){
        pictures=new ArrayList<>();
    }

    public void addPicture(Blob picture){
        this.pictures.add(picture);
    }

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

    public ArrayList<Blob> getPictures() {
        return pictures;
    }

    public void setPictures(ArrayList<Blob> pictures) {
        this.pictures = pictures;
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
}
