package Actions;

import DataBase.DBOperation;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.dispatcher.SessionMap;

import java.sql.ResultSet;
import java.util.Map;

public class Load extends ActionSupport {
    @Override
    public String execute() throws Exception {
        ActionContext actionContext = ActionContext.getContext();
        Map<String, Object> session = actionContext.getSession();
        return SUCCESS;
    }
}
