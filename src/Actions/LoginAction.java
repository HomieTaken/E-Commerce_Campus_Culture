package Actions;

import java.sql.*;
import java.util.*;

import DataBase.*;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ActionContext;

public class LoginAction extends ActionSupport {

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
            DBOperation.close();
            System.out.println("登陆成功");
            if(userType.equals("INDIVIDUAL"))
                return SUCCESS;
            else return INPUT;
        }
    }
}
