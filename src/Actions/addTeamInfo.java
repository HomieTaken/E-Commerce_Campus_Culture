package Actions;

import Operations.MessageOperate;
import Operations.ViewProduct;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;

public class addTeamInfo implements Action {
    @Override
    public String execute() {
        ActionContext actionContext=ActionContext.getContext();
        int  userID;
        if(actionContext.getSession().containsKey("user_name")) {
            userID = (int) actionContext.getSession().get("user_id");
            if (actionContext.getSession().containsKey("message_count")) {
                int count = MessageOperate.getNewMessageNum(userID);
                actionContext.getSession().replace("message_count", count);
            }
        }
        return SUCCESS;
    }
}
