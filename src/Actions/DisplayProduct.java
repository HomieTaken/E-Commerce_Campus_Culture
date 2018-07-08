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
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

public class DisplayProduct extends ActionSupport  {

    private ArrayList<CultureProduct> products = new ArrayList<>();

    @Override
    public String execute() throws Exception {


        ResultSet rs = DBOperation.getRS("select product_id from product");
        ArrayList<Integer> array = new ArrayList<>();
      while(rs.next())
      {
          array.add(rs.getInt("product_id"));
      }
      DBOperation.close();
        int []randomArray = randomCommon(0,array.size(),6);
        ArrayList<String> imgUrls = new ArrayList<>();
        assert randomArray != null;
        for(int i = 0; i<randomArray.length; i++)
        {
            ResultSet rs1 = DBOperation.getRS("select * from product where product_id = "+array.get(randomArray[i])  );
            CultureProduct product = new CultureProduct();
            String url = "";
            if(rs1.next())
            {
                product.setProductID(array.get(randomArray[i]));
              //  System.out.println(randomArray[i]);
                product.setDescription(rs1.getString("product_info"));
               // System.out.println(rs1.getString("product_info"));
                product.setPicture(rs1.getBlob("product_img"));//some
                //System.out.println(rs1.getBlob("product_img"));
                url = Blob2Img(rs1.getBlob("product_img"),array.get(randomArray[i]));
                product.setName(rs1.getString("product_name"));
                product.setPrice(rs1.getDouble("product_price"));
                //System.out.println(rs1.getDouble("product_price"));
                product.setTeamID(rs1.getInt("product_team_id"));
                //System.out.println(rs1.getInt("product_team_id"));

            }
            DBOperation.close();
            products.add(product);
            System.out.println(url);
            imgUrls.add(url);
        }

        ActionContext actionContext = ActionContext.getContext();
        Map<String, Object> session = actionContext.getSession();
        session.put("products",products);
        session.put("urls",imgUrls);
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

    public static String Blob2Img(Blob blob,int product_id)
    {

        if(blob == null)
            return "#";
        String s = "img/"+product_id + ".jpg";
        String s1 =  ServletActionContext.getServletContext().getRealPath("/")+"img/"+product_id + ".jpg";

        try{
            File file = new File(s1);
            if(!file.exists()){
                file.createNewFile();
            }
            else
                return s;
            OutputStream outputStream = new FileOutputStream(file);
            outputStream.write(blob.getBytes(1,(int)blob.length()));
            outputStream.close();

        } catch (IOException | SQLException e){
            e.printStackTrace();
        }
        return s;
    }


}
