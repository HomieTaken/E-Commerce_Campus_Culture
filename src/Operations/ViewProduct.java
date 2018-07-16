package Operations;

import DataBase.DBOperation;
import Entity.CultureProduct;
import Entity.ShoppingRecord;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Map;

public class ViewProduct {
    public static CultureProduct viewGivenPro(int id){
        CultureProduct pro=CultureProduct.getProduct(
                "select * from product where product_id="+id)[0];
        return pro;
    }
    public static boolean addPro(String productID, int userID,int num){
        try {
            ResultSet set;
            DBOperation.getRS("start transaction");
            String str="select * from shoppingchart where product_id="+productID+" and "+"user_id="+userID;
            set=DBOperation.getRS(str);
            set.last();
            int count=set.getRow();
            if(num<=0)
                num=1;
            if(count>0){
                DBOperation.insertOperate("UPDATE shoppingchart SET amount=amount+"+num+" where product_id="
                        +productID+" and user_id="+userID);
            }
            else{
                str="insert into shoppingchart(product_id,user_id,amount) values("
                        +productID+","+userID+","+num+")";
                DBOperation.insertOperate(str);
                //DBOperation.getRS(str);
            }
            DBOperation.getRS("commit");
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }
    public static ShoppingRecord[] viewShoppingPro(int user_id){
        String sql="select a.record_id,a.user_id,a.amount,b.product_id,b.product_price,b.product_name,b.product_team_id as team_id," +
                " user.user_name as team_name from shoppingchart a inner join product b on a.product_id=b.product_id" +
                " inner join user on user.user_id=b.product_team_id where a.user_id="+user_id;
        ShoppingRecord[] records=ShoppingRecord.getRecord(sql);
        return records;
    }
    public static ShoppingRecord viewRecord(int record_id){
        String sql="select a.record_id,a.user_id,a.amount,b.product_id,b.product_price,b.product_name,b.product_team_id as team_id," +
                " user.user_name as team_name from shoppingchart a inner join product b on a.product_id=b.product_id" +
                " inner join user on user.user_id=b.product_team_id where a.record_id="+record_id;
        ShoppingRecord record=ShoppingRecord.getRecord(sql)[0];
        return record;
    }
    public static void changeRecordNum(int userID,int category,int num){
        try {
            String sql = "UPDATE shoppingchart SET amount=" + num + " WHERE user_id=" + userID + " and product_id=" + category;
            DBOperation.insertOperate(sql);
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
    public static void deleteRecord(int userID,int category){
        try {
            String sql = "delete from shoppingchart  WHERE user_id=" + userID + " and product_id=" + category;
            DBOperation.insertOperate(sql);
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
    public static String[] getUserAddress(int userID){
        String[]result=null;
        try {
            ArrayList<String>addresses=new ArrayList<String>();
            String sql = "select * from user_address where user_id=" + userID;
            ResultSet rs=DBOperation.getRS(sql);
            while(rs.next()){
                addresses.add(rs.getString("user_address"));
            }
            result=new String[addresses.size()];
            for(int i=0;i<addresses.size();i++){
                result[i]=addresses.get(i);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }
    public static void addAddress(int userID,String address){
        try {
            String sql="insert into user_address(user_id,user_address) values("
                    +userID+",'"+address+"')";
            DBOperation.insertOperate(sql);
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
}
