package Actions;

import DataBase.DBOperation;
import Entity.UserType;
import com.opensymphony.xwork2.ActionSupport;

import java.sql.ResultSet;

public class RegisterAction extends ActionSupport {
    private String name;
    private String password;
    private String repeatPassword;
    private String userType;
    private String school;
    private String email;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRepeatPassword() {
        return repeatPassword;
    }

    public void setRepeatPassword(String repeatPassword) {
        this.repeatPassword = repeatPassword;
    }

    @Override
    public String execute() throws Exception {
        System.out.println(this.userType);
        System.out.println(this.school);
        String type;//获得用户类型
        if (userType==null)
            return INPUT;
        if(this.getUserType().equals("singerUser"))
            type = UserType.INDIVIDUAL.toString();
        else
            type = UserType.TEAM.toString();

        System.out.println(type);
//        int newNO = 0;
        ResultSet rs1 = DBOperation.getRS("select * from user where user_name='"+this.getName()+"'");
//        ResultSet rs2 = DBOperation.getRS("select max(user_id) from user ");
//        if(!rs2.next())
//        {
//            newNO = rs2.getInt("max(user_id)") + 1;//获得用户id
//        }
        if(rs1.next())
        {
            System.out.println("用户名已存在");
            DBOperation.close();
            return INPUT;
        }else{
//          if (type.equals("singerUser"))//个人用户,正常注册
//          {
//
//              return "success";
//          }
//         else if(type.equals("teamUser"))//团体用户,验证??
//          {
//              return "success";
//          }
            if(!type.isEmpty() && !this.getName().isEmpty() && !this.getEmail().isEmpty() && !this.getPassword().isEmpty() && !this.getSchool().isEmpty())
            {
                String sql ="insert into user(user_name,user_email,user_password,user_school_name,user_type) values('"+this.getName()+"','"+this.getEmail()+"','"+this.getPassword()+"','"+this.getSchool()+"','"+type.toUpperCase()+"')";
                int ret = DBOperation.Update(sql);
                if(ret != 0 )
                {
                    System.out.println("注册成功");
                    return "success";
                }
                else{
                    System.out.println("注册失败");
                    return "input";
                }
            }
            else
            {
                System.out.println("有信息为空");
                return "input";
            }
        }
    }
}
