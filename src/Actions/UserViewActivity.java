package Actions;
import Entity.*;

import Operations.ViewTeam;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;

public class UserViewActivity implements Action {
    //private Activity[] activities=null;//返回的活动数组
    private int teamID;//团队id号
    private int page; //第几页
public void setPage(int page){
    this.page=page;
}
public int getPage(){
    return page;
}
public void setTeamID(int id){
    teamID=id;
}
public int getTeamID(){
    return teamID;
}

    @Override
    public String execute() {
    int size=2;
    Activity[] activities=ViewTeam.getActivity(teamID,page,size+1);//多获取一页，判断是否有下一页
        ActionContext.getContext().put("teamActivities",activities);//加入活动到属性
    if(activities.length>size)
        ActionContext.getContext().put("hasNextPage",true);//是否有下一页活动
        else
        ActionContext.getContext().put("hasNextPage",false);//是否有下一页活动
        //setActivities(activities);
        return SUCCESS;
    }
}
