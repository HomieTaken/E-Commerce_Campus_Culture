package Actions;

import DataBase.DBOperation;
import Operations.MessageOperate;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;

public class testSend implements Action {
    private int sender_id;
    private int receiver;
    private int teamID;
    private String message;
    private String messageID;
    private InputStream inputStream;

    public String getMessageID() {
        return messageID;
    }

    public void setMessageID(String messageID) {
        this.messageID = messageID;
    }

    public int getSender_id() {
        return sender_id;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public void setTeamID(int teamID) {
        this.teamID = teamID;
    }

    public int getTeamID() {
        return teamID;
    }

    public int getReceiver() {
        return receiver;
    }

    public void setReceiver(int receiver) {
        this.receiver = receiver;
    }

    public void setSender_id(int sender_id) {
        this.sender_id = sender_id;
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    @Override
    public String execute() throws UnsupportedEncodingException {
        Object user_id = ActionContext.getContext().getSession().get("user_id");
        if(user_id==null){
            inputStream=new ByteArrayInputStream("false".getBytes("UTF-8"));
            return SUCCESS;
        }
        MessageOperate.addAndSendReportResponse(receiver,(int)user_id,teamID,message);
        try {
            DBOperation.Update("update message_manage set haveRead=1 where message_id="+messageID);
            inputStream=new ByteArrayInputStream("true".getBytes("UTF-8"));
        } catch (SQLException e) {
            inputStream=new ByteArrayInputStream("false".getBytes("UTF-8"));
            e.printStackTrace();
        }
        return SUCCESS;
    }
}
