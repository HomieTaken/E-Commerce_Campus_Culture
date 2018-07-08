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
        /*acts[0]=new Activity();
        acts[0].setAddress("某个地方");
        acts[0].setDescription("一些描述");
        long time = System.currentTimeMillis();
        java.sql.Date date = new java.sql.Date(time);
        acts[0].setEndDate(date);
        acts[0].setReleaseDate(date);
        acts[0].setTeamID(1);

        acts[1]=new Activity();
        acts[1].setAddress("某个地方");
        acts[1].setDescription("一些描述");
        time = System.currentTimeMillis();
        date = new java.sql.Date(time);
        acts[1].setEndDate(date);
        acts[1].setReleaseDate(date);
        acts[1].setTeamID(1);*/
        return acts;
       // return null;
    }
    public static CultureProduct[] getProBriefView(int teamID){//返回最畅销的部分商品
        //返回前两条记录
        CultureProduct[]acts=CultureProduct.getProduct("SELECT * FROM  product where product_team_id="+teamID+" LIMIT 0, 4");
        /*CultureProduct[]acts=new CultureProduct[2];
        acts[0]=new CultureProduct();
        acts[0].setName("商品1");
        acts[0].setDescription("一些描述");
        acts[0].setPrice(10);
        acts[0].setTeamID(1);

        acts[1]=new CultureProduct();
        acts[1].setName("商品1");
        acts[1].setDescription("一些描述");
        acts[1].setPrice(10);
        acts[1].setTeamID(1);*/
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
