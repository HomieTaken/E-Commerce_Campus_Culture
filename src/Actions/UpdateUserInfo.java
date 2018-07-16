package Actions;
/*
  更新用户信息
  密码,用户名,邮箱.
  待续...
 */

import java.sql.*;
import java.util.*;

import DataBase.*;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ActionContext;
public class UpdateUserInfo extends ActionSupport{
    private String name;
    private String email;
    private String password;
    private String school;

    private String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    private String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    private String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    private String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    @Override
    public String execute() throws Exception{
        ActionContext actionContext = ActionContext.getContext();
        Map<String, Object> session = actionContext.getSession();
        String current_name = (String)session.get("user_name");
        if(this.getName() != null) {//更新名字
            String sql1 = "select * from user where user_name = "+ "'"+ this.getName()+"'";
            ResultSet rs1 = DBOperation.getRS(sql1);
            if(rs1.next())
            {
                if(!Objects.equals(this.getName(), current_name))
                System.out.println("用户名已存在");
                return "success";
            }
            else{
                String sql2 = "update user set user_name = '"+ this.getName() + "'"+"where user_name = '" + current_name+"'";
                int ret = DBOperation.Update(sql2);
                if(ret == 0)
                {
                    System.out.println("更新用户名失败");
                }
                else {
                    System.out.println("更新用户名成功");
                    session.put("user_name", this.getName());
                }
            }
           DBOperation.close();
        }
           if(this.getEmail() != null) //更新邮箱
           {
               String sql = "update user set user_email = '"+ this.getEmail()+"'" +"where user_name = '" +current_name+"'";
               int ret = DBOperation.Update(sql);
               if(ret == 0)
               {
                   System.out.println("更新邮箱失败");
               }
               else
                   System.out.println("更新邮箱成功");
               DBOperation.close();
           }

           if(this.getPassword() != null)//更新密码
           {
               String sql = "update user set user_password = '"+ this.getPassword()+"'" +"where user_name = '" +current_name+"'";
               int ret = DBOperation.Update(sql);
               if(ret == 0)
               {
                   System.out.println("更新密码失败");
               }
               else
                   System.out.println("更新密码成功");
               DBOperation.close();
           }

           if(this.getSchool() != null)//更新学校
           {
               String sql = "update user set user_school_name = '"+ this.getSchool()+"'" +" where user_name = '" +current_name+"'";
               int ret = DBOperation.Update(sql);
               if(ret == 0)
               {
                   System.out.println("更新失败");
               }
               else
                   System.out.println("更新成功");
               DBOperation.close();
           }

           return "success";
    }
}
