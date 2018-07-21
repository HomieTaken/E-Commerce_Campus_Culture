package Actions;

/*
   商品的展示,
   规则:未知(暂时随机),
   从数据库获取
 */

import java.io.*;
import java.sql.*;
import java.util.*;

import Entity.CultureProduct;

import DataBase.*;
import Entity.User;
import Entity.UserType;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

public class DisplayProduct extends ActionSupport  {

    private ArrayList<CultureProduct> products = new ArrayList<>();

    private ArrayList<User> teams = new ArrayList<>();

    @Override
    public String execute() throws Exception {


        ResultSet rs = DBOperation.getRS("select product_id from product");
        ArrayList<Integer> array = new ArrayList<>();
        while(rs.next())
        {
            array.add(rs.getInt("product_id"));
        }
        int []randomArray = randomCommon(0,array.size(),6);
        assert randomArray != null;
        for(int i = 0; i<randomArray.length; i++)
        {
            ResultSet rs1 = DBOperation.getRS("select * from product where product_id = "+array.get(randomArray[i])  );
            CultureProduct product = new CultureProduct();
            if(rs1.next())
            {
                product.setProductID(array.get(randomArray[i]));
                //  System.out.println(randomArray[i]);
                product.setDescription(rs1.getString("product_info"));
                // System.out.println(rs1.getString("product_info"));
                product.setPicture(rs1.getBlob("product_img"));//some
                //System.out.println(rs1.getBlob("product_img"));
                product.setName(rs1.getString("product_name"));
                product.setPrice(rs1.getDouble("product_price"));
                product.setAmount(rs1.getInt("product_sales"));
                //System.out.println(rs1.getDouble("product_price"));
                product.setTeamID(rs1.getInt("product_team_id"));
                //System.out.println(rs1.getInt("product_team_id"));
            }
            products.add(product);
        }



        ResultSet rs1 = DBOperation.getRS("select user_id from user where user_type = 'TEAM'");
        ArrayList<Integer> array1 = new ArrayList<>();
        while(rs1.next())
        {
            array1.add(rs1.getInt("user_id"));
        }
        int []randomArray1 = randomCommon(0,array1.size(),6);
        assert randomArray1 != null;
        for(int i = 0; i<randomArray1.length; i++)
        {
            ResultSet rs2 = DBOperation.getRS("select * from user where user_id = '"+array1.get(randomArray1[i])+" '"  );
            User team = new User();
            if(rs2.next())
            {
                team.setId(rs2.getInt("user_id"));
                System.out.println("user_id="+rs2.getInt("user_id"));
                team.setUserEmail(rs2.getString("user_email"));
                team.setUserName(rs2.getString("user_name"));
                team.setUserType(UserType.TEAM);
            }
            DBOperation.close();
            teams.add(team);
        }

        ActionContext actionContext = ActionContext.getContext();
        Map<String, Object> session = actionContext.getSession();
        session.put("products",products);
        session.put("teams",teams);
        return "success";

    }
    public static int[] randomCommon(int min, int max, int n)//产生一定范围的不同随机数
    {
        if (n > (max - min + 1) || max < min) {
            return null;
        }
        int[] result = new int[n];
        int count = 0;
        while(count < n) {
            int num = (int) (Math.random() * (max - min)) + min;
            boolean flag = true;
            for (int j = 0; j < n; j++) {
                if(num == result[j]){
                    flag = false;
                    break;
                }
            }
            if(flag){
                result[count] = num;
                count++;
            }
        }
        return result;
    }

}
