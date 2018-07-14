package Actions;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class EnterChat extends ActionSupport {

    private String groupName;

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    @Override
    public String execute() throws Exception {
        System.out.println(groupName);
        ActionContext.getContext().getSession().remove("group_name");
        ActionContext.getContext().getSession().put("group_name",groupName);
        return super.execute();
    }
}
