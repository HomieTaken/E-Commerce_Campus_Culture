package Operations;

import DataBase.DBOperation;
import Entity.Activity;
import Entity.CultureProduct;
import Entity.ShoppingRecord;
import com.opensymphony.xwork2.ActionContext;

import java.sql.Date;
import java.sql.ResultSet;

public class  ViewTeam {
    //teamID为团队id号，index为第几页，size为每一页活动的个数
    public static Activity[] getAllActivityies(int teamID){
        Activity[]acts=Activity.getActivity("SELECT * FROM  activity where activity_team_id="+teamID);
        return acts;
    }
    public static Activity[] getAllActivityies(int teamID,Object user_id){
        int userID=(int)user_id;
        Activity[]acts=Activity.getActivity("SELECT * FROM  activity where activity_team_id="+teamID);
        for(int i=0;i<acts.length;i++){
            if(ViewTeam.haveEntered(acts[i].getActivityID(),userID)){
                acts[i].setHaveEntered(true);
            }
        }
        return acts;
    }
    public static CultureProduct[] getAllProducts(int teamID){
        CultureProduct[]acts=CultureProduct.getProduct("SELECT * FROM  product where product_team_id="+teamID);
        return acts;
    }
    public static Activity[] getActivity(int teamID,int index,int size){
        Activity[]acts=Activity.getActivity("SELECT * FROM  activity where activity_team_id="+teamID+"  LIMIT "+index*size+","+size);
        return acts;
    }
    public static Activity[] getActBriefView(int teamID,Object user_id){//返回最近的两个活动
        int userID=(int)user_id;
        Activity[]acts=Activity.getActivity("SELECT * FROM  activity where activity_team_id="+teamID+" LIMIT 0, 4");
        for(int i=0;i<acts.length;i++){
            if(ViewTeam.haveEntered(acts[i].getActivityID(),userID)){
                acts[i].setHaveEntered(true);
            }
        }
        return acts;
    }
    public static Activity[] getActBriefView(int teamID){//返回最近的两个活动
        Activity[]acts=Activity.getActivity("SELECT * FROM  activity where activity_team_id="+teamID+" LIMIT 0, 4");
        return acts;
    }
    public static CultureProduct[] getProBriefView(int teamID){//返回最畅销的部分商品
        //返回前两条记录
        CultureProduct[]acts=CultureProduct.getProduct("SELECT * FROM  product where product_team_id="+teamID+" LIMIT 0, 4");
        return acts;
       // return null;
    }
    //teamID为团队id号，index为第几页，size为每一页商品的个数
    public static CultureProduct[] getProducts(int teamID,int index,int size){
        //取出一个页面
        CultureProduct[]acts=CultureProduct.getProduct("SELECT * FROM  product where product_team_id="+teamID+"  LIMIT "+index*size+","+size);
        return acts;
    }
    public static boolean haveEntered(int activityID,int userID){
        try {
            ResultSet rs = DBOperation.getRS("select * from activity_participant where  activity_participant_id=" + userID + " and activity_id=" + activityID);
            rs.last();
            int count=rs.getRow();
            if(count>0)
                return true;
        }
        catch (Exception ex){
            ex.printStackTrace();
        }
        return false;
    }
    public static void exitActivity(int activity_id,int user_id){
        try{
        DBOperation.Update("delete from activity_participant where activity_id ="+activity_id+" and activity_participant_id="+user_id);
    }
    catch (Exception e){
        e.printStackTrace();
        }
    }
    public static void enterActivity(int activity_id,int user_id){
        try{
            String sql="insert into activity_participant(activity_id,activity_participant_id)values( "+activity_id+","+user_id+")";
            DBOperation.insertOperate(sql);
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
    public static void sendEnterMessage(int activity_id,Object user_id){
        ResultSet rs=MessageOperate.addActivityEnterMessage((int)user_id,activity_id);
        sendAndTip(rs,activity_id,(int)user_id);
         /*   try {
                if (rs.next()) {
                    int teamID=Activity.getActivity(activity_id).getTeamID();
                    MessageOperate.addMessageToUser(rs.getInt(1),teamID);
                    MessageOperate.sendToUser(teamID);
                }
            }
            catch (Exception e){
                e.printStackTrace();
            }*/
    }
    public static void sendExitMessage(int activity_id,Object user_id){
        ResultSet rs=MessageOperate.addActivityExitMessage((int)user_id,activity_id);
        sendAndTip(rs,activity_id,(int)user_id);
      /*  try {
            if (rs.next()) {
                int teamID=Activity.getActivity(activity_id).getTeamID();
                MessageOperate.addMessageToUser(rs.getInt(1),teamID);
                MessageOperate.sendToUser(teamID);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }*/
    }
    public static void sendAndTip(ResultSet rs,int activity_id,int user_id){
        try {
            if (rs.next()) {
                int teamID=Activity.getActivity(activity_id).getTeamID();
                MessageOperate.addMessageToUser(rs.getInt(1),teamID);
                MessageOperate.sendToUser(teamID);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
}
