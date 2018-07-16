package Actions;

import Operations.ViewProduct;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;

import java.sql.Connection;

public class AddAddress implements Action {
    private int productID;
    private String province;
private String city;
private String addressDetail;
private String userName;
private String phoneNumber;

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getAddressDetail() {
        return addressDetail;
    }

    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getProductID() {
        return productID;
    }

    @Override
    public String execute() {
        ActionContext actionContext=ActionContext.getContext();
        if(!actionContext.getSession().containsKey("user_name")) {
            return "log";
        }
       int userID = (int)actionContext.getSession().get("user_id");
        try {
            byte[] b = province.getBytes("ISO-8859-1");
            province = new String(b, "utf-8");
             b = city.getBytes("ISO-8859-1");
            city = new String(b, "utf-8");
             b = addressDetail.getBytes("ISO-8859-1");
            addressDetail = new String(b, "utf-8");
        }
        catch (Exception e){
            e.printStackTrace();
        }
        ViewProduct.addAddress(userID,province+city+addressDetail);
        return SUCCESS;
    }
}
