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
        Map<String, Object> session = ActionContext.getContext().getSession();
        session.put("teamID",teamID);
        Object user_id=session.get("user_id");
        if(user_id!=null) {
           // ActionContext.getContext().put("ActsBriefView", ViewTeam.getActBriefView(teamID, user_id));//加入活动预览
            ActionContext.getContext().put("ActsBriefView", ViewTeam.getAllActivityies(teamID, user_id));//加入活动预览
        }
        else{
           // ActionContext.getContext().put("ActsBriefView", ViewTeam.getActBriefView(teamID));//加入活动预览
            ActionContext.getContext().put("ActsBriefView", ViewTeam.getAllActivityies(teamID));//加入活动预览
        }
       // ActionContext.getContext().put("ProsBriefView",ViewTeam.getProBriefView(teamID));//加入商品预览
        ActionContext.getContext().put("ProsBriefView",ViewTeam.getAllProducts(teamID));//加入商品预览
        ActionContext.getContext().put("report_team_id", new Integer(teamID));//加入活动预览
        return SUCCESS;
    }
}
