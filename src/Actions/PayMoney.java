package Actions;

import DataBase.DBConnect;
import Entity.ShoppingRecord;
import Operations.MessageOperate;
import Operations.RecordOperate;
import Operations.ViewProduct;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import org.apache.struts2.ServletActionContext;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class PayMoney implements Action {
    private int record_id;
    private int num;
private String str;

    public String getStr() {
        return str;
    }

    public void setStr(String str) {
        this.str = str;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public void setRecord_id(int record_id) {
        this.record_id = record_id;
    }

    public int getRecord_id() {
        return record_id;
    }

    @Override
    public String execute() {
        ActionContext actionContext=ActionContext.getContext();
        int  userID;
        if(actionContext.getSession().containsKey("user_name")) {
            userID = (int)actionContext.getSession().get("user_id");
            ShoppingRecord record=RecordOperate.deleteRecord(userID,record_id);
            ResultSet rs=MessageOperate.addPurchaseMessage(record,userID);
            try {
                if (rs.next()) {
                    MessageOperate.addMessageToUser(rs.getInt(1),record.getTeamID());
                    MessageOperate.sendToUser(record.getTeamID());
                }
            }
            catch (Exception e){
                e.printStackTrace();
            }
            if(actionContext.getSession().containsKey("message_count")) {
                int count = MessageOperate.getNewMessageNum(userID);
                actionContext.getSession().replace("message_count", count);
            }
        }
        return null;
    }
    public String changeRecordNum() {
        ActionContext actionContext = ActionContext.getContext();
        int userID;
        if (actionContext.getSession().containsKey("user_name")) {
            userID = (int) actionContext.getSession().get("user_id");
            ViewProduct.changeRecordNum(userID,record_id,num);
        }
        return null;
    }
    public String payMoney(){
        try {
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setContentType("text/plain;charset=utf-8");
            ServletOutputStream outputStream = response.getOutputStream();

            ActionContext actionContext = ActionContext.getContext();
            int userID = 0;
            if (actionContext.getSession().containsKey("user_name"))
                userID = (int) actionContext.getSession().get("user_id");
            String[] records = str.split(",");
            ShoppingRecord[] recordNum = new ShoppingRecord[records.length];
            for (int i = 0; i < recordNum.length; i++) {
                if (records[i].trim().equals("") == false)
                    recordNum[i] = ViewProduct.viewRecord(Integer.parseInt(records[i]));
            }
            Connection conn = DBConnect.getConnection();
            try {
                String sql = "";
                Statement statement = conn.createStatement();
                conn.setAutoCommit(false); //开启事务，禁止自动提交
                for (int i = 0; i < recordNum.length; i++) {
                    if (recordNum[i] != null && recordNum[i].getUserID() == userID) {
                        sql = "update product set product_amount=product_amount-" + recordNum[i].getAmount() + " where product_id=" + recordNum[i].getProductID();
                        statement.addBatch(sql);
                        sql = "delete from shoppingchart  where record_id=" + recordNum[i].getRecord_id();
                        statement.addBatch(sql);
                        sql = "update product set product_sales=product_sales+" + recordNum[i].getAmount() + " where product_id=" + recordNum[i].getProductID();
                        statement.addBatch(sql);
                    }
                }
                statement.executeBatch();
                conn.commit(); //执行成功，提交事务
                for(int i=0;i<recordNum.length;i++) {
                    ResultSet rs = MessageOperate.addPurchaseMessage(recordNum[i], userID);
                    try {
                        if (rs.next()) {
                            MessageOperate.addMessageToUser(rs.getInt(1), recordNum[i].getTeamID());
                            MessageOperate.sendToUser(recordNum[i].getTeamID());
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                if(actionContext.getSession().containsKey("message_count")) {
                    int count = MessageOperate.getNewMessageNum(userID);
                    actionContext.getSession().replace("message_count", count);
                }
            } catch (Exception e) {
                try {
                    conn.rollback(); //发生异常，事务回滚
                    String fail="fail";
                    outputStream.write(fail.getBytes("utf-8"));
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            outputStream.flush();
            outputStream.close();
        }catch (Exception e){
            e.printStackTrace();
        }




        return null;
    }
}
