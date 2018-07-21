package Actions;

import DataBase.DBOperation;
import Entity.Comment;
import Entity.CommentPlus;
import Entity.CultureProduct;
import Operations.getCommentList;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import net.sf.json.JSONArray;

import java.sql.ResultSet;
import java.util.List;
import java.util.Map;

public class ToComment extends ActionSupport {
    private int product_id;

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    @Override
    public String execute() throws Exception {
        ActionContext actionContext = ActionContext.getContext();
        Map<String, Object> session = actionContext.getSession();
       int count = 1;
       ResultSet rs = DBOperation.getRS("select count(*) from comment");
       if(rs.next())
       {
           count = rs.getInt("count(*)");
       }
    if(count > 0) {
        List<Comment> commentList = new getCommentList().queryCommentByPid(this.getProduct_id());
        List<CommentPlus> commentPlusList = Comment.toCommentPlusList(commentList);
        //String s = commentPlusList.toString();
        // System.out.println(s);
//        JSONArray json = new JSONArray();
//        for(Comment c : commentList){
//            JSONObject jo = new JSONObject();
//            jo.put("id", c.getComment_id());
//            jo.put("replyName", convertToName(c.getComment_id()));
//            json.add(jo);
//        }
        JSONArray json = JSONArray.fromObject(commentPlusList);
        String str = json.toString();
      //  System.out.println(str);
        session.put("comment", str);
        session.put("pid", product_id);
    }
    else
    {
        session.put("comment", "[]");
        session.put("pid", product_id);
    }
        CultureProduct product = new CultureProduct();
    ResultSet rs1 = DBOperation.getRS("select * from product where product_id = '"+this.getProduct_id()+"'");
       if(rs1.next())
       {
           product.setProductID(this.product_id);
           product.setDescription(rs1.getString("product_info"));
           product.setName(rs1.getString("product_name"));
           product.setPrice(rs1.getDouble("product_price"));
       }
    session.put("comment_product",product);
        return "success";
    }


}
