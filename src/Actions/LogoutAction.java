package Actions;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import java.util.Map;

public class LogoutAction extends ActionSupport {

    @Override
    public String execute() throws Exception {
        Map<String, Object> attributes = ActionContext.getContext().getSession();
        //记得退出的时候清除session，否则下次登录是当前的值
        attributes.remove("user_name");

        return SUCCESS;
    }
}
