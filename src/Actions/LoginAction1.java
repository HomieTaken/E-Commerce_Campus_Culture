package Actions;

import java.sql.*;
import java.util.*;

import DataBase.*;
import Operations.MessageOperate;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ActionContext;

/*public class LoginAction extends ActionSupport {

    private String userName;
    private String userPassword;
    private String userType;
    private String msg;

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    private String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    private String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    @Override
    public String execute() throws Exception {
        String sql = "select * from user where user_name = '" + this.getUserName()+"' and user_password = '"+ this.getUserPassword() +"'";
        System.out.println(sql);
        ResultSet rs = DBOperation.getRS(sql);
        if(!rs.next()){
            msg = "用户名或密码错误，请重新输入！";
            System.out.println(msg);
            DBOperation.close();
            return ERROR;
        } else {
            rs=DBOperation.getRS("select user_type from user where user_name='"+userName+"'");
            if(rs.next()){
                userType=rs.getNString(1);
            }
            if(userType==null||(!userType.equals("INDIVIDUAL")&&!userType.equals("TEAM")))
                return ERROR;
            ActionContext actionContext = ActionContext.getContext();
            Map<String, Object> session = actionContext.getSession();
            session.put("user_name", this.getUserName());
            //ActionContext.getContext().getSession().put("login", user.getUserName());
           // rs=DBOperation.getRS("select * from user where user_name='"+userName+"'");
           // rs.next();
            //以下为修改了别人的内容-----------------------------
             rs=DBOperation.getRS("select * from user where user_name='"+userName+"'");
             rs.next();
            int id=rs.getInt("user_id");
            //加入用户id
            session.put("user_id",id);
            //加入用户新消息
            int count=MessageOperate.getNewMessageNum(id);
            session.put("message_count",count);
            //--------------------------------------------------
            DBOperation.close();
            System.out.println("登陆成功");
            if(userType.equals("INDIVIDUAL")) {
                return SUCCESS;
            }
            else return INPUT;
        }
    }
}*/
