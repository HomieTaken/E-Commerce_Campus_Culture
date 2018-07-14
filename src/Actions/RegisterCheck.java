package Actions;

import DataBase.DBOperation;
import Entity.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.ResultSet;

public class RegisterCheck extends ActionSupport implements ModelDriven<User> {

    private User user = new User();
    private InputStream inputStream;

    @Override
    public User getModel() {
        return user;
    }

    public String registerCheck() throws IOException {
        String userName=user.getUserName();
        try {
            ResultSet rs = DBOperation.getRS("select * from user where user_name='" + user.getUserName() + "'");
            ResultSet resultSet=DBOperation.getRS("select * from team_apply where team_name=\'"+user.getUserName()+"\'");
            if (rs.next()||resultSet.next()) {
                inputStream = new ByteArrayInputStream("0".getBytes("UTF-8"));
                ActionContext.getContext().getSession().remove("user_register_check");
                ActionContext.getContext().getSession().put("user_register_check","false");
            } else {
                inputStream = new ByteArrayInputStream("1".getBytes("UTF-8"));
                ActionContext.getContext().getSession().remove("user_register_check");
                ActionContext.getContext().getSession().put("user_register_check", "true");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "ajax_succ";
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }
}
