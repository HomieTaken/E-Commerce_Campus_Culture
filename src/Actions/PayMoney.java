package Actions;

import Entity.ShoppingRecord;
import Operations.MessageOperate;
import Operations.RecordOperate;
import Operations.ViewProduct;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;

import java.sql.ResultSet;

public class PayMoney implements Action {
    private int record_id;

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
}
