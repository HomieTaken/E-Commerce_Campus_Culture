package Actions;

import DataBase.DBOperation;
import Entity.Activity;
import Entity.Team;
import Operations.MessageOperate;
import Operations.ViewProduct;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.util.ValueStack;

import javax.swing.text.View;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.ResultSet;

public class SendMessage implements Action {
    private String updateMessage;
    private File pictureFile;
    private int updateActivity;
    private int updateTeamID;
    private int reportTeamID;
    private String briefReportSchool;
    private String detailReportSchool;
private int receivedUser;
private int relatedProID;

    public int getRelatedProID() {
        return relatedProID;
    }

    public void setRelatedProID(int relatedProID) {
        this.relatedProID = relatedProID;
    }

    public int getReceivedUser() {
        return receivedUser;
    }

    public void setReceivedUser(int receivedUser) {
        this.receivedUser = receivedUser;
    }

    public String getBriefReportSchool() {
        return briefReportSchool;
    }

    public String getDetailReportSchool() {
        return detailReportSchool;
    }

    public void setBriefReportSchool(String briefReportSchool) {
        this.briefReportSchool = briefReportSchool;
    }

    public void setDetailReportSchool(String detailReportSchool) {
        this.detailReportSchool = detailReportSchool;
    }

    public int getReportTeamID() {
        return reportTeamID;
    }

    public void setReportTeamID(int reportTeamID) {
        this.reportTeamID = reportTeamID;
    }

    public int getUpdateTeamID() {
        return updateTeamID;
    }

    public void setUpdateTeamID(int updateTeamID) {
        this.updateTeamID = updateTeamID;
    }

    public int getUpdateActivity() {
        return updateActivity;
    }

    public void setUpdateActivity(int updateActivity) {
        this.updateActivity = updateActivity;
    }

    public File getPictureFile() {
        return pictureFile;
    }

    public String getUpdateMessage() {
        return updateMessage;
    }

    public void setPictureFile(File pictureFile) {
        this.pictureFile = pictureFile;
    }

    public void setUpdateMessage(String updateMessage) {
        this.updateMessage = updateMessage;
    }

    @Override
    public String execute() {
        try {
            ResultSet rs=MessageOperate.addActivityMessageRecord(updateActivity,updateMessage,pictureFile);
            if(rs.next())
            {
                MessageOperate.sendToAllPeople(rs.getInt(1),updateActivity);
            }
            return SUCCESS;
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
    public String comment(){
        ActionContext actionContext=ActionContext.getContext();
        Object user_id = actionContext.getSession().get("user_id");
        if(user_id==null){
            return "fail";
        }
        int userID=(int) user_id;
                    ResultSet rs = MessageOperate.addProCommentMessage(userID,relatedProID,updateMessage,pictureFile);
           try {
                if (rs.next()) {
                  //  MessageOperate.addMessageToUser(rs.getInt(1), updateTeamID);
                    int teamID=ViewProduct.viewGivenPro(relatedProID).getTeamID();
                    MessageOperate.addMessageToUser(rs.getInt(1),teamID);
                   // MessageOperate.sendToUser(updateTeamID);
                    MessageOperate.sendToUser(teamID);
           }
            } catch (Exception e) {
                e.printStackTrace();
            }
        return SUCCESS;
    }
    public String report(){
       ActionContext actionContext=ActionContext.getContext();
        Object user_id = actionContext.getSession().get("user_id");
        if(user_id==null){
            return "fail";
        }
        int userID=(int) user_id;
        ResultSet rs = MessageOperate.addReportMessage(reportTeamID,userID,briefReportSchool,detailReportSchool,pictureFile);
        try {
            if (rs.next()) {
                MessageOperate.addMessageToUser(rs.getInt(1),Team.getTeam(reportTeamID).getTeamSchool_id());
              //MessageOperate.sendToUser(Team.getTeam());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }
    public String responseUser(){
        ActionContext actionContext=ActionContext.getContext();
        Object user_id = actionContext.getSession().get("user_id");
        if(user_id==null){
            return "fail";
        }
        int userID=(int) user_id;
        ResultSet rs = MessageOperate.addProCommentMessage(userID,relatedProID,updateMessage,pictureFile);
        try {
            if (rs.next()) {
                MessageOperate.addMessageToUser(rs.getInt(1),receivedUser);
                MessageOperate.sendToUser(receivedUser);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
       // addAndSendMessage(rs,receivedUser);
        return SUCCESS;
    }
   /* public void addAndSendMessage(ResultSet rs,int receiver){
        try {
            if (rs.next()) {
                MessageOperate.addMessageToUser(rs.getInt(1),receivedUser);
                MessageOperate.sendToUser(receivedUser);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }*/
}
