package Operations;

import Entity.CultureProduct;

public class ViewProduct {
    public static CultureProduct viewGivenPro(int id){
        CultureProduct pro=CultureProduct.getProduct(
                "select * from product where product_id="+id)[0];
        return pro;
    }
}
