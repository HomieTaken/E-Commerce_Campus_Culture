package Actions;

import java.sql.*;
import java.util.*;

import DataBase.*;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ActionContext;

public class LoginAction extends ActionSupport {

    private String userName;
    private String userPassword;
    private String msg;

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

            ActionContext actionContext = ActionContext.getContext();
            Map<String, Object> session = actionContext.getSession();
            session.put("login", this.getUserName());
            //ActionContext.getContext().getSession().put("login", user.getUserName());
            DBOperation.close();
            System.out.println("登陆成功");
            return SUCCESS;
        }
    }
}
