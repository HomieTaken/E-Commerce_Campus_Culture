package Operations;

import Entity.Activity;
import Entity.CultureProduct;

import java.sql.Date;

public class  ViewTeam {
    //teamID为团队id号，index为第几页，size为每一页活动的个数
    public static Activity[] getActivity(int teamID,int index,int size){
        Activity[]acts=Activity.getActivity("SELECT * FROM  activity where activity_team_id="+teamID+"  LIMIT "+index*size+","+size);
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
}
