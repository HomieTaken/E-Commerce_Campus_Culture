package Actions;

import Operations.ViewProduct;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;

public class AddAddress implements Action {
    private int productID;
    private String city;
    private String addressDetail;
    private String receiverName;
    private String phoneNumber;

    public String getCity() {
        return city;
    }

    public void setCity(String city) throws UnsupportedEncodingException {
//        byte[] b;
//        b=city.getBytes("ISO-8859-1");
//        city = new String(b, "utf-8");
        this.city = city;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getAddressDetail() {
        return addressDetail;
    }

    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
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

        StringBuilder theAddress= new StringBuilder();

        String[] address=city.split("/");
        for (String addres : address) theAddress.append(addres);

        ViewProduct.addAddress(userID, (theAddress + addressDetail).toString(),receiverName,phoneNumber);

        return SUCCESS;
    }
}
