package Operations;

import DataBase.DBOperation;
import Entity.Activity;
import Entity.Message;
import Entity.ShoppingRecord;
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
   /* public static ResultSet addPurchaseMessage(int buyer_id,int product_id,int num){
        ResultSet result=null;
        try {
            java.util.Date currentTime = new java.util.Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(currentTime);
            java.util.Date date = sdf.parse(time);
            java.sql.Timestamp ts = new java.sql.Timestamp(date.getTime());
            String sql = "insert into messagerecord(sender_id,date,type,message_text) "
                    + "values(" + buyer_id + ",'"+ts+"','purchase="+product_id + "','"+num+"')";
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
    }*/
    public static ResultSet addPurchaseMessage(ShoppingRecord record,int sender_id){
        ResultSet result=null;
        try {
            java.util.Date currentTime = new java.util.Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(currentTime);
            java.util.Date date = sdf.parse(time);
            java.sql.Timestamp ts = new java.sql.Timestamp(date.getTime());
            String sql = "insert into messagerecord(sender_id, message_text, date,type) "
                    + "values(" + sender_id + ",'" + record.getAmount() + "','"+ts+"','purchase=" + record.getProductID() + "')";
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
            java.util.Date currentTime = new java.util.Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(currentTime);
            java.util.Date date = sdf.parse(time);
            java.sql.Timestamp ts = new java.sql.Timestamp(date.getTime());
            String sql = "insert into messagerecord(sender_id,date,type) "
                    + "values(" + sender_id + ",'"+ts+"','product=" + product_id + "')";
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
    public static ResultSet addActivityMessageRecord(int activity_id,String message,File img){
        ResultSet result=null;
       try {
           Activity[] activities = Activity.getActivity("select * from activity where activity_id=" + activity_id);
           int team_id = activities[0].getTeamID();

          java.util.Date currentTime = new java.util.Date();
           SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
           String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(currentTime);
           java.util.Date date = sdf.parse(time);
           java.sql.Timestamp ts = new java.sql.Timestamp(date.getTime());
           String sql = "insert into messagerecord(sender_id, message_text,message_picture, date,type) "
                   + "values(" + team_id + ",'" + message + "',?,'"+ts+"','activity=" + activity_id + "')";
           if(img==null){
               sql = "insert into messagerecord(sender_id, message_text, date,type) "
                       + "values(" + team_id + ",'" + message + "','"+ts+"','activity=" + activity_id + "')";
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
                    "messagerecord a inner join message_manage b on a.message_id=b.message_id inner join user c on a.sender_id" +
                    "=c.user_id where b.user_id="+user_id;
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
}
