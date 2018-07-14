package Actions;

import DataBase.DBOperation;
import com.opensymphony.xwork2.ActionSupport;

import java.sql.Date;
import java.sql.SQLException;

public class ReleaseActivity extends ActionSupport {

    private String activityName;
    private String activityAddress;
    private Date beginDate;
    private Date endDate;
    private String description;
    private String teamID;

    public String getTeamID() {
        return teamID;
    }

    public void setTeamID(String teamID) {
        this.teamID = teamID;
    }

    public String getActivityAddress() {
        return activityAddress;
    }

    public void setActivityAddress(String activityAddress) {
        this.activityAddress = activityAddress;
    }

    public String getActivityName() {
        return activityName;
    }

    public void setActivityName(String activityName) {
        this.activityName = activityName;
    }

    public Date getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(Date beginDate) {
        this.beginDate = beginDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    @Override
    public String execute() throws Exception {
        boolean result=operate();
        if(result)
            return SUCCESS;
        else return INPUT;
    }

    private boolean operate() {
        String sql ="insert into activity(activity_name,activity_team_id," +
                "activity_releaseDate,activity_endDate," +
                "activity_info,activity_address) " +
                "values('" +
                activityName+
                "'," +this.teamID+
                ",date('" +
                beginDate+
                "'),date('" +
                endDate+
                "'),'" +
                description+
                "','" +
                activityAddress+
                "')";
        try {
            DBOperation.Update(sql);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
