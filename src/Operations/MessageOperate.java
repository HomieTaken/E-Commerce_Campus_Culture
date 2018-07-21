package Operations;

import Actions.ProductDetail;
import DataBase.DBOperation;
import Entity.*;
import SocketServer.MessageServer;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Map;

public class MessageOperate {
    public static java.sql.Timestamp getCurrentTime(){
        try {
            java.util.Date currentTime = new java.util.Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(currentTime);
            java.util.Date date = sdf.parse(time);
            java.sql.Timestamp ts = new java.sql.Timestamp(date.getTime());
            return ts;
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
    public static ResultSet addActivityEnterMessage(int sender_id,int activity_id){
        ResultSet result=null;
        try {
          /*  java.util.Date currentTime = new java.util.Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(currentTime);
            java.util.Date date = sdf.parse(time);
            java.sql.Timestamp ts = new java.sql.Timestamp(date.getTime());*/
            String sql = "insert into messagerecord(sender_id, message_text, date,type) "
                    + "values(" + sender_id + ",'" + "加入" + "','"+getCurrentTime()+"','activity=" + activity_id + "')";
            PreparedStatement ps = DBOperation.getPS(sql);
            int s = ps.executeUpdate();
            if (s > 0) {
                System.out.println("Uploaded successfully !");
            } else {
                System.out.println("unsucessfull to upload image.");
            }
            result = ps.getGeneratedKeys();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return  result;
    }
    public static ResultSet addActivityExitMessage(int sender_id,int activity_id){
        ResultSet result=null;
        try {
            /*java.util.Date currentTime = new java.util.Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(currentTime);
            java.util.Date date = sdf.parse(time);
            java.sql.Timestamp ts = new java.sql.Timestamp(date.getTime());*/
            String sql = "insert into messagerecord(sender_id, message_text, date,type) "
                    + "values(" + sender_id + ",'" + "退出" + "','"+getCurrentTime()+"','activity=" + activity_id + "')";
            PreparedStatement ps = DBOperation.getPS(sql);
            int s = ps.executeUpdate();
            if (s > 0) {
                System.out.println("Uploaded successfully !");
            } else {
                System.out.println("unsucessfull to upload image.");
            }
            result = ps.getGeneratedKeys();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return  result;
    }
    public static ResultSet addPurchaseMessage(ShoppingRecord record,int sender_id){
        ResultSet result=null;
        try {
           /* java.util.Date currentTime = new java.util.Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(currentTime);
            java.util.Date date = sdf.parse(time);
            java.sql.Timestamp ts = new java.sql.Timestamp(date.getTime());*/
            String sql = "insert into messagerecord(sender_id, message_text, date,type) "
                    + "values(" + sender_id + ",'" + record.getAmount() + "','"+getCurrentTime()+"','purchase=" + record.getProductID() + "')";
            PreparedStatement ps = DBOperation.getPS(sql);
            int s = ps.executeUpdate();
            if (s > 0) {
                System.out.println("Uploaded successfully !");
            } else {
                System.out.println("unsucessfull to upload image.");
            }
            result = ps.getGeneratedKeys();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return  result;
    }
    public static ResultSet addProductMessage(int product_id,int sender_id){
        ResultSet result=null;
        try {
            /*java.util.Date currentTime = new java.util.Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(currentTime);
            java.util.Date date = sdf.parse(time);
            java.sql.Timestamp ts = new java.sql.Timestamp(date.getTime());*/
            String sql = "insert into messagerecord(sender_id,date,type) "
                    + "values(" + sender_id + ",'"+getCurrentTime()+"','product=" + product_id + "')";
            PreparedStatement ps = DBOperation.getPS(sql);
            int s = ps.executeUpdate();
            if (s > 0) {
                System.out.println("Uploaded successfully !");
            } else {
                System.out.println("unsucessfull to upload image.");
            }
            result = ps.getGeneratedKeys();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return  result;
    }
    public static ResultSet addProCommentMessage(int user_id,int relatedProID,String updateMessage,File pictureFile){
        ResultSet result=null;
        try {
            String sql = "insert into messagerecord(sender_id, message_text,message_picture, date,type) "
                    + "values(" + user_id + ",'" + updateMessage + "',?,'" + getCurrentTime() + "','comment=" +relatedProID + "')";
            if(pictureFile==null){
                sql = "insert into messagerecord(sender_id, message_text, date,type) "
                        + "values(" + user_id + ",'" + updateMessage + "','"+getCurrentTime()+"','comment=" +relatedProID+ "')";
            }
            PreparedStatement ps = DBOperation.getPS(sql);
            // ps.setDate(1, fDate);
            if(pictureFile!=null) {
                FileInputStream file = new FileInputStream(pictureFile);
                ps.setBinaryStream(1, file, (int) (pictureFile.length()));
            }
            int s = ps.executeUpdate();
            if (s > 0) {
                System.out.println("Uploaded successfully !");
            } else {
                System.out.println("unsucessfull to upload image.");
            }
            result = ps.getGeneratedKeys();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return  result;
    }
    public static void addAndSendReportResponse(int receiver_id,int sender_id,int team_id,String message){
       ResultSet rs= addResponseReport(sender_id,team_id,message);
       try {
           if (rs.next()) {
                       MessageOperate.addMessageToUser(rs.getInt(1),receiver_id);
                       MessageOperate.sendToUser(receiver_id);
           }
       }
       catch (Exception e){
       }
    }
    public static ResultSet addResponseReport(int sender_id,int team_id,String message){
        ResultSet result=null;
        try {
            //此处为举报商品
               String sql = "insert into messagerecord(sender_id, message_text, date,type) "
                        + "values(" + sender_id + ",'" + message + "','"+getCurrentTime()+"','reportResponse=" + team_id+"')";
            PreparedStatement ps = DBOperation.getPS(sql);
            int s = ps.executeUpdate();
            if (s > 0) {
                System.out.println("Uploaded successfully !");
            } else {
                System.out.println("unsucessfull to upload image.");
            }
            result = ps.getGeneratedKeys();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return  result;
    }
    public static ResultSet addReportMessage(int team_id,int user_id,String reason,String detail,File img){
        ResultSet result=null;
        try {
            //此处为举报商品
            String sql = "insert into messagerecord(sender_id, message_text,message_picture, date,type) "
                    + "values(" + user_id+ ",'" + detail + "',?,'" + getCurrentTime() + "','report=" + team_id+"="+reason + "')";
            if(img==null){
                sql = "insert into messagerecord(sender_id, message_text, date,type) "
                        + "values(" + user_id + ",'" + detail + "','"+getCurrentTime()+"','report=" + team_id +"="+reason + "')";
            }
            PreparedStatement ps = DBOperation.getPS(sql);
            // ps.setDate(1, fDate);
            if(img!=null) {
                FileInputStream file = new FileInputStream(img);
                ps.setBinaryStream(1, file, (int) (img.length()));
            }
            int s = ps.executeUpdate();
            if (s > 0) {
                System.out.println("Uploaded successfully !");
            } else {
                System.out.println("unsucessfull to upload image.");
            }
            result = ps.getGeneratedKeys();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return  result;
    }
    public static ResultSet addActivityMessageRecord(int activity_id,String message,File img){
        ResultSet result=null;
       try {
           Activity[] activities = Activity.getActivity("select * from activity where activity_id=" + activity_id);
           int team_id = activities[0].getTeamID();

         /* java.util.Date currentTime = new java.util.Date();
           SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
           String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(currentTime);
           java.util.Date date = sdf.parse(time);
           java.sql.Timestamp ts = new java.sql.Timestamp(date.getTime());*/
             String sql = "insert into messagerecord(sender_id, message_text,message_picture, date,type) "
                     + "values(" + team_id + ",'" + message + "',?,'" + getCurrentTime() + "','activity=" + activity_id + "')";
           if(img==null){
               sql = "insert into messagerecord(sender_id, message_text, date,type) "
                       + "values(" + team_id + ",'" + message + "','"+getCurrentTime()+"','activity=" + activity_id + "')";
           }
           PreparedStatement ps = DBOperation.getPS(sql);
          // ps.setDate(1, fDate);
           if(img!=null) {
               FileInputStream file = new FileInputStream(img);
               ps.setBinaryStream(1, file, (int) (img.length()));
           }
           int s = ps.executeUpdate();
           if (s > 0) {
               System.out.println("Uploaded successfully !");
           } else {
               System.out.println("unsucessfull to upload image.");
           }
           result = ps.getGeneratedKeys();
       }
       catch (Exception e){
           e.printStackTrace();
       }
return  result;
    }
    public static void sendToAllPeople(int message_id,int activity_id){
        try {
            Map<Integer, ArrayList<MessageServer>> map = MessageServer.getWebSocketMap();
            int[] ids = Activity.getAllParticipant(activity_id);
            for (int i = 0; i < ids.length; i++) {
                int id = ids[i];
                addMessageToUser(message_id,id);
             /*  ArrayList<MessageServer> servers = map.get(id);
                if (servers == null)
                    continue;
                for (int j = 0; j < servers.size(); j++) {
                    try {
                        servers.get(j).getSendMessage().getBasicRemote().sendText("activity");
                    }
                    catch (Exception e){
                        e.printStackTrace();
                    }
                }*/
             sendToUser(id);//发送消息给在线用户
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
    public static void sendToUser(int id){
        ArrayList<MessageServer> servers=MessageServer.getWebSocketMap().get(id);
        if (servers == null)
            return;
        for (int j = 0; j < servers.size(); j++) {
            try {
                servers.get(j).getSendMessage().getBasicRemote().sendText("activity");
            }
            catch (Exception e){
                e.printStackTrace();
            }
        }
    }
    public static void addMessageToUser(int message_id,int user_id){
        try {
            String sql = "insert into message_manage(message_id,user_id)values(" + message_id + "," + user_id+")";
            DBOperation.insertOperate(sql);
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
    public static int getNewMessageNum(int user_id){
        try {
            String sql = "select message_id from message_manage where user_id=" + user_id+" and haveRead=0";
           ResultSet rs= DBOperation.getRS(sql);
            rs.last();
            return rs.getRow();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }
    public static Message[] getAllMessage(int user_id){
        Message[]messages=null;
        try {
            String sql = "select a.message_text,a.message_id,a.sender_id,a.message_picture,a.date,a.type,c.user_name,b.haveRead from " +
                    "messagerecord a inner join message_manage b on a.message_id=b.message_id inner join user c on c.user_id" +
                    "=a.sender_id where b.user_id="+user_id;
            ResultSet rs = DBOperation.getRS(sql);
            messages=Message.getMessages(rs);
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return messages;
    }
    public static Message getMessageFromId(int message_id){
        Message[] messages=null;
        try {
            String sql = "select a.message_text,a.message_id,a.sender_id,a.message_picture,a.date,a.type,c.user_name,b.haveRead from " +
                    "messagerecord a inner join message_manage b on a.message_id=b.message_id inner join user c on a.sender_id" +
                    "=c.user_id where a.message_id="+message_id;
            ResultSet rs = DBOperation.getRS(sql);
            messages=Message.getMessages(rs);
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return messages[0];
    }
    public  static void readMessage(int id,int message_id){
        try {
            String sql = "update message_manage set haveRead=1 where user_id=" + id + " and message_id=" + message_id;
            DBOperation.Update(sql);
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
   public static Message[] getHaveSendMessage(int user_id){
        Message[]messages=null;
        try {
            String sql="select * from " +
                    "messagerecord  where sender_id="+user_id;
           // String sql ="select * from message_manage where sender_id="+user_id;
            ResultSet rs = DBOperation.getRS(sql);
            messages=Message.getMessages(rs);
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return messages;
    }
    public static void deleteMessage(int id,int message_id){
        try {
            String sql = "delete from message_manage where user_id=" + id + " and message_id=" + message_id;
            DBOperation.Update(sql);
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
    public static Message[] getReportedMessage(int user_id){
        ArrayList<Message>message=new ArrayList<Message>();
        Message[] messages=MessageOperate.getAllMessage(user_id);
        if(messages==null)
            messages=new Message[0];
            for(int i=0;i<messages.length;i++){
                if(messages[i].getType().equals("report")){
                    message.add(messages[i]);
                }
            }
            messages=new Message[message.size()];
            for(int i=0;i<messages.length;i++){
                messages[i]=message.get(i);
            }
            return messages;
    }
    public static String getSchoolNameThroughID(int user_id){
        String sql="select * from user where user_id="+user_id;
        String name="";
        try {
           ResultSet rs= DBOperation.getRS(sql);
            if(rs.next()){
                if(rs.getString("user_type").equals("SCHOOL")){
                    name=rs.getString("user_school_name");
                }
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return  name;
    }
}
