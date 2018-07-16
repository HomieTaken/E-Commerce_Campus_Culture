package Actions;

import Operations.MessageOperate;
import Operations.ViewProduct;
import Operations.ViewTeam;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProductDetail implements Action{
        private int productID;//团队id号
    private String log;
        public void setProductID(int id){
            productID=id;
        }
        public int getProductID(){
            return productID;
        }
        @Override
        public String execute() {
            /*HttpServletRequest response = ServletActionContext.getRequest();
            try {
                response.setCharacterEncoding("text/plain;charset=utf-8");
            }
            catch (Exception e){
                e.printStackTrace();
            }*/
            ActionContext actionContext=ActionContext.getContext();
            ActionContext.getContext().put("productDetail",ViewProduct.viewGivenPro(getProductID()));//加入商品预览
            int  userID;
            if(actionContext.getSession().containsKey("user_name")) {
               userID = (int)actionContext.getSession().get("user_id");
                String[]address= ViewProduct.getUserAddress(userID);
               if(address!=null&address.length>0) {
                   actionContext.put("addressDetail", address);
               }
                if(actionContext.getSession().containsKey("message_count")) {
                    int count = MessageOperate.getNewMessageNum(userID);
                    actionContext.getSession().replace("message_count", count);
                }
            }
                        return SUCCESS;
        }
}
