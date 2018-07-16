package DataBase;

import java.sql.*;

public class DBConnect {

    private static Connection conn = null;			//连接对象

    //加载驱动，连接数据库
    public static Connection getConnection() {
        try{
            if(conn!=null)
                return conn;
            else {
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver);

//                String user = "root";
//                String password ="123456";
//                String url = "jdbc:mysql://localhost:3306/db?useUnicode=true&characterEncoding=UTF-8";
                String user = "zhangweidb%zhangwei";
                 String password = "Zhangwei123";
                 String url = "jdbc:mysql://zhangweidb.mysqldb.chinacloudapi.cn:3306/db?autoReconnect=true";

                conn = DriverManager.getConnection(url, user, password);
            }

        }catch(Exception e){
            e.printStackTrace();
        }
        return conn;
    }

    public static void close(){
     try{
     if(conn!=null) {
         conn.close();
         conn = null;
     }
    }
    catch (Exception e){
         e.printStackTrace();
     }
    }
}

