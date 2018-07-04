package Actions;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ActionContext;
import org.apache.struts2.ServletActionContext;

public class NavigationSwitch extends ActionSupport {

    public static String select="主页";

    private String navigation;

    public String getNavigation() {
        return navigation;
    }

    public void setNavigation(String navigation) {
        this.navigation = navigation;
    }

    @Override
    public String execute() throws Exception {
        if (navigation != null && (navigation.equals("主页")||navigation.equals("兴趣小组")||navigation.equals("产品团队"))) {
            select = String.copyValueOf(navigation.toCharArray());
            return SUCCESS;
        }
        return ERROR;
    }

}
