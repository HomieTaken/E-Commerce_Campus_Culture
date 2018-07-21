package Actions;

import DataBase.DBOperation;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Objects;

public class AddComment extends ActionSupport {

    private String content;
    private String time;
    private String replyName;
    private String beReplyName;
    private String type;
    private String beReplyTime;
    private InputStream inputStream;

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getBeReplyName() {
        return beReplyName;
    }

    public void setBeReplyName(String beReplyName) {
        this.beReplyName = beReplyName;
    }

    public String getReplyName() {
        return replyName;
    }

    public void setReplyName(String replyName) {
        this.replyName = replyName;
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getBeReplyTime() {
        return beReplyTime;
    }

    public void setBeReplyTime(String beReplyTime) {
        this.beReplyTime = beReplyTime;
    }

    public String execute() throws UnsupportedEncodingException {
        int commentID = 0;
        int from_product_id = (int) ActionContext.getContext().getSession().get("pid");
        int commentUID = 0;
        int toCommentID = 0;
        String user_name = (String) ActionContext.getContext().getSession().get("user_name");
        String json="{\"success\":\"true\",\"replyName\":\""+user_name+"\"}";
        try{
            ResultSet rs = DBOperation.getRS("select max(comment_id) from comment");
            if(rs.next())
                commentID = rs.getInt("max(comment_id)")+1;
            ResultSet rs1 = DBOperation.getRS("select user_id from user where user_name = '" +user_name+"'");
            if(rs1.next())
                commentUID = rs1.getInt("user_id");
            if(commentUID == 0) {
                inputStream=new ByteArrayInputStream(json.getBytes("UTF-8"));
                return SUCCESS;
            }
            if(Objects.equals(this.getType(), "COMMENT"))
            {
                String sql = "insert into comment(comment_id,from_product_id,comment_content,comment_uid,reply_type,comment_time)"+
                        "values(\'" + commentID +
                        "\',\'"+from_product_id+
                        "\',\'"+this.getContent()+
                        "\',\'"+commentUID+
                        "\',\'"+this.getType()+
                        "\',\'"+this.getTime()+
                        "\')";
                System.out.println(sql);
                int ret = DBOperation.Update(sql);
                if(ret != 0)
                {
                    System.out.println("插入评论数据成功");
                }
                else
                {
                    System.out.println("插入评论数据失败");
                }
            }
            else if(Objects.equals(this.getType(), "REPLY"))
            {
                ResultSet rs2 = DBOperation.getRS("select comment_id from comment where comment_time = '"+this.getBeReplyTime()+"'");
                if(rs2.next())
                    toCommentID = rs2.getInt("comment_id");
                String sql =  "insert into comment(comment_id,from_product_id,comment_content,comment_uid,reply_type,to_comment_id,comment_time)"+
                        "values(\'" + commentID +
                        "\',\'"+from_product_id+
                        "\',\'"+this.getContent()+
                        "\',\'"+commentUID+
                        "\',\'"+this.getType()+
                        "\',\'"+toCommentID+
                        "\',\'"+this.getTime()+
                        "\')";
                int ret = DBOperation.Update(sql);
                if(ret != 0)
                {
                    System.out.println("插入回复内容成功");
                }
                else
                {
                    System.out.println("插入回复内容失败");
                }
            }
            else {
                System.out.println("未知错误");
            }

        }catch (SQLException e)
        {
            System.out.println("数据库错误");
            e.printStackTrace();
            json="{success:\"false\"}";
        }
        inputStream=new ByteArrayInputStream(json.getBytes("UTF-8"));
      return SUCCESS;
    }
}
