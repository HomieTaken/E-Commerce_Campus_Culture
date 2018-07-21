package Entity;

import DataBase.DBOperation;

import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Activity {
    private int activityID;
    private String activityName;
    private int teamID;
    private Date releaseDate;
    private Date endDate;
    private String description;
    private String address;
    private boolean haveEntered=false;

    public void setHaveEntered(boolean haveEntered) {
        this.haveEntered = haveEntered;
    }

    public boolean isHaveEntered() {
        return haveEntered;
    }

    public String getActivityName() {
        return activityName;
    }

    public void setActivityName(String activityName) {
        this.activityName = activityName;
    }

    public int getActivityID() {
        return activityID;
    }

    public void setActivityID(int activityID) {
        this.activityID = activityID;
    }

    public int getTeamID() {
        return teamID;
    }

    public void setTeamID(int teamID) {
        this.teamID = teamID;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public static Activity getActivity(int activityID){
       return getActivity("select * from activity where activity_id="+activityID)[0];
    }

    public static Activity[] getActivity(String sql){
        try {
            ResultSet rs = DBOperation.getRS(sql);
            return exchangeActivity(rs);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public static Activity[] exchangeActivity(ResultSet rs){
        ArrayList<Activity>array=new ArrayList<Activity>();
        try {
            Activity ac=null;
            while (rs.next()) {
                ac=new Activity();
                ac.setActivityID(rs.getInt("activity_id"));
                ac.setTeamID(rs.getInt("activity_team_id"));
                ac.setReleaseDate(rs.getDate("activity_releaseDate"));
                ac.setEndDate(rs.getDate("activity_endDate"));
                ac.setDescription(rs.getString("activity_info"));
                ac.setAddress(rs.getString("activity_address"));
                ac.setActivityName(rs.getString("activity_name"));
                array.add(ac);
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        Activity[]exchange=new Activity[array.size()];
        for(int i=0;i<array.size();i++){
            exchange[i]=array.get(i);
        }
        return exchange;
    }
    public static  int[] getAllParticipant(int activity_id){
        int[]result=null;
        try {
            ArrayList<Integer>arrayList=new ArrayList<Integer>();
            String sql = "select * from activity_participant where activity_id=" + activity_id;
            ResultSet rs = DBOperation.getRS(sql);
            while(rs.next()){
                int num=rs.getInt("activity_participant_id");
                Integer p=new Integer(num);
                arrayList.add(p);
            }
            result=new int[arrayList.size()];
            for(int i=0;i<arrayList.size();i++){
                result[i]=arrayList.get(i);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }
}
