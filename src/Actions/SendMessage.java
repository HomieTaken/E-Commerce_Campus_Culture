package Actions;

import DataBase.DBOperation;
import Operations.MessageOperate;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.util.ValueStack;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.ResultSet;

public class SendMessage implements Action {
    private String updateMessage;
    private File pictureFile;
    private int updateActivity;

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
}
