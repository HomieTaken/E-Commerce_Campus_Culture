package Entity;

import java.util.ArrayList;

public class ShoppingCart {
    private int userID;
    private ArrayList<Integer> products;

    public ShoppingCart(){
        products=new ArrayList<>();
    }

    public void addProduct(CultureProduct product){
        products.add(product.getProductID());
    }

    public void removeProduct(CultureProduct product) {
        if (products.size() == 0)
            return;
        int index = -1;
        for (Integer product1 : products) {
            if (product1 == product.getProductID()) {
                index = product1;
                break;
            }
        }
        if (index != -1)
            products.remove(index);
    }

    public ArrayList<Integer> getProducts() {
        return products;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }
}
