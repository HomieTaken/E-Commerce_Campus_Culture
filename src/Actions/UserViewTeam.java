package Actions;

import Operations.ViewTeam;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;

import java.util.Map;

public class UserViewTeam implements Action {
    private int teamID;//团队id号
    public void setTeamID(int id){
        teamID=id;
    }
    public int getTeamID(){
        return teamID;
    }
    @Override
    public String execute() {
        ActionContext.getContext().put("ActsBriefView",ViewTeam.getActBriefView(teamID));//加入活动预览
        ActionContext.getContext().put("ProsBriefView",ViewTeam.getProBriefView(teamID));//加入商品预览
        ActionContext actionContext = ActionContext.getContext();
        Map<String, Object> session = actionContext.getSession();
        session.put("teamID",teamID);
        return SUCCESS;
    }
}
