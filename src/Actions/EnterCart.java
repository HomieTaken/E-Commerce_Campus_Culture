package Actions;

import Entity.ShoppingRecord;
import Operations.MessageOperate;
import Operations.ViewProduct;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;

public class EnterCart implements Action {
    @Override
    public String execute() {
        ActionContext actionContext=ActionContext.getContext();
         Object user_id = actionContext.getSession().get("user_id");
        if(user_id==null){
            return "fail";
        }
        int userID=(int) user_id;
        ShoppingRecord[]records=ViewProduct.viewShoppingPro(userID);
        if(records.length>0)
        ActionContext.getContext().put("cartDetail",records);//加入商品预览
        if(actionContext.getSession().containsKey("message_count")) {
            int count = MessageOperate.getNewMessageNum(userID);
            actionContext.getSession().replace("message_count", count);
        }
        return SUCCESS;
    }
}
