package Actions;

import DataBase.DBOperation;
import com.opensymphony.xwork2.Action;
import org.apache.struts2.ServletActionContext;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
//获得图片资源
public class GetPicResource implements Action {
    private int productID;//团队id号
    public void setProductID(int id){
        productID=id;
    }
    public int getProductID(){
        return productID;
    }
    @Override
    public String execute() {
        HttpServletResponse response = null;
        ServletOutputStream out = null;
        try {
            response = ServletActionContext.getResponse();
           // response.setContentType("multipart/form-data");
            response.reset();
            response.setContentType("image/jpg"); //设置repose返回类型
            ServletActionContext.getRequest().setCharacterEncoding("gbk");
            out = response.getOutputStream();
            DBOperation.getPic(out,"select * from product where product_id="+getProductID(),"product_img");
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
