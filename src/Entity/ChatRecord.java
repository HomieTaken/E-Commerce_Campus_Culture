package Entity;

import java.sql.Blob;
import java.sql.Date;

public class ChatRecord {
    private int groupID;
    private int userID;
    private Date date;
    private String text;
    private Blob picture;

    public void setTextOrPicture(boolean typeIsText,Blob picture,String text){
        if(typeIsText){
            this.picture=picture;
        }else {
            this.text=text;
        }
    }

    /*
     * 返回值判断消息的类型（文本或图片），1代表图片消息，-1代表文本消息
     * 在获取消息内容前调用
     */
    public int recordType(){
        if(picture!=null)
            return 1;
        else if(text!=null)
            return -1;
        else
            return 0;
    }

    public String getText() {
        return text;
    }

    public Blob getPicture() {
        return picture;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getGroupID() {
        return groupID;
    }

    public void setGroupID(int groupID) {
        this.groupID = groupID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }
}
