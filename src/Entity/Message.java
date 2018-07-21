package Entity;

import com.sun.rowset.internal.WebRowSetXmlReader;

import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.sql.Date;
/*
* 消息类型(type)：product,activity=activity_id,report,comment,other,purchase=product_id
* 插入type类信息到数据库或数据库内type值书写规范为"类型=参数"
* 如："activity=4"表示活动类型数据，活动号为4
* */
public class Message {
    private int sender_id;
    private int user_id;
    private int message_id;
    private String message_text;
    private Timestamp date;
    private String type;
    private int activity_id;
    private String activity_name;
    private String sender_name;
    private boolean haveRead;
    private boolean havePic;
    private int product_id;
    private String reportReason;
    private String reportDetail;
private int reportedTeamID;
private int relatedProID;

    public int getRelatedProID() {
        return relatedProID;
    }

    public int getReportedTeamID() {
        return reportedTeamID;
    }

    public String getReportDetail() {
        return reportDetail;
    }

    public String getReportReason() {
        return reportReason;
    }

    public int getProduct_id() {
        return product_id;
    }

    public boolean getHavePic(){
        return havePic;
    }
    public Timestamp getDate() {
        return date;
    }

    public int getMessage_id() {
        return message_id;
    }

    public int getSender_id() {
        return sender_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public int getActivity_id() {
        return activity_id;
    }

    public String getMessage_text() {
        return message_text;
    }

    public String getSender_name() {
        return sender_name;
    }

    public String getType() {
        return type;
    }

    public void setHaveRead(boolean haveRead) {
        this.haveRead = haveRead;
    }

    public boolean getHaveRead(){return haveRead;}
    public String getActivity_name() {
        return activity_name;
    }

    public static Message[] getMessages(ResultSet rs){
        Message[] messages=new Message[0];
        try {
            ArrayList<Message>arrayList=new ArrayList<Message>();
            while (rs.next()) {
                Message message=new Message();
                try {
                    message.date=rs.getTimestamp("date");
                }
                catch(Exception ex){}
                try {
                    message.sender_id=rs.getInt("sender_id");
                }
                catch(Exception ex){}
                try {
                    message.haveRead=rs.getBoolean("haveRead");
                }
                catch(Exception ex){}
                try {
                    message.message_id=rs.getInt("message_id");
                }
                catch(Exception ex){}
                try {
                    message.message_text=rs.getString("message_text");
                }
                catch(Exception ex){}
                Blob p=null;
                try {
                    p=rs.getBlob("message_picture");
                }
                catch(Exception ex){}
               if(p==null){
                   message.havePic=false;
               }
               else {
                   message.havePic=true;
               }
               String str=rs.getString("type");
               String[] typeInfo=str.split("=");
                message.type=typeInfo[0];
               if(typeInfo[0].equals("activity")){
                   message.activity_id=Integer.parseInt(typeInfo[1]);
                   message.activity_name=Activity.getActivity("select * from activity where activity_id="
                           +message.activity_id)[0].getActivityName();
               }
                if(typeInfo[0].equals("purchase")){
                    message.product_id=Integer.parseInt(typeInfo[1]);
                }
                if(typeInfo[0].equals("product")){
                    message.product_id=Integer.parseInt(typeInfo[1]);
                }
                if(typeInfo[0].equals("report")){
                   message.reportedTeamID=Integer.parseInt(typeInfo[1]);
                   if(typeInfo.length>1)
                   message.reportReason=typeInfo[2];
                   else
                       message.reportReason="";
                   message.reportDetail=message.getMessage_text();
                }
                if(typeInfo[0].equals("reportResponse")){
                   message.reportedTeamID=Integer.parseInt(typeInfo[1]);
                }
                if(typeInfo[0].equals("comment")){
                   if(typeInfo.length==1)
                       message.relatedProID=7;
                   else
                    message.relatedProID=Integer.parseInt(typeInfo[1]);
                }
               try {
                   message.sender_name = rs.getString("user_name");
               }
               catch (Exception e){}
               arrayList.add(message);
            }
            messages=new Message[arrayList.size()];
            for(int i=0;i<arrayList.size();i++){
                messages[i]=arrayList.get(i);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return messages;
    }
    public static int haveNotRead(ArrayList<Message> messages){
        if(messages==null)
            return 0;
        int count=0;
        for(int i=0;i<messages.size();i++){
            if(messages.get(i).getHaveRead()==false)
                count++;
        }
        return count;
    }
   /* public static Message[] getSendMessageContent(ResultSet rs){
        Message[] messages=null;
        try {
            ArrayList<Message>arrayList=new ArrayList<Message>();
            while (rs.next()) {
                Message message=new Message();
                message.date=rs.getTimestamp("date");
                message.message_id=rs.getInt("message_id");
                message.message_text=rs.getString("message_text");
                String str=rs.getString("type");
                String[] typeInfo=str.split("=");
                message.type=typeInfo[0];
                if(typeInfo[0].equals("activity")){
                    message.activity_id=Integer.parseInt(typeInfo[1]);
                    message.activity_name=Activity.getActivity("select * from activity where activity_id="
                            +message.activity_id)[0].getActivityName();
                }
                arrayList.add(message);
            }
            messages=new Message[arrayList.size()];
            for(int i=0;i<arrayList.size();i++){
                messages[i]=arrayList.get(i);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return messages;
    }*/
}
