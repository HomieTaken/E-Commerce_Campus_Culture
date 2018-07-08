package Actions;

import Operations.ViewProduct;
import Operations.ViewTeam;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;

public class ProductDetail implements Action{
        private int productID;//团队id号
        public void setProductID(int id){
            productID=id;
        }
        public int getProductID(){
            return productID;
        }
        @Override
        public String execute() {
            ActionContext.getContext().put("productDetail",ViewProduct.viewGivenPro(getProductID()));//加入活动预览
            return SUCCESS;
        }
}
