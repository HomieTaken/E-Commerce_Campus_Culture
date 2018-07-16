package Actions;
import Entity.CultureProduct;
import Entity.Message;
import Operations.MessageOperate;
import Operations.ViewProduct;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import org.apache.struts2.ServletActionContext;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.ResultSet;

public class addProduct implements Action {
    private String category;
    private int num;
    private String address;
    private int userID;

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public void setCategory(String category){this.category=category;}
    public void setNumber(int number){this.num=number;}
    public void setAddress(String address){this.address=address;}
    public String getCategory(){return category;}
    public int getNumber(){return num;}
    public String getAddress(){return address;}
    @Override
    public String execute() {
        ActionContext actionContext=ActionContext.getContext();
        int userID;
        if(!actionContext.getSession().containsKey("user_name")) {
            return "log";
        }
        userID = (int)actionContext.getSession().get("user_id");
         ViewProduct.addPro(category,userID,num);
      /*  ResultSet rs=MessageOperate.addPurchaseMessage(userID,Integer.parseInt(category),num);
        try {
            if (rs.next()) {
                CultureProduct pro=ViewProduct.viewGivenPro(Integer.parseInt(category));
                MessageOperate.addMessageToUser(rs.getInt(1),pro.getTeamID());
                MessageOperate.sendToUser(pro.getTeamID());
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }*/
        return SUCCESS;
    }
    public String changeAmount(){
        ViewProduct.changeRecordNum(userID,Integer.parseInt(category),num);
        return null;
    }
    public String deleteRecord(){
        ViewProduct.deleteRecord(userID,Integer.parseInt(category));
        return SUCCESS;
    }
}
