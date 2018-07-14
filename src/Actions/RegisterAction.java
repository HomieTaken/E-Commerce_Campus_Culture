package Actions;

import DataBase.DBOperation;
import Entity.UserType;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.Date;

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

    public String registerCheck() throws IOException {

        return NONE;
    }

//    @Override
//    public void validate() {
//        super.validate();
//        try {
//            ResultSet rs = DBOperation.getRS("select * from user where user_name='" + this.getName() + "'");
//            if(rs.next()){
//                addFieldError("userNameMsg","用户名已存在！");
//                DBOperation.close();
//            }
//        }catch (Exception e){
//            e.printStackTrace();
//        }
//    }

    @Override
    public String execute() throws Exception {
        try {
            ResultSet rs = DBOperation.getRS("select * from user where user_name='" + this.getName() + "'");
            if(rs.next()){
                addFieldError("userNameMsg","用户名已存在！");
                DBOperation.close();
                return ERROR;
            }
        }catch (Exception e){
            e.printStackTrace();
            return ERROR;
        }
        System.out.println(this.userType);
        System.out.println(this.school);

        String type;//获得用户类型
        if (this.getUserType().equals("singerUser"))
            type = UserType.INDIVIDUAL.toString().toUpperCase();
        else
            type = UserType.TEAM.toString().toUpperCase();

        System.out.println(type);

        if (!type.isEmpty() && !this.getName().isEmpty() && !this.getEmail().isEmpty() && !this.getPassword().isEmpty() && !this.getSchool().isEmpty()) {
            switch (type) {
                case "TEAM": {
                    String sql = "insert into team_apply(team_name,team_email,team_password,team_school_name,team_apply_time)" +
                            " values(\'" + this.getName() +
                            "\',\'" + this.getEmail() +
                            "\',\'" + this.getPassword() +
                            "\',\'" + this.getSchool() +
                            "\',\'" + ChatServer.DATE_FORMAT.format(new Date()) +
                            "\')";
                    int ret = DBOperation.Update(sql);
                    DBOperation.close();
                    if (ret != 0) {
                        System.out.println("申请成功");
                        return SUCCESS;
                    } else {
                        System.out.println("申请失败");
                        return ERROR;
                    }
                }
                case "INDIVIDUAL": {
                    String sql = "insert into user(user_name,user_email,user_password,user_school_name,user_type) " +
                            "values(\'" + this.getName() +
                            "\',\'" + this.getEmail() +
                            "\',\'" + this.getPassword() +
                            "\',\'" + this.getSchool() +
                            "\',\'" + type + "\')";
                    int ret = DBOperation.Update(sql);
                    DBOperation.close();
                    if (ret != 0) {
                        System.out.println("注册成功");
                        return SUCCESS;
                    } else {
                        System.out.println("注册失败");
                        return ERROR;
                    }
                }
                default:
                    return ERROR;
            }
        } else {
            System.out.println("有信息为空");
            return ERROR;
        }
    }
}
