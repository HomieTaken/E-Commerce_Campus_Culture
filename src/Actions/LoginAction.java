package Actions;

import java.sql.*;
import java.util.*;

import DataBase.*;
import Operations.MessageOperate;
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
    public void validate() {
        String sql = "select * from user where user_name = '" + this.getUserName()+"' and user_password = '"+ this.getUserPassword() +"'";
        System.out.println(sql);
        try {
            ResultSet rs = DBOperation.getRS(sql);
            if (!rs.next()) {
                addFieldError("userName","用户名或密码错误，请重新输入！");
//                msg = "用户名或密码错误，请重新输入！";
//                System.out.println(msg);
                DBOperation.close();
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public String execute() throws Exception {
//        String sql = "select * from user where user_name = '" + this.getUserName()+"' and user_password = '"+ this.getUserPassword() +"'";
//        System.out.println(sql);
//        ResultSet rs = DBOperation.getRS(sql);
//        if(!rs.next()){
//            msg = "用户名或密码错误，请重新输入！";
//            System.out.println(msg);
//            DBOperation.close();
//            return ERROR;
//        } else {
        int userID = 0;
        ResultSet rs = DBOperation.getRS("select user_type,user_id from user where user_name='" + userName + "'");
        if (rs.next()) {
            userType = rs.getNString(1);
            userID = rs.getInt(2);
        }

        ActionContext actionContext = ActionContext.getContext();
        Map<String, Object> session = actionContext.getSession();
        session.remove("user_name");
        session.remove("user_id");
        session.remove("user_type");
        session.put("user_name", this.getUserName());
        session.put("user_id", userID);
        session.put("user_type", userType);
       //--------------------------------------------------
        //加入用户新消息
        int count=MessageOperate.getNewMessageNum(userID);
        session.put("message_count",count);
        //------------------------------------------------
        //ActionContext.getContext().getSession().put("login", user.getUserName());
        DBOperation.close();
        System.out.println("登陆成功");
        switch (userType.toUpperCase()) {
            case "INDIVIDUAL":
                return "individual";
            case "TEAM":
                return "team";
            case "SCHOOL":
                return "school";
            default:
                return INPUT;
        }

    }

}
